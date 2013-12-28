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

static NSMutableSet *swizzledClassesSet;

static NSString *const APHDealloc = @"dealloc";

+ (void)load
{
    swizzledClassesSet = [NSMutableSet set];
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
    NSMutableString *descriptionOutputed = [NSMutableString stringWithFormat:@"Deallocated -> %@",[self.class description]];
    
    if (![swizzledClassesSet containsObject:classDescription])
    {
        return;
    }
    
    if ([self respondsToSelector:@selector(deallocDescription)])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        [descriptionOutputed appendString:[NSString stringWithFormat:@" | %@ |",[self performSelector:NSSelectorFromString(@"deallocDescription")]]];
        
#pragma clang diagnostic pop
    }

    NSLog(@"%@",descriptionOutputed);
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
        swizzInstance([self class],@selector(RP_fakeDealloc),NSSelectorFromString(APHDealloc));
    }
    else
    {
        [swizzledClassesSet addObject:classDescription];
        swizzInstance([self class],NSSelectorFromString(APHDealloc),@selector(RP_fakeDealloc));
    }
}

@end
