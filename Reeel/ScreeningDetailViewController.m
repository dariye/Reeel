//
//  ScreeningDetailViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/19/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ScreeningDetailViewController.h"

@interface ScreeningDetailViewController () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *screeningImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieRatingLabel;
@property (weak, nonatomic) IBOutlet UITextView *movieSynopsisText;
@property (weak, nonatomic) IBOutlet UIButton *RSVPButton;
@property (weak, nonatomic) IBOutlet UILabel *metaDataLabel;

@property (nonatomic) float rating;
//@property (nonatomic) int denominator;
//@property (nonatomic)

@end

@implementation ScreeningDetailViewController

- (IBAction)RSVPButtonPressed:(UIButton *)sender {
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Set background color of view
    self.view.backgroundColor = [UIColor whiteColor];
    // Set assign image from assets
    UIImage *poster = [UIImage imageNamed:@"womaningold.jpg"];
    self.navigationItem.title = @"Woman in Gold";
    //NSLog(@"assigning image");
    // Set image on view
    self.screeningImageView.image = poster;
    self.rating = 7.5;
    self.movieRatingLabel.text = [NSString stringWithFormat:@"Ratings: %.01f/10", self.rating];
    self.metaDataLabel.text = @"PG-13       109 min       April 1st, 2015 (USA)";
    self.movieSynopsisText.editable = NO;
    self.movieSynopsisText.text = @"Maria Altmann (Helen Mirren), an elderly Jewish survivor of World War II, sues the Austrian government for the return of artwork the Nazis stole from her family.";
    
//    [self.RSVPButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
