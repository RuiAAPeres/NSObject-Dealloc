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
static NSMutableSet *swizzledClassesSet;

+(void)load
{
    swizzledClassesSet = [NSMutableSet set];
    isSwizzed = NO;
}

#pragma mark - Util methods

static void swizzInstance(Class class, SEL originalSel, SEL newSel)
{
    Method origMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    
    method_exchangeImplementations(origMethod, newMethod);
}

#pragma mark - Printing info

- (void)printDeallocatedObject
{
    NSString *classDescription = [[self class] description];
    
    if (![swizzledClassesSet containsObject:classDescription])
    {
        return;
    }
    
    NSLog(@"Deallocated->%@",self.class);
    
    if ([self respondsToSelector:@selector(deallocDescription)])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSLog(@"Dealloc description->%@",[self performSelector:NSSelectorFromString(@"deallocDescription")]);
#pragma clang diagnostic pop
    }
}

#pragma mark - Swizzled methods

- (void)RP_fakeDealloc
{
    [self printDeallocatedObject];
    [self RP_fakeDealloc];
}

#pragma mark - Public Methods

+ (void)RP_toggleSwizzDealloc
{
    NSString *classDescription = [[self class] description];
    
    if ([swizzledClassesSet containsObject:classDescription])
    {
        [swizzledClassesSet removeObject:classDescription];
        swizzInstance([self class],@selector(RP_fakeDealloc),NSSelectorFromString(@"dealloc"));
    }
    else
    {
        [swizzledClassesSet addObject:classDescription];
        swizzInstance([self class],NSSelectorFromString(@"dealloc"),@selector(RP_fakeDealloc));
    }
}

@end
