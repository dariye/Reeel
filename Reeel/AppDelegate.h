//
//  AppDelegate.h
//  Reeel
//
//  Created by Paul Dariye on 4/8/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly) int networkStatus;
@property (nonatomic, strong) PFUser *currentUser;

- (BOOL)isParseReachable;


@end

