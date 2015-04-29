//
//  ScreeningsTableViewCell.m
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ScreeningsTableViewCell.h"

@interface ScreeningsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *screeningImageView;

@end

@implementation ScreeningsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.screeningImageView.image = [UIImage imageNamed:@"womaningold"];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end