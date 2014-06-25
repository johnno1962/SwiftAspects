## ![Icon](http://injectionforxcode.johnholdsworth.com/clamp.jpg) Experiments in Aspects with Swift

This project is an experiment to see if you can trace and inject "aspects" 
to run before an after methods into Swift code. Aspects are a more structured 
approach to using method swizzling. Before you get at all excited this is a 
solution for 32 bits only in the simulator or device. 64 bit ABIs are 
register based and beyond me to get running.

It also has to be mentioned that any swift class that inherits from NSObject
messages the old way anyway and does not use the class' new vtable and the
old approaches using ["Xtrace"](https://github.com/johnno1962/Xtrace) or 
["Aspects"](https://github.com/steipete/Aspects) will still work fine. So,
frankly this is of questionable utility but if you are working with pure Swift
classes that are not final and as a result inlined they can be swizzled to 
augment their implementation.

This time round an assembly language "trampoline" is required to inject
a pointer with meta information about the method call into the function
arguments so the stack can be parsed correctly for tracing. This is
required even if you are just swizzling as swift methods have "self" 
last in the argument list. This was taken from a component of the 
["SPLMessageLogger"](https://github.com/OliverLetterer/imp_implementationForwardingToSelector)
project under MIT license.

There is very little meta data in a pure Swift class as revealed by the
"-emit-assembly" compiler option so the mangled symbol name of the function 
implementing the method is parsed to extract the arguments and their types
to recover a selector name which can be used to manage the swizzle.

Methods can have either a "before" or "after" swizzles applied.
"After" swizzles for methods that return a result able to modify
the result's value on the way through. To swizzle from swift
bring Xtrace.{h,mm} and Xtrace+Swift.mm into your project and 
import "Xtrace.h" into your bridging header.

Swizzles are supplied as closures with aguments shadowing the
types of the method being swizzled (optionals are an extra int
after the argument.) For example, for the pure swift class:

    class S111 {
        func a2(i:Int?, j:Int) -> CGRect {
            println( "S111.a2: \(i!) \(j)" );
            return CGRectMake(1, 2, 3, 4)
        }
    }

    var s: S111 = S111()

    Xtrace.traceInstance(s)

You can use the following swizzles in swift language:

    Xtrace.forSwiftClass(object_getClass(s), before:"a2:j:", callbackBlock:blockConvert({
        (obj:AnyObject?, sel:Selector, i1:CInt, _i1:CInt, i2:CInt) in
        println( "Before.a2 \(i1) \(i2)" )
    }))

    Xtrace.forSwiftClass(object_getClass(s), after:"a2:j:", callbackBlock:blockConvertRect({
        (obj:AnyObject?, sel:Selector, out1:CGRect, i1:CInt, _i1:CInt, i22:CInt) in
        println( "After.a2 \(i1) \(i22)" )
        var a = out1
        a.origin.x = 101
        return a
    }))

Closures are very strongly typed in swift and can not be cast to
"AnyObject" (as yet) so a generic swizzling api can not be called.
Therefore, you will need to add the following to your project's bridging header:

    static inline id blockConvert( void (^aBlock)( id, SEL, int, int, int) ) {
        return aBlock;
    }

    static inline id blockConvertRect( CGRect (^aBlock)( id, SEL, CGRect, int, int, int) ) {
        return aBlock;
    }

After that, as you can see from this example project all method
calls on instance "s" of class S111 will be traced and the swizzles
called before and after method "a2:j:" is called. Like I say this
isn't that useful as almost all swift classes are going to inherit
from an NSObject subclass for the forseeable. It was more a case 
of seeing if it could be done and to learn a bit of swift ;)

If you encounter a method signature that doesn't work or if you have 
some luck porting the code to 64 bits let me know either raising a 
github issue or by email on swift at johnholdsworth.com. There are
a few limitations such as swift strings coming out as unsigned
shorts as they can not be expressed in Objective-C but the 
approach works.

### More than ever:

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
