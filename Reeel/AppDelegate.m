//
//  AppDelegate.m
//  Reeel
//
//  Created by Paul Dariye on 4/8/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "ScreeningDetailViewController.h"
#import "RSVPTableViewController.h"
#import "ProfileTableViewController.h"
#import "ScreeningsTableViewController.h"
#import "UIColor+BFPaperColors.h"
#import <SSKeychain/SSKeychain.h>


@interface AppDelegate ()

@property (nonatomic,strong) ScreeningsTableViewController *homeController;


@end




@implementation AppDelegate

@synthesize currentUser = _currentUser;

- (BOOL)isParseReachable
{
    return self.networkStatus != NotReachable;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    [Parse enableLocalDatastore];
     // Initialize Parse
    [Parse setApplicationId:@"R0o50fZOPQuUPEsL5L4wSs0ToG9PF26eQRQD8W0s"
                  clientKey:@"36cPEUKfUwRR9JtZCjthxgSUSMTdCjBIxD9b7ZWR"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    NSString *uniqueID = [[NSString alloc] initWithString:[self getUniqueDeviceIdentifierAsString]];

   
    // Query User Object
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:uniqueID];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        if (!error) {
            NSLog(@"user exists");
            [PFUser logInWithUsernameInBackground:uniqueID password:uniqueID block:^(PFUser *user, NSError *error) {
                    if (user) {
                        // Do stuff after successful login.
                        self.currentUser = [PFUser currentUser];
                    } else {
                    // The login failed. Check error to see why.
                    }
                }];
        } else {
            NSLog(@"user doesn't exist");
            // Create  new user
            [self signUp];

        }
    }];
    
    
//       NSLog(@"%@", uniqueID);
//    [[PFUser currentUser] saveInBackground];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          nil]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor paperColorRed600]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    // ScreeningsTableViewController
    ScreeningsTableViewController *screening = [[ScreeningsTableViewController alloc] init];
    
    // RSVPsViewController
    RSVPTableViewController *rsvp = [[RSVPTableViewController alloc] init];
    
    // ProfileViewController
    
    ProfileTableViewController *profile = [[ProfileTableViewController alloc] init];
    
    
    // Use Reachablility to monitor connectivity
    [self monitorReachability];
    
    
    
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
    
    [tabBarController.tabBar setTintColor:[UIColor paperColorRed500]];
    
    self.window.rootViewController = tabBarController;
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)signUp
{
    PFUser *user = [PFUser user];
    NSString *uniqueID = [[NSString alloc] initWithString:[self getUniqueDeviceIdentifierAsString]];
    user.username = uniqueID;
    user.password = uniqueID;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error) {
            NSLog(@"created new user account successfulyy");
            self.currentUser = user;
        }
    }];
}

- (void)monitorReachability {
    Reachability *hostReach = [Reachability reachabilityWithHostname:@"api.parse.com"];
    hostReach.reachableBlock = ^(Reachability*reach) {
        _networkStatus = [reach currentReachabilityStatus];
        
        if ([self isParseReachable] && [PFUser currentUser] && self.homeController.objects.count == 0) {
            // Refresh home timeline on network restoration. Takes care of a freshly installed app that failed to load the main timeline under bad network conditions.
            [self.homeController loadObjects];
        }
    };
    hostReach.unreachableBlock = ^(Reachability*reach) {
        _networkStatus = [reach currentReachabilityStatus];
    };
    [hostReach startNotifier];
}

-(NSString *)getUniqueDeviceIdentifierAsString
{
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incoding"];
    }
    return strApplicationUUID;
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
    [PFUser logOut];
    self.currentUser = [PFUser currentUser];
}

@end
