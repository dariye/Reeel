//
//  RSVPedTableTableViewController.h
//  Reeel
//
//  Created by Paul Dariye on 5/19/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface RSVPedTableTableViewController : UITableViewController

@property (nonatomic, strong) PFObject *screening;
@property (nonatomic, strong) PFObject *guestlist;

@end
