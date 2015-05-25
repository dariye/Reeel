//
//  RSVPTableViewCell.h
//  Reeel
//
//  Created by Paul Dariye on 5/14/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MDCCardTableViewCell.h"

@interface RSVPTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *screeningTitleLabel;
@property (strong, nonatomic) UILabel *screeningDateLabel;

@property (strong, nonatomic) UILabel *screeningLocationLabel;
@property (strong, nonatomic) UIImageView *screeningImageView;

@property (strong, nonatomic) UIView *imageBackgroundView;

@property (strong, nonatomic) UIView *cardView;

@property (strong, nonatomic) UIImageView *timeIconImageView;
@property (strong, nonatomic) UIImageView *locationIconImageView;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
