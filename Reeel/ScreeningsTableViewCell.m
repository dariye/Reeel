//
//  ScreeningsTableViewCell.m
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ScreeningsTableViewCell.h"
#import "Screening.h"
#import "ScreeningStore.h"

@interface ScreeningsTableViewCell ()



@end

@implementation ScreeningsTableViewCell


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    if (self) {
        // Initialization code
    }
    return self;
}


/* Code From: https://medium.com/@cwRichardKim/ios-xcode-tutorial-a-card-based-newsfeed-8bedeb7b8df7 */
- (void)layoutSubviews
{
    [self cardSetup];
    [self imageSetup];
}

- (void)cardSetup
{
    [self.cardView setAlpha:1];
    self.cardView.layer.masksToBounds = NO;
    self.cardView.layer.cornerRadius = 2;
    self.cardView.layer.shadowOffset = CGSizeMake(1, 1);
    self.cardView.layer.shadowRadius = 1;
    self.cardView.layer.shadowColor = [UIColor blackColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.cardView.bounds];
    self.cardView.layer.shadowPath = path.CGPath;
    self.cardView.layer.shadowOpacity = 0.2;
    
    self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];

}

- (void)imageSetup
{
   
    _imageBackgroundView.clipsToBounds = YES;
    _screeningImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _screeningImageView.backgroundColor = [UIColor whiteColor];
    [_imageBackgroundView addSubview:_screeningImageView];
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
