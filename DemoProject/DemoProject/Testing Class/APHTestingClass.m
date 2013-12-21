//
//  APHTestingClass.m
//  DemoProject
//
//  Created by Rui Peres on 21/12/2013.
//  Copyright (c) 2013 Aphely. All rights reserved.
//

#import "APHTestingClass.h"

@implementation APHTestingClass

#pragma mark - NSObjectDeallocProtocol Implementation

-(NSString *)deallocDescription
{
    return @"This a specific description, that can be helpful while debugging";
}

@end
