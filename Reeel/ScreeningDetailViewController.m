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

@interface ScreeningDetailViewController () <UINavigationControllerDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *screeningImageView;
//@property (weak, nonatomic) IBOutlet UILabel *movieRatingLabel;
//@property (weak, nonatomic) IBOutlet UILabel *movieSynopsisText;
//@property (weak, nonatomic) IBOutlet UIButton *RSVPButton;
//@property (weak, nonatomic) IBOutlet UILabel *metaDataLabel;
//@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
//@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) ScreeningScrollContentViewController *contentView;


@end

@implementation ScreeningDetailViewController

@synthesize screening;
@synthesize scrollView;
@synthesize contentView;



- (IBAction)RSVPButtonPressed:(UIButton *)sender {
    RSVPDetailViewController *rsvpDetail = [[RSVPDetailViewController alloc] init];
    
    rsvpDetail.screening = self.screening;
    
    [self.navigationController pushViewController:rsvpDetail animated:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}



- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    screening = self.screening;
    
    contentView = [[ScreeningScrollContentViewController alloc] initWithNibName:@"ScreeningScrollContentViewController" bundle:nil];
    
    contentView.screeningTitleLabel.text = [screening objectForKey:@"screeningTitle"];
    
    [self.scrollView addSubview:contentView.scrollContentView];
    
    
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
    
    
    self.navigationItem.title = [screening objectForKey:@"screeningTitle"];
    
    // Set background color of view
    self.view.backgroundColor = [UIColor whiteColor];
    // Set assign image from assets
    PFFile *screeningPoster =  [screening objectForKey:@"screeningPoster"];
    
    [screeningPoster getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
        if (!error) {
            self.screeningImageView.image = [UIImage imageWithData:imageData];
        }
        
    }];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
