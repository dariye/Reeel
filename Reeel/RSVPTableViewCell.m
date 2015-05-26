//
//  RSVPTableViewCell.m
//  Reeel
//
//  Created by Paul Dariye on 5/14/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "RSVPTableViewCell.h"

@implementation RSVPTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}



- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view
{
    CGRect rectInSuperview = [tableView convertRect:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.imageBackgroundView.frame.size.width, self.imageBackgroundView.frame.size.height) toView:view];
    
    float distanceFromCenter = CGRectGetHeight(view.frame) / 2 - CGRectGetMinY(rectInSuperview);
    
    float difference = CGRectGetHeight(self.screeningImageView.frame) - CGRectGetHeight(CGRectMake(self.frame.origin.x, self.frame.origin.y, self.imageBackgroundView.frame.size.width, self.imageBackgroundView.frame.size.height));
    
    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
    
    CGRect imageRect = self.screeningImageView.frame;
    imageRect.origin.y = -(difference * 0.4) + move;
    self.screeningImageView.frame = imageRect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
