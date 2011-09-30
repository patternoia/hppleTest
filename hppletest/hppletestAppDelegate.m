//
//  hppletestAppDelegate.m
//  hppletest
//
//  Created by Evgeny Lavrik on 9/20/11.
//  Copyright 2011 Sitronics Telecom Solutions. All rights reserved.
//

#import "hppletestAppDelegate.h"
#import "TFHpple.h"
#import "Day.h"
#import "Event.h"
#import "WebParser.h"
#import "News.h"

@implementation hppletestAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray* days = [WebParser getScheduleByURL:@"http://foto-rent.ru/calendar/1/2011/09.atml"];
    
    for (Day *day in days) {
        for (Event *event in day.events) {
            NSLog(@"%d\n\t%@\n\t%@\n", day.day, event.startTime, event.endTime);
        }
    }
    
    NSArray* news = [WebParser getNewsByURL:@"http://foto-rent.ru"];
    for (News *item in news)
    {
        NSLog(@"%@ - %@\n%@", item.head, item.body, item.href);
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
