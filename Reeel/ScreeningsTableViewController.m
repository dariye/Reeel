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


@end

@implementation ScreeningsTableViewController

@synthesize scrollView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.parseClassName = @"Screening";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    return self;
    
}

-  (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(nullable PFObject *)object
{
    ScreeningsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    
    if (!cell) {
                
       [tableView registerNib:[UINib nibWithNibName:@"ScreeningsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScreeningsCell"];
                //        cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
//    cell.textLabel.text = [object objectForKey:@"text"];
    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"Priority: %@",
//                                 [object objectForKey:@"priority"]];
//    
//    cell.screeningDescriptionLabel.text = [object objectForKey:@"screeningSynopsis"];
    
    [[cell screeningDescriptionLabel] setText:[object objectForKey:@"screeningSynopsis"]];
    
    [[cell screeningLocationLabel] setText:[object objectForKey:@"screeningLocation"]];
    
    NSLog(@"%@", [object objectForKey:@"createdBy"]);
    // Date formatter
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  
    [dateFormat setDateFormat:@"MMM d '@' HH:mm a"];
    
    [[cell screeningDateLabel] setText:[dateFormat stringFromDate:[object objectForKey:@"screeningDate"]]];
    
    [[cell ratingsLabel] setText:[NSString stringWithFormat:@"Rating: %@ / 10",[object objectForKey:@"screeningContentRating"]]];
    
    PFFile *screeningPoster = [object objectForKey:@"screeningPoster"];
    
    [screeningPoster getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
        if (!error) {
            cell.screeningImageView.image = [UIImage imageWithData:imageData];
        }
        
    }];

    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
//    NSLog(@"%@", self.objects);
    
    return cell;
}


//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
////    if ([[[ScreeningStore sharedStore] allScreenings] count] > 1) {
////        self.navigationItem.title = @"Upcoming Screenings";
////    } else {
////        self.navigationItem.title = @"Upcoming Screening";
////    }
//    
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    
//}
//
//#pragma mark - Table view data source
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return [[[ScreeningStore sharedStore] allScreenings] count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ScreeningsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
//    
//    NSArray *screenings = [[ScreeningStore sharedStore] allScreenings];
//    Screening *screening = screenings[indexPath.row];
//    
//    if (!cell) {
//        [tableView registerNib:[UINib nibWithNibName:@"ScreeningsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScreeningsCell"];
//        cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
//    }
//    
//    
//    [[cell screeningDescriptionLabel] setText:screening.screeningSynopsis];
//    [[cell screeningDateLabel] setText:screening.screeningDate];
//    [[cell screeningLocationLabel] setText:screening.screeningLocation];
//    
//    
//    
//    [[cell ratingsLabel] setText:[NSString stringWithFormat:@"Rating: %.01f/10", screening.screeningRating]];
//    
//    return cell;
//}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 151;
}
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
//{
//    
//    ScreeningDetailViewController *detailViewController = [[ScreeningDetailViewController alloc] init];
//    NSArray *screenings = [[ScreeningStore sharedStore] allScreenings];
//    
//    Screening *selectedScreening = screenings[indexPath.row];
//    
//    detailViewController.screening = selectedScreening;
//    
//    
//    [self.navigationController pushViewController:detailViewController animated:YES];
//}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreeningDetailViewController *detailViewController = [[ScreeningDetailViewController alloc] init];
    NSArray *screenings = self.objects;
    
    PFObject *selectedScreening = screenings[indexPath.row];
    detailViewController.screening = selectedScreening;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}


@end
