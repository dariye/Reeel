//
//  ScreeningDetailViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/19/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ScreeningDetailViewController.h"
#import "RSVPDetailViewController.h"
#import "Screening.h"
#import "ScreeningStore.h"

@interface ScreeningDetailViewController () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *screeningImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsisText;
@property (weak, nonatomic) IBOutlet UIButton *RSVPButton;
@property (weak, nonatomic) IBOutlet UILabel *metaDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;

@end

@implementation ScreeningDetailViewController

- (IBAction)RSVPButtonPressed:(UIButton *)sender {
    RSVPDetailViewController *rsvpDetail = [[RSVPDetailViewController alloc] init];
    
    rsvpDetail.screening = self.screening;
    
    [self.navigationController pushViewController:rsvpDetail animated:YES];
}


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    Screening *screening = self.screening;
    
    // Set background color of view
    self.view.backgroundColor = [UIColor whiteColor];
    // Set assign image from assets
    UIImage *poster = [UIImage imageNamed:@"womaningold.jpg"];
    self.navigationItem.title = @"Woman in Gold";
    NSLog(@"assigning image");
    // Set image on view
    self.screeningImageView.image = poster;
//    self.rating = self.rating;
    self.movieRatingLabel.text = [NSString stringWithFormat:@"Ratings: %.01f/10", screening.screeningRating];
    self.movieSynopsisText.text = screening.screeningSynopsis;
    
    // mock purposes
    self.metaDataLabel.text = @"PG-13";
    
    self.durationLabel.text = screening.screeningDuration;
    self.releaseDateLabel.text = screening.screeningReleaseDate;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
