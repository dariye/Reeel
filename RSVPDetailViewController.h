//
//  RSVPDetailViewController.h
//  
//
//  Created by Collin Grubbs on 5/2/15.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

//IB_DESIGNABLE

@class Screening;

@interface RSVPDetailViewController : UIViewController
//@property (nonatomic, strong) Screening *screening;
@property (nonatomic,strong) PFObject *screening;

@end
