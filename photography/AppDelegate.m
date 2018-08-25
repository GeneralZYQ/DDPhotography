//
//  AppDelegate.m
//  photography
//
//  Created by 张元清 on 2018/8/13.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "AppDelegate.h"
#import "IDConfig.h"
#import "DDIntroViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "DDCustomersController.h"
#import "DDMineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    DDIntroViewController *ddIntro = [[DDIntroViewController alloc] initWithNibName:@"DDIntroViewController" bundle:nil];
//    self.window.rootViewController = ddIntro;
    
    FirstViewController *first = [[FirstViewController alloc] init];
    UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:first];
    navi1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"订单" image:[UIImage imageNamed:@""] tag:0];
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:secondVC];
    navi2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"档期" image:[UIImage imageNamed:@""] tag:1];
    
    DDCustomersController *customersVC = [[DDCustomersController alloc] init];
    UINavigationController *navi3 = [[UINavigationController alloc] initWithRootViewController:customersVC];
    navi3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"客户" image:[UIImage imageNamed:@""] tag:2];
    
    DDMineViewController *mineVC = [[DDMineViewController alloc] init];
    UINavigationController *navi4 = [[UINavigationController alloc] initWithRootViewController:mineVC];
    navi4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@""] tag:3];
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[navi1, navi2, navi3, navi4];
    
    self.window.rootViewController = tabVC;

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
