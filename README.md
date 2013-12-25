NSObject-Dealloc
================

Category used to know when your object has been deallocated. Most of the time, you shouldn't need this kind of tool. 


------------------------------------
Example of usage
============

Sometimes you are not sure why a given `UIViewController` is not being deallocated. This can be seen on Instruments, by analysing the allocations between different push/pops of this `UIViewController`. The goal of this category, is to inform you (by `NSLogs`) what is being deallocated. 


------------------------------------
Advantages
============

There are two advantages with this category:

* It allows you to add the deallocation on a class basis. 
* It allows you to add your own custom message, by using the `NSObjectDeallocProtocol` protocol. It's useful to distinguish objects of the same class


------------------------------------
Demo project
============

The demo project is quite straightforward:

```objective-c
[APHTestingClass RP_toggleSwizzDealloc];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    for (int i = 0; i < 10; i++)
    {
        APHTestingClass *object = [[APHTestingClass alloc] init];
    }
    
#pragma clang diagnostic pop
```

First we turn on the swizzling on the `APHTestingClass`. We then create a 10 objects so we can see them be deallocated after:

```
2013-12-25 13:11:09.403 DemoProject[473:70b] Deallocated -> APHTestingClass | This a specific description, that can be helpful while debugging |
2013-12-25 13:11:09.404 DemoProject[473:70b] Deallocated -> APHTestingClass | This a specific description, that can be helpful while debugging |
2013-12-25 13:11:09.405 DemoProject[473:70b] Deallocated -> APHTestingClass | This a specific description, that can be helpful while debugging |
2013-12-25 13:11:09.405 DemoProject[473:70b] Deallocated -> APHTestingClass | This a specific description, that can be helpful while debugging |
2013-12-25 13:11:09.406 DemoProject[473:70b] Deallocated -> APHTestingClass | This a specific description, that can be helpful while debugging |
2013-12-25 13:11:09.406 DemoProject[473:70b] Deallocated -> APHTestingClass | This a specific description, that can be helpful while debugging |
2013-12-25 13:11:09.407 DemoProject[473:70b] Deallocated -> APHTestingClass | This a specific description, that can be helpful while debugging |
2013-12-25 13:11:09.407 DemoProject[473:70b] Deallocated -> APHTestingClass | This a specific description, that can be helpful while debugging |
2013-12-25 13:11:09.407 DemoProject[473:70b] Deallocated -> APHTestingClass | This a specific description, that can be helpful while debugging |
2013-12-25 13:11:09.408 DemoProject[473:70b] Deallocated -> APHTestingClass | This a specific description, that can be helpful while debugging |
```

The `| This a specific description, that can be helpful while debugging |` is a custom message that you can add, to further help you while debugging. 




