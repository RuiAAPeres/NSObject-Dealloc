//
//  NSObject+Dealloc.h
//  DemoProject
//
//  Created by Rui Peres on 21/12/2013.
//  Copyright (c) 2013 Aphely. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NSObjectDeallocProtocol <NSObject>

@required

- (NSString *)deallocDescription;

@end

@interface NSObject (Dealloc)

+ (void)RP_toggleSwizzDealloc;

@end
