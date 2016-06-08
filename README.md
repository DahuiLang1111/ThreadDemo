# ThreadDemo
一、NSThread  
优点：NSThread 比其他两个轻量级
缺点：需要自己管理线程的生命周期，线程同步。线程同步对数据的加锁会有一定的系统开销
使用：
方式①：- (id)initWithTarget:(id)target selector:(SEL)selector object:(id)argument 
方式②：+ (void)detachNewThreadSelector:(SEL)aSelector toTarget:(id)aTarget withObject:(id)anArgument



二、NSOperation  
优点：不需要关心线程管理，数据同步的事情，可以把精力放在自己需要执行的操作上。
Cocoa operation 相关的类是 NSOperation ，NSOperationQueue。
NSOperation是个抽象类，使用它必须用它的子类，可以实现它或者使用它定义好的两个子类：NSInvocationOperation 和 NSBlockOperation。
创建NSOperation子类的对象，把对象添加到NSOperationQueue队列里执行。
使用：
NSInvocationOperation 和 NSBlockOperation
或继承NSOperation

三、GCD
Grand Central Dispatch (GCD)是Apple开发的一个多核编程的解决方法。在iOS4.0开始之后才能使用。GCD是一个替代诸如NSThread, NSOperationQueue, NSInvocationOperation等技术的很高效和强大的技术。现在的iOS系统都升级到7了，所以不用担心该技术不能使用。


详见网址 http://blog.jobbole.com/69019/
