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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
    _screeningImageView.clipsToBounds = YES;
    _screeningImageView.contentMode = UIViewContentModeScaleAspectFit;
    _screeningImageView.backgroundColor = [UIColor whiteColor];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
