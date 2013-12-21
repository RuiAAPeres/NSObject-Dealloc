//
//  NSObject+Dealloc.h
//  DemoProject
//
//  Created by Rui Peres on 21/12/2013.
//  Copyright (c) 2013 Aphely. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Used to add a more specifc output for a given class.
 This is useful, when for example, one of your model objects
 has an id, and you want to know exactly which model objects
 are being released.
 */
@protocol NSObjectDeallocProtocol <NSObject>

@required

- (NSString *)deallocDescription;

@end

@interface NSObject (Dealloc)

/**
 It will toggle the behaviour on a class basis. For example: [NSString RP_toggleSwizzDealloc],
 will output (NSlogs) when the dealloc method is called on NSStrings
 @return void
 */
+ (void)RP_toggleSwizzDealloc;

@end
