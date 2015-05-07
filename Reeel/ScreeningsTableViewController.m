//
//  ScreeningsTableViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ScreeningsTableViewController.h"
#import "ScreeningsTableViewCell.h"
#import "ScreeningDetailViewController.h"
#import "Screening.h"
#import "ScreeningStore.h"

@interface ScreeningsTableViewController () <UINavigationControllerDelegate, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, readonly, retain) UIScrollView *scrollView;

@property (nonatomic) float rating;

@end

@implementation ScreeningsTableViewController

@synthesize scrollView;
@synthesize rating;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[ScreeningStore sharedStore] allScreenings] count] > 1) {
        self.navigationItem.title = @"Upcoming Screenings";
    } else {
        self.navigationItem.title = @"Upcoming Screening";
    }
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[ScreeningStore sharedStore] allScreenings] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreeningsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    
    NSArray *screenings = [[ScreeningStore sharedStore] allScreenings];
    Screening *screening = screenings[indexPath.row];
    
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
    NSArray *screenings = [[ScreeningStore sharedStore] allScreenings];
    
    Screening *selectedScreening = screenings[indexPath.row];
    
    detailViewController.screening = selectedScreening;
    
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}



@end
