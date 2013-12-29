//
//  APHAppDelegate.m
//  DemoProject
//
//  Created by Rui Peres on 21/12/2013.
//  Copyright (c) 2013 Aphely. All rights reserved.
//

#import "APHAppDelegate.h"

#import "NSObject+Dealloc.h"
#import "APHTestingClass.h"

@implementation APHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [APHTestingClass RP_toggleSwizzDealloc];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    for (int i = 0; i < 5; i++)
    {
        APHTestingClass *object = [[APHTestingClass alloc] init];
    }
    
#pragma clang diagnostic pop
    
    
    
    return YES;
}



@end
