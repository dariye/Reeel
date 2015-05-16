#import <UIKit/UIKit.h>

@interface ParallaxTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *parallaxBackgroundView;
@property (strong, nonatomic) UIImageView *parallaxImage;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
