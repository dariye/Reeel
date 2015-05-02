//
//  ScreeningsTableViewCell.h
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreeningsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ratingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *screeningDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *screeningDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *screeningLocationLabel;

@property (weak, nonatomic) IBOutlet UILabel *rsvpLabel;

@end
