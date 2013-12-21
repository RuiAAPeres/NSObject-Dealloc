//
//  NSObject+Dealloc.m
//  DemoProject
//
//  Created by Rui Peres on 21/12/2013.
//  Copyright (c) 2013 Aphely. All rights reserved.
//

#import "NSObject+Dealloc.h"
#import <objc/runtime.h>

@implementation NSObject (Dealloc)

static BOOL isSwizzed;

+(void)load
{
    isSwizzed = NO;
}

#pragma mark - Util methods

static void swizzClass(Class class, SEL originalSel, SEL newSel)
{
    Method origMethod = class_getClassMethod(class, originalSel);
    Method newMethod = class_getClassMethod(class, newSel);
    
    method_exchangeImplementations(origMethod, newMethod);
}

static void swizzInstance(Class class, SEL originalSel, SEL newSel)
{
    Method origMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    
    method_exchangeImplementations(origMethod, newMethod);
}

#pragma mark - Printing info

- (void)printDeallocatedObject
{
    NSLog(@"Deallocated->%@",[self.class description]);
    
    if ([self respondsToSelector:@selector(deallocDescription)])
    {
        NSLog(@"Dealloc description->%@",[self performSelector:NSSelectorFromString(@"deallocDescription")]);
    }
}

#pragma mark - Swizzled methods

- (void)RP_fakeDealloc
{
    [self printDeallocatedObject];
    [self RP_fakeDealloc];
}


#pragma mark - Public Methods


+ (void)RP_swizzDealloc
{
    // We won't do anything if it's already swizzed
    if (isSwizzed)
    {
        return;
    }
    
    swizzInstance([self class],NSSelectorFromString(@"dealloc"),@selector(RP_fakeDealloc));
    
    isSwizzed = YES;
}

+ (void)RP_undoSwizzDealloc
{
    // We won't do anything if it has not been Swizzed
    if (!isSwizzed)
    {
        return;
    }
    
    isSwizzed = NO;
    swizzInstance([self class],@selector(RP_fakeDealloc),NSSelectorFromString(@"dealloc"));
}

@end
