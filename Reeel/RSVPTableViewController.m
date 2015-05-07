//
//  RSVPTableViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "RSVPTableViewController.h"
#import "ScreeningsTableViewCell.h"
#import "ScreeningDetailViewController.h"
#import "Screening.h"
#import "ScreeningStore.h"

@interface RSVPTableViewController () <UINavigationControllerDelegate, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, readonly, retain) UIScrollView *scrollView;

@end

@implementation RSVPTableViewController

@synthesize scrollView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView reloadData];
    
    if ([[[ScreeningStore sharedStore] allRSVPedScreenings] count] > 1) {
        self.navigationItem.title = @"RSVPs";
    } else {
        self.navigationItem.title = @"RSVP";
    }
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[ScreeningStore sharedStore] allRSVPedScreenings] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreeningsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    
    NSArray *screenings = [[ScreeningStore sharedStore] allRSVPedScreenings];
    
    Screening *screening = screenings[indexPath.row];
    NSLog(@"%@", screening);
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ScreeningsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScreeningsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    }
    
    
    [[cell screeningDescriptionLabel] setText:screening.screeningSynopsis];
    [[cell screeningDateLabel] setText:screening.screeningDate];
    [[cell screeningLocationLabel] setText:screening.screeningLocation];
    
    [[cell ratingsLabel] setText:[NSString stringWithFormat:@"Rating: %.01f/10", screening.screeningRating]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 151;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ScreeningDetailViewController *detailViewController = [[ScreeningDetailViewController alloc] init];
    
    NSArray *screenings = [[ScreeningStore sharedStore] allRSVPedScreenings];
    
    Screening *selectedScreening = screenings[indexPath.row];
    
    detailViewController.screening = selectedScreening;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
