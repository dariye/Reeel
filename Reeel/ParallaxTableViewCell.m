#import "ParallaxTableViewCell.h"

@implementation ParallaxTableViewCell

- (void)setup
{

}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view
{
    CGRect rectInSuperview = [tableView convertRect:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.parallaxBackgroundView.frame.size.width, self.parallaxBackgroundView.frame.size.height) toView:view];
    
    float distanceFromCenter = CGRectGetHeight(view.frame) / 2 - CGRectGetMinY(rectInSuperview);
    
    float difference = CGRectGetHeight(self.parallaxImage.frame) - CGRectGetHeight(CGRectMake(self.frame.origin.x, self.frame.origin.y, self.parallaxBackgroundView.frame.size.width, self.parallaxBackgroundView.frame.size.height));
                                                                                   
    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
        
    CGRect imageRect = self.parallaxImage.frame;
    imageRect.origin.y = -(difference * 0.4) + move;
    self.parallaxImage.frame = imageRect;
}

@end
