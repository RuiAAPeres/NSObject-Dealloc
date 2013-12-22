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
* It allows you to add your own custom message, by using the `NSObjectDeallocProtocol` protocol.