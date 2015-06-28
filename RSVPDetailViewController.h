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
#import "XLForm.h"
#import "XLFormViewController.h"

//IB_DESIGNABLE

@class Screening;

@interface RSVPDetailViewController : XLFormViewController
//@property (nonatomic, strong) Screening *screening;
@property (nonatomic,strong) PFObject *screening;

@end
