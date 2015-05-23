//
//  ScreeningDetailViewController.h
//  Reeel
//
//  Created by Paul Dariye on 4/19/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>



//IB_DESIGNABLE
@class Screening;

@interface ScreeningDetailViewController : UIViewController

@property (nonatomic, strong) PFObject *screening;



@end
