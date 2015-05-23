//
//  ScreeningDetailViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/19/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ScreeningDetailViewController.h"
#import "RSVPDetailViewController.h"
#import "ScreeningScrollContentViewController.h"
#import <FXBlurView/FXBlurView.h>

@interface ScreeningDetailViewController () <UINavigationControllerDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *screeningImageView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) ScreeningScrollContentViewController *contentView;
@property (strong, nonatomic) FXBlurView *blurScreeningImageView;

@end

@implementation ScreeningDetailViewController

@synthesize screening = _screening;
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (IBAction)RSVPButtonPressed:(UIButton *)sender {
    RSVPDetailViewController *rsvpDetail = [[RSVPDetailViewController alloc] init];
    
    rsvpDetail.screening = self.screening;
    
    [self.navigationController pushViewController:rsvpDetail animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    self.blurScreeningImageView.alpha = y / [UIScreen mainScreen].bounds.size.height;
}

- (void)initContent
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 21)];
    title.text = @"Jason Ji";
    
    [self.scrollView addSubview:title];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initContent];
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    //contentView = [[ScreeningScrollContentViewController alloc] initWithNibName:@"ScreeningScrollContentViewController" bundle:nil];
    
    //contentView.screeningTitleLabel.text = [screening objectForKey:@"screeningTitle"];
    
    //[self.scrollView addSubview:contentView.scrollContentView];
    
    
//    contentView.backgroundColor = [UIColor whiteColor];
//    contentView.contentMode = UIViewContentModeScaleAspectFit;
//    
//    [scrollView addSubview:contentView];
    
    

    
//    scrollContentView.screeningTitleLabel.text = [screening objectForKey:@"screeningTitle"];
//    
//   
//    
//    scrollContentView.screeningTitleLabel.textColor = [UIColor whiteColor];
//    scrollContentView.screeningTitleLabel.font = [UIFont systemFontOfSize:28];
//
//    [scrollView addSubview:scrollContentView.view];
    
//    scrollView = [CustomScreeningScrollViewController new];
    
    
    self.navigationItem.title = [_screening objectForKey:@"screeningTitle"];
    
    // Set background color of view
    self.view.backgroundColor = [UIColor whiteColor];
    // Set assign image from assets
    PFFile *screeningPoster =  [_screening objectForKey:@"screeningPoster"];
    
    [screeningPoster getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
        if (!error) {
            self.screeningImageView.image = [UIImage imageWithData:imageData];
        }
        
    }];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.screeningImageView = backgroundImageView;
    [self.view addSubview:self.screeningImageView];
    
    self.blurScreeningImageView = [[FXBlurView alloc] initWithFrame:self.screeningImageView.frame];
    self.blurScreeningImageView.alpha = 0;
    [self.screeningImageView addSubview:self.blurScreeningImageView];
    
    self.scrollView.delegate = self;
    self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 2);
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
//
//    [scrollView addSubview:contentView.view];
//    
    
    

//    [[NSBundle mainBundle] loadNibNamed:@"CustomScreeningScrollViewController" owner:scrollView options:nil];
//    
//    scrollView.screeningTitleLabel.text = [screening objectForKey:@"screeningTitle"];
//    scrollView.screeningRatingLabel.text = [screening objectForKey:@"screeningContentRating"];
//    
//    
//    // Styling
//    scrollView.screeningTitleLabel.textColor = [UIColor whiteColor];
//    scrollView.screeningTitleLabel.font = [UIFont systemFontOfSize:28];
//    scrollView.screeningRatingLabel.textColor = [UIColor whiteColor];
//    
//    [self.view addSubview:scrollView.view];
//    [[self movieRatingLabel] setText:[NSString stringWithFormat:@"Rating: %@ / 10",[screening objectForKey:@"screeningContentRating"]]];
//    
//    
//    [[self movieSynopsisText] setText:[self.screening objectForKey:@"screeningSynopsis"]];
//    
//    [[self durationLabel] setText:[NSString stringWithFormat:@"%@ min",[screening objectForKey:@"screeningDuration"]]];
//    
//    NSDateFormatter *releaseDateFormat = [[NSDateFormatter alloc] init];
//    [releaseDateFormat setDateFormat:@"MMM d y"];
//    
//    [[self releaseDateLabel] setText:[releaseDateFormat stringFromDate:[self.screening objectForKey:@"screeningReleaseDate"]]];

}


@end
