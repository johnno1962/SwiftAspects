#ifndef __i386__

#include <arm/arch.h>
#if defined(_ARM_ARCH_7)
# GENERATED CODE - DO NOT EDIT"
# This file was generated by /Users/oliver/Development/trash/plblockimp/Other Sources/gentramp.sh on Sat Mar 22 21:49:09 CET 2014

# Write out the trampoline table, aligned to the page boundary
.text
.align 12
.globl _xt_forwarding_trampoline_page
.globl _xt_forwarding_trampoline_stret_page
.globl _xt_forwarding_trampolines_start

_xt_forwarding_trampoline_stret_page:
_xt_forwarding_trampoline_page:
_xt_forwarding_trampoline:
	push {r7, lr}           // save frame potinter and return addresss
	mov	r7, sp              // set up new frame
    push {r0, r1, r2, r3}   // save first four args on stack
    sub r12, #0x1000        // r12 = r12 - 4096, that is where the data for this trampoline is stored
    mov r1, r12             // second arg is data block
    ldr r0, [r12, #-4]      // first arg is user data ptr
    ldr r12, [r12, #-8]     // get potinter to hander func
    blx r12                 // branch directly to r12, which now contains the address to objc_msgSend
	mov	sp, r7              // unwind stack
	pop	{r7, pc}            // restore frame and return

_xt_forwarding_trampolines_start:
# Save pc+8 into r12, then jump to the actual trampoline implementation
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;

# Next trampoline entry point
mov r12, pc
b _xt_forwarding_trampoline;
#endif
#endif
