//
//  ScreeningsTableViewCell.h
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreeningsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *screeningTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *screeningDateLabel;
\
@property (weak, nonatomic) IBOutlet UILabel *screeningLocationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *screeningImageView;

@property (weak, nonatomic) IBOutlet UIView *cardView;

@end
