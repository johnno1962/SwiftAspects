//
//  Xtrace+Swift.m
//  SwiftAspects
//
//  Created by John Holdsworth on 21/06/2014.
//  Copyright (c) 2014 John Holdsworth. All rights reserved.
//

#import "Xtrace.h"
#import <map>

#import <AssertMacros.h>
#import <libkern/OSAtomic.h>

#import <mach/vm_types.h>
#import <mach/vm_map.h>
#import <mach/mach_init.h>

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#import <UIKit/UIKit.h>
#endif

/*

 The following implementation of imp_implementationForwardingToSelector() is
 from https://github.com/OliverLetterer/imp_implementationForwardingToSelector
 altered to provide generic trampolines for swift methods providing the missing
 meta data taken from the associated Objective-C method implementation.

 Copyright (c) 2014 Oliver Letterer <oliver.letterer@gmail.com>

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.static OSSpinLock lock = OS_SPINLOCK_INIT;

*/

extern char xt_forwarding_trampoline_page, xt_forwarding_trampolines_start, xt_forwarding_trampoline_stret_page;

static OSSpinLock lock = OS_SPINLOCK_INIT;

typedef struct {
    XTRACE_SIMP tracer;
    struct _xtrace_info *info;
} XtraceTrampolineDataBlock;

#if defined(__i386__)
typedef int32_t SPLForwardingTrampolineEntryPointBlock[2];
static const int32_t SPLForwardingTrampolineInstructionCount = 8;
#elif defined(_ARM_ARCH_7)
typedef int32_t SPLForwardingTrampolineEntryPointBlock[2];
static const int32_t SPLForwardingTrampolineInstructionCount = 10;
#undef PAGE_SIZE
#define PAGE_SIZE (1<<12)
#else
#error SPLMessageLogger is not supported on this platform
#endif

static const size_t numberOfTrampolinesPerPage = (PAGE_SIZE - SPLForwardingTrampolineInstructionCount * sizeof(int32_t)) / sizeof(SPLForwardingTrampolineEntryPointBlock);

typedef struct {
    union {
        struct {
            int32_t nextAvailableTrampolineIndex;
        };
        int32_t trampolineSize[SPLForwardingTrampolineInstructionCount];
    };

    XtraceTrampolineDataBlock trampolineData[numberOfTrampolinesPerPage];

    int32_t trampolineInstructions[SPLForwardingTrampolineInstructionCount];
    SPLForwardingTrampolineEntryPointBlock trampolineEntryPoints[numberOfTrampolinesPerPage];
} SPLForwardingTrampolinePage;

check_compile_time(sizeof(SPLForwardingTrampolineEntryPointBlock) == sizeof(XtraceTrampolineDataBlock));
check_compile_time(sizeof(SPLForwardingTrampolinePage) == 2 * PAGE_SIZE);
check_compile_time(offsetof(SPLForwardingTrampolinePage, trampolineInstructions) == PAGE_SIZE);

static SPLForwardingTrampolinePage *SPLForwardingTrampolinePageAlloc(BOOL useObjcMsgSendStret)
{
    vm_address_t trampolineTemplatePage = useObjcMsgSendStret ? (vm_address_t)&xt_forwarding_trampoline_stret_page : (vm_address_t)&xt_forwarding_trampoline_page;

    vm_address_t newTrampolinePage = 0;
    kern_return_t kernReturn = KERN_SUCCESS;

    // allocate two consequent memory pages
    kernReturn = vm_allocate(mach_task_self(), &newTrampolinePage, PAGE_SIZE * 2, VM_FLAGS_ANYWHERE);
    NSCAssert1(kernReturn == KERN_SUCCESS, @"vm_allocate failed", kernReturn);

    // deallocate second page where we will store our trampoline
    vm_address_t trampoline_page = newTrampolinePage + PAGE_SIZE;
    kernReturn = vm_deallocate(mach_task_self(), trampoline_page, PAGE_SIZE);
    NSCAssert1(kernReturn == KERN_SUCCESS, @"vm_deallocate failed", kernReturn);

    // trampoline page will be remapped with implementation of spl_objc_forwarding_trampoline
    vm_prot_t cur_protection, max_protection;
    kernReturn = vm_remap(mach_task_self(), &trampoline_page, PAGE_SIZE, 0, 0, mach_task_self(), trampolineTemplatePage, FALSE, &cur_protection, &max_protection, VM_INHERIT_SHARE);
    NSCAssert1(kernReturn == KERN_SUCCESS, @"vm_remap failed", kernReturn);

    return (SPLForwardingTrampolinePage *)newTrampolinePage;
}

static SPLForwardingTrampolinePage *nextTrampolinePage(BOOL returnStructValue)
{
    static NSMutableArray *normalTrampolinePages = nil;
    static NSMutableArray *structReturnTrampolinePages = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        normalTrampolinePages = [NSMutableArray array];
        structReturnTrampolinePages = [NSMutableArray array];
    });

    NSMutableArray *thisArray = returnStructValue ? structReturnTrampolinePages : normalTrampolinePages;

    SPLForwardingTrampolinePage *trampolinePage = (SPLForwardingTrampolinePage *)[thisArray.lastObject pointerValue];

    if (!trampolinePage || (trampolinePage->nextAvailableTrampolineIndex == numberOfTrampolinesPerPage) ) {
        trampolinePage = SPLForwardingTrampolinePageAlloc(returnStructValue);
        [thisArray addObject:[NSValue valueWithPointer:trampolinePage]];
    }

    return trampolinePage;
}

static XTRACE_SIMP imp_implementationForwardingToTracer(struct _xtrace_info *info, XTRACE_SIMP tracer,BOOL returnStructValue)
{
    OSSpinLockLock(&lock);

    SPLForwardingTrampolinePage *dataPageLayout = nextTrampolinePage(returnStructValue);

    int32_t nextAvailableTrampolineIndex = dataPageLayout->nextAvailableTrampolineIndex;

    dataPageLayout->trampolineData[nextAvailableTrampolineIndex].info = info;
    dataPageLayout->trampolineData[nextAvailableTrampolineIndex].tracer = tracer;
    dataPageLayout->nextAvailableTrampolineIndex++;

    XTRACE_SIMP implementation = (XTRACE_SIMP)&dataPageLayout->trampolineEntryPoints[nextAvailableTrampolineIndex];
    
    OSSpinLockUnlock(&lock);

    return implementation;
}

/* end imp_implementationForwardingToSelector() implementation */

@implementation Xtrace(Swift)

+ (void)forSwiftClass:(Class)aClass before:(SEL)sel callbackBlock:callback {
    CGRectMake(1, 2, 3, 4);
    if ( ![self infoFor:aClass sel:sel]->name )
        [self parseSwiftClass:aClass];
    if ( ![self infoFor:aClass sel:sel]->name )
        NSLog( @"Invalid selector %s", sel_getName(sel) );
    else
        [self infoFor:aClass sel:sel]->beforeBlock = XTRACE_BRIDGE(XTRACE_BIMP)CFRetain( XTRACE_BRIDGE(CFTypeRef)callback );
}

+ (void)forSwiftClass:(Class)aClass after:(SEL)sel callbackBlock:callback {
    if ( ![self infoFor:aClass sel:sel]->name )
        [self parseSwiftClass:aClass];
    if ( ![self infoFor:aClass sel:sel]->name )
        NSLog( @"Invalid selector %s", sel_getName(sel) );
    else
        [self infoFor:aClass sel:sel]->afterBlock = XTRACE_BRIDGE(XTRACE_BIMP)CFRetain( XTRACE_BRIDGE(CFTypeRef)callback );
}

#define ARG_SIZE (sizeof(id) + sizeof(SEL) + sizeof(void *)*9) // approximate to say the least..

#ifdef __LP64__
#define ARG_DEFS void *a0, void *a1, void *a2, void *a3, void *a4, void *a5, void *a6, void *a7, void *a8, void *a9, double d0, double d1, double d2, double d3, double d4, double d5, double d6, double d7
#define ARG_COPY a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, d0, d1, d2, d3, d4, d5, d6, d7
#elif defined(_ARM_ARCH_7)
#define ARG_DEFS void *a0, void *a1, void *a2, void *a3, void *r7, void *lr, void *a4, void *a5, void *a6, void *a7, void *a8, void *a9, void *aa, void *ab, void *ac, void *ad, void *ae, void *af
#define ARG_COPY a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, aa, ab, ac, ad, ae, af
#else
#define ARG_DEFS void *a0, void *a1, void *a2, void *a3, void *a4, void *a5, void *a6, void *a7, void *a8, void *a9, void *aa, void *ab, void *ac, void *ad, void *ae, void *af
#define ARG_COPY a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, aa, ab, ac, ad, ae, af
#endif

#define NEW_ARGS struct _xtrace_info *info, XtraceTrampolineDataBlock *block, void *framePointer, void *returnAddress

static void xtrace_void( NEW_ARGS, ARG_DEFS ) {
    //NSLog( @"%p %p %p %p %p", &info, a0, a1, a2, a3 );
    struct _xtrace_call call = { info, nil, NULL, 0 };
    struct _xtrace_info &orig = *xtFindOriginal( &call, NULL, ARG_COPY );

    if ( !orig.callingBack ) {
        if ( orig.before ) {
            orig.callingBack = YES;
            orig.before( xtraceDelegate, call.sel, call.obj, ARG_COPY );
            orig.callingBack = NO;
        }
        if ( orig.beforeBlock ) {
            orig.callingBack = YES;
            orig.beforeBlock( call.obj, call.sel, ARG_COPY );
            orig.callingBack = NO;
        }
    }

    orig.swiftOriginal( ARG_COPY );

    if ( !orig.callingBack ) {
        if ( orig.after ) {
            orig.callingBack = YES;
            orig.after( xtraceDelegate, call.sel, call.obj, ARG_COPY );
            orig.callingBack = NO;
        }
        if ( orig.afterBlock ) {
            orig.callingBack = YES;
            orig.afterBlock( call.obj, call.sel, ARG_COPY );
            orig.callingBack = NO;
        }
    }

    xtReturning( &orig );
}

template <typename _type>
static _type XTRACE_RETAINED xtrace_type( NEW_ARGS, ARG_DEFS ) {
    //NSLog( @"%p %p %p %p %p", &info, a0, a1, a2, a3 );
    struct _xtrace_call call = { info, nil, NULL, 0 };
    struct _xtrace_info &orig = *xtFindOriginal( &call, NULL, ARG_COPY );

    if ( !orig.callingBack ) {
        if ( orig.before ) {
            orig.callingBack = YES;
            orig.before( xtraceDelegate, call.sel, call.obj, ARG_COPY );
            orig.callingBack = NO;
        }
        if ( orig.beforeBlock ) {
            orig.callingBack = YES;
            orig.beforeBlock( call.obj, call.sel, ARG_COPY );
            orig.callingBack = NO;
        }
    }

    typedef _type (*TIMP)( void *dummy, ... );
    TIMP impl = (TIMP)orig.swiftOriginal;
    _type out = impl( ARG_COPY );

    if ( !orig.callingBack ) {
        if ( orig.after ) {
            orig.callingBack = YES;
            impl = (TIMP)orig.after;
            out = impl( XTRACE_BRIDGE(void *)xtraceDelegate, call.sel, out, call.obj, ARG_COPY );
            orig.callingBack = NO;
        }
        if ( orig.afterBlock ) {
            typedef _type (^BTIMP)( XTRACE_UNSAFE id obj, SEL sel, _type out, ... );
            orig.callingBack = YES;
            BTIMP timpl = (BTIMP)orig.afterBlock;
            out = timpl( call.obj, call.sel, out, ARG_COPY );
            orig.callingBack = NO;
        }
    }

    xtReturning( &orig, out );
    return out;
}

template <typename _type>
static double XTRACE_RETAINED xtrace_double( NEW_ARGS, ARG_DEFS ) {
    //NSLog( @"%p %p %p %p %p", &info, a0, a1, a2, a3 );
    struct _xtrace_call call = { info, nil, NULL, 0 };
    struct _xtrace_info &orig = *xtFindOriginal( &call, NULL, ARG_COPY );

    if ( !orig.callingBack ) {
        if ( orig.before ) {
            orig.callingBack = YES;
            orig.before( xtraceDelegate, call.sel, call.obj, ARG_COPY );
            orig.callingBack = NO;
        }
        if ( orig.beforeBlock ) {
            orig.callingBack = YES;
            orig.beforeBlock( call.obj, call.sel, ARG_COPY );
            orig.callingBack = NO;
        }
    }

    typedef double (*SIMP)( void *dummy, ... );
    SIMP simpl = (SIMP)orig.swiftOriginal;
    union {
        _type out;
        double out1;
    } outs;
    outs.out1 = simpl( ARG_COPY );

    if ( !orig.callingBack ) {
        if ( orig.after ) {
            typedef _type (*TIMP)( void *dummy, ... );
            orig.callingBack = YES;
            TIMP timpl = (TIMP)orig.after;
            outs.out = timpl( XTRACE_BRIDGE(void *)xtraceDelegate, call.sel, outs.out, call.obj, ARG_COPY );
            orig.callingBack = NO;
        }
        if ( orig.afterBlock ) {
            typedef _type (^BTIMP)( XTRACE_UNSAFE id obj, SEL sel, _type out, ... );
            orig.callingBack = YES;
            BTIMP bimpl = (BTIMP)orig.afterBlock;
            outs.out = bimpl( call.obj, call.sel, outs.out, ARG_COPY );
            orig.callingBack = NO;
        }
    }

    xtReturning( &orig, outs.out );
    return outs.out1;
}

#if defined(_ARM_ARCH_7)
#undef ARG_DEFS
#define ARG_DEFS void *a0, void *a1, void *a2, void *r7, void *lr, void *a3, void *a4, void *a5, void *a6, void *a7, void *a8, void *a9, void *aa, void *ab, void *ac, void *ad, void *ae, void *af
#endif

template <typename _type>
static void XTRACE_RETAINED xtrace_struct( NEW_ARGS, _type *out, ARG_DEFS ) {
    //NSLog( @"%p %p %p %p %p %p", &info, out, a0, a1, a2, a3 );
    struct _xtrace_call call = { info, nil, NULL, 0 };
    struct _xtrace_info &orig = *xtFindOriginal( &call, NULL, ARG_COPY );

    if ( !orig.callingBack ) {
        if ( orig.before ) {
            orig.callingBack = YES;
            orig.before( xtraceDelegate, call.sel, call.obj, ARG_COPY );
            orig.callingBack = NO;
        }
        if ( orig.beforeBlock ) {
            orig.callingBack = YES;
            orig.beforeBlock( call.obj, call.sel, ARG_COPY );
            orig.callingBack = NO;
        }
    }

    typedef _type (*SIMP)( void *dummy, ... );
    SIMP simpl = (SIMP)orig.swiftOriginal;
    *out = simpl( ARG_COPY );

    if ( !orig.callingBack ) {
        if ( orig.after ) {
            typedef _type (*TIMP)( void *dummy, ... );
            orig.callingBack = YES;
            TIMP timpl = (TIMP)orig.after;
            *out = timpl( XTRACE_BRIDGE(void *)xtraceDelegate, call.sel, *out, call.obj, ARG_COPY );
            orig.callingBack = NO;
        }
        if ( orig.afterBlock ) {
            typedef _type (^BTIMP)( XTRACE_UNSAFE id obj, SEL sel, _type out, ... );
            orig.callingBack = YES;
            BTIMP bimpl = (BTIMP)orig.afterBlock;
            *out = bimpl( call.obj, call.sel, *out, ARG_COPY );
            orig.callingBack = NO;
        }
    }

    xtReturning( &orig, *out );
}

template <typename _type>
struct _xtrace_opt {
    _type val;
    char noValue;
} ;

struct _swift_class {
    Class meta;
    Class supr;
    void *buckets, *vtable, *pdata;
    int f1, f2; // added for Beta5
    int size, tos, mdsize, eight;
    struct _swift_data {
        unsigned long flags;
        const char *className;
        int fieldcount, flags2;
        const char *ivarNames;
        struct _swift_field **(*get_field_data)();
    } *swiftData;
    XTRACE_SIMP dispatch[1];
};

+ (void)swiftIntercept:(Class)aClass info:(struct _xtrace_info *)info {
    struct _swift_class *sClass = XTRACE_BRIDGE(struct _swift_class *)aClass;

    // check this is swift class
    if ( !((unsigned long)sClass->pdata & 1) )
        return;

    const char *name = info->name;
    const char *type = info->type;
    const char *className = class_getName(aClass);

    XTRACE_SIMP newImpl = NULL;
    switch ( type[0] == 'r' ? type[1] : type[0] ) {

#if defined(__i386__)
#define XTRACE_X xtrace_type
#else
#define XTRACE_X xtrace_double
#endif
#define IMPLS( _func, _type ) \
    { newImpl = type[-1] == 'S' && (type[-2] == 'q' || type[-2] == 'Q') ? \
        (XTRACE_SIMP)XTRACE_X<struct _xtrace_opt<_type> > : \
        (XTRACE_SIMP)_func<_type>; break; }

        case 'V':
        case 'v': newImpl = (XTRACE_SIMP)xtrace_void; break;

        case 'B': IMPLS( xtrace_type, bool ); break;
        case 'C':
        case 'c': IMPLS( xtrace_type, char ); break;
        case 'S':
        case 's': IMPLS( xtrace_type, short ); break;
        case 'I':
        case 'i': IMPLS( xtrace_type, int ); break;
        case 'Q':
        case 'q':
#ifndef __LP64__
            IMPLS( xtrace_type, long long ); break;
#endif
        case 'L':
        case 'l': IMPLS( xtrace_type, long ); break;
        case 'f': IMPLS( xtrace_type, float ); break;
        case 'd': IMPLS( xtrace_type, double ); break;
        case '#':
        case 'o': case '0': // swift
        case '@': newImpl = (XTRACE_SIMP)xtrace_type<id>; break;
        case '^': IMPLS( xtrace_type, void * ); break;
        case ':': IMPLS( xtrace_type, SEL ); break;
        case '*': IMPLS( xtrace_type, char * ); break;
        case '{':
            if ( xtHasPrefix(type,"{_NSRange") )
                IMPLS( XTRACE_X, NSRange )
#ifndef __IPHONE_OS_VERSION_MIN_REQUIRED
            else if ( xtHasPrefix(type,"{_NSRect") )
                IMPLS( xtrace_struct, NSRect )
            else if ( xtHasPrefix(type,"{_NSPoint") )
                IMPLS( XTRACE_X, NSPoint )
            else if ( xtHasPrefix(type,"{_NSSize") )
                IMPLS( XTRACE_X, NSSize )
#endif
            else if ( xtHasPrefix(type,"{CGPoint") )
                IMPLS( XTRACE_X, CGPoint )
            else if ( xtHasPrefix(type,"{CGSize") )
                IMPLS( XTRACE_X, CGSize )
            else if ( xtHasPrefix(type,"{CGRect") )
                IMPLS( xtrace_struct, CGRect )
            else if ( xtHasPrefix(type,"{CGAffineTransform") )
                IMPLS( xtrace_struct, CGAffineTransform )
            else
                NSLog( @"Invalid struct type: %s", type );
            break;
        default:
            NSLog(@"Xtrace: Unsupported return type: %s for: %s[%s %s]", type, info->mtype, className, name);
    }

    if ( newImpl && !info->swiftOriginal ) {
        XTRACE_SIMP *vptr = (XTRACE_SIMP *)((char *)sClass+info->vtableOffset);
        //NSLog( @"%s %s %s %p", name, type, [self symbolName:(void *)newImpl], vptr );
        info->swiftOriginal = *vptr;
#if defined(__i386__)
        BOOL isStret = xtHasPrefix(type,"{CGRect") || xtHasPrefix(type,"{CGAffineTransform");
#else
        BOOL isStret = type[0] == '{';
#endif
        *vptr = imp_implementationForwardingToTracer(info, newImpl, isStret);
    }
}

+ (BOOL)parseSwiftClass:(Class)aClass {
    struct _swift_class *sClass = XTRACE_BRIDGE(struct _swift_class *)aClass;

    unsigned ic;
    Ivar *ivars = class_copyIvarList(aClass, &ic);
    for ( unsigned i=0 ; i<ic ; i++ ) {
        const char *type = ivar_getTypeEncoding(ivars[i]);
        NSLog( @"type: %s %td",  type, ivar_getOffset(ivars[i]) );
    }

    // check this is swift class
    if ( !((unsigned long)sClass->pdata & 1) )
        return FALSE;

    for ( XTRACE_SIMP *vptr = sClass->dispatch,
         *vend = ((XTRACE_SIMP *)((char *)sClass+sClass->mdsize))-sClass->swiftData->fieldcount-2 ;
         vptr<vend ; vptr++ ) {

        char *sym = [self symbolName:(void *)*vptr];
        if ( !sym )
            continue;

        //NSLog( @"%s %d %p", sym, info.vtableOffset, vptr );

        // skip module & class
        sym = [self skip:sym expected:"_TFC"];
        sym = [self nextName:sym into:NULL];
        sym = [self nextName:sym into:NULL];

        if ( !isdigit(*sym) )
            continue;

        [self parseMangledSymbol:sym forClass:aClass atOffset:(char *)vptr - (char *)sClass];
    }

    return TRUE;
}

+ (void)parseMangledSymbol:(char *)sym forClass:(Class)aClass atOffset:(unsigned)vtableOffset {
    struct _xtrace_info info;
    memset(&info, 0, sizeof info);

    char *selptr = (char *)malloc(strlen(sym)+1);
    struct _xtrace_arg *aptr = info.args;

    info.vtableOffset = vtableOffset;
    info.name = selptr;

    aptr->name = selptr;
    sym = [self nextName:sym into:&selptr];

    if ( sym[1] == 'M' ) {
        // class method
        sym = [self skip:sym expected:"fMS0_FT"];
        info.mtype = "+";
    }
    else {
        // instance method
        sym = [self skip:sym expected:"fS0_FT"];
        info.mtype = "";
    }

    if ( *sym == '_' )
        aptr->type = NULL;
    else
        while ( true ) {
            *selptr++ = ':';

            // optional type
            BOOL isG = *sym == 'G';
            if ( isG )
                sym += 3;

            // object type
            if ( *sym == 'C' ) {
                aptr->type = sym+2;
                sym+=3;
                sym = [self nextName:sym into:NULL];
            }
            // struct type
            else if ( *sym == 'V' ) {
                sym = [self skip:sym expected:"VSC"];
                int len = 0;
                while ( isdigit(*sym) ) {
                    len = len*10 + *sym-'0';
                    sym++;
                }
                aptr->type = &(sym[-1] = '{');
                sym += len;
            }
            // builtin type
            else {
                aptr->type = sym+1;
                sym+=2;
            }

            // end optional
            if ( isG )
                sym += 1;

            if ( *sym == '_' )
                break;

            // next selector
            aptr++;
            aptr->name = selptr;
            sym = [self nextName:sym into:&selptr];
        }

    *selptr = '\000';
    aptr[1].name = selptr;

    //NSLog( @"%s", sym );
    if ( sym[1] == 'T' )
        info.type = &(sym[2] = 'v');
    else if ( sym[1] == 'V' ) {
        sym = [self skip:sym expected:"_VSC"];
        while ( isdigit(*sym) )
            sym++;
        info.type = &(sym[-1] = '{');
    }
    else if ( sym[2] == 'G' )
        info.type = sym+6;
    else
        info.type = sym+2;

    info.aClass = aClass;

    *[self infoFor:aClass sel:sel_registerName(info.name)] = info;
}

+ (char *)skip:(char *)ptr expected:(const char *)expected {
    size_t len = strlen(expected);
    if ( strncmp(ptr,expected,len) == 0 )
        return ptr+len;
    NSLog( @"not expected: %s c.f. %s", expected, ptr );
    return ptr;
}

+ (char *)nextName:(char *)ptr into:(char **)out {
    int len = atoi(ptr);
    while ( isdigit(*ptr) )
        ptr++;
    while ( len-- ) {
        if ( out )
            *(*out)++ = *ptr;
        ptr++;
    }
    if ( out )
        **out = '\000';
    return ptr;
}

#if 0
+ (void)load {
    SPLForwardingTrampolinePage *x = 0;
    NSLog(@"%d %d", (char *)x->trampolineData - (char *)x,
          &xt_forwarding_trampolines_start-&xt_forwarding_trampoline_page);
}
#endif

@end
