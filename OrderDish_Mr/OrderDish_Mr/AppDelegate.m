//
//  AppDelegate.m
//  OrderDish_Mr
//
//  Created by Charles on 15/11/4.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "AppDelegate.h"
#import "HomepageViewController.h"
#import "DatabaseTool.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    HomepageViewController *homepageVC = [[HomepageViewController alloc] init];
    self.window.rootViewController = homepageVC;
    //先初始化数据库
    [DatabaseTool initDatabase];
    return YES;
}
//添加圈圈
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject]locationInView:self.window];
    roundLayer = [CALayer layer];
    roundLayer.frame = CGRectMake(touchPoint.x - 25, touchPoint.y - 25, 50, 50);
    roundLayer.borderColor = [UIColor orangeColor].CGColor;
    roundLayer.borderWidth = 5;
    roundLayer.cornerRadius = 25;
    [self.window.layer addSublayer:roundLayer];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject]locationInView:self.window];
    roundLayer.position = CGPointMake(touchPoint.x, touchPoint.y);
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [roundLayer removeFromSuperlayer];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
