//
//  AppDelegate.m
//  Reeel
//
//  Created by Paul Dariye on 4/8/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "AppDelegate.h"

#import "ScreeningDetailViewController.h"
#import "RSVPTableViewController.h"
#import "ProfileTableViewController.h"
#import "ScreeningsTableViewController.h"
#import <Parse/Parse.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
     // Initialize Parse
    [Parse setApplicationId:@"R0o50fZOPQuUPEsL5L4wSs0ToG9PF26eQRQD8W0s"
                  clientKey:@"36cPEUKfUwRR9JtZCjthxgSUSMTdCjBIxD9b7ZWR"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    
    // Material Design UINavigationController
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor mdcRedColorWithPaletteId:kUIColorMDCPaletteIdPrimary]];
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     @{
//       NSForegroundColorAttributeName: [UIColor whiteColor],
//       //     UITextAttributeTextShadowColor: [NSNull null],
//       //     UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
//       NSFontAttributeName: [UIFont mdcHeadlineFont],
//       }];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // ScreeningsTableViewController
    ScreeningsTableViewController *screening = [[ScreeningsTableViewController alloc] init];
    
    // RSVPsViewController
    RSVPTableViewController *rsvp = [[RSVPTableViewController alloc] init];
    
    // ProfileViewController
    
    ProfileTableViewController *profile = [[ProfileTableViewController alloc] init];
    
    // Instantiate Tabbar Controller
  
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    UINavigationController *screeningNavController = [[UINavigationController alloc] initWithRootViewController:screening];
    
    UINavigationController *rsvpNavController = [[UINavigationController alloc] initWithRootViewController:rsvp];
    
    UINavigationController *profileNavController = [[UINavigationController alloc] initWithRootViewController:profile];
    
    tabBarController.viewControllers = @[screeningNavController, rsvpNavController, profileNavController];
    
    [[tabBarController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"home"]];
    [[tabBarController.tabBar.items objectAtIndex:0] setTitle:@"Home"];

    [[tabBarController.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"movie"]];
    [[tabBarController.tabBar.items objectAtIndex:1] setTitle:@"RSVP"];

    [[tabBarController.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"account-circle"]];
    [[tabBarController.tabBar.items objectAtIndex:2] setTitle:@"Profile"];
    
    self.window.rootViewController = tabBarController;
    
    
    // Override point for customization after application launch.
   
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
   
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
