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

@synthesize screening;


- (IBAction)RSVPButtonPressed:(UIButton *)sender {
    RSVPDetailViewController *rsvpDetail = [[RSVPDetailViewController alloc] init];
    
    rsvpDetail.screening = self.screening;
    
    [self.navigationController pushViewController:rsvpDetail animated:YES];
}


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    screening = self.screening;
    
    // Set background color of view
    self.view.backgroundColor = [UIColor whiteColor];
    // Set assign image from assets
    PFFile *screeningPoster =  [screening objectForKey:@"screeningPoster"];
    
    [screeningPoster getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
        if (!error) {
            self.screeningImageView.image = [UIImage imageWithData:imageData];
        }
        
    }];
    
    [[self movieRatingLabel] setText:[NSString stringWithFormat:@"Rating: %@ / 10",[screening objectForKey:@"screeningContentRating"]]];
    
    
    [[self movieSynopsisText] setText:[self.screening objectForKey:@"screeningSynopsis"]];
    
    [[self durationLabel] setText:[NSString stringWithFormat:@"%@ min",[screening objectForKey:@"screeningDuration"]]];
    
    NSDateFormatter *releaseDateFormat = [[NSDateFormatter alloc] init];
    [releaseDateFormat setDateFormat:@"MMM d y"];
    
    [[self releaseDateLabel] setText:[releaseDateFormat stringFromDate:[self.screening objectForKey:@"screeningReleaseDate"]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
