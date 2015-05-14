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

@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, strong) NSArray *rsvps;
@property (nonatomic, strong) NSArray *guestlist;

@property (nonatomic, strong) PFQuery *screeningQuery;
@property (nonatomic, strong) PFQuery *guestlistQuery;

@property (nonatomic, strong) PFQuery *query;

@end

@implementation RSVPTableViewController

@synthesize scrollView;
@synthesize rsvps;
@synthesize screeningQuery;
@synthesize guestlistQuery;
@synthesize defaults;
@synthesize query;

//
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        self.parseClassName = @"Screening";
//        self.pullToRefreshEnabled = YES;
//        self.paginationEnabled = NO;
//        self.objectsPerPage = 25;
//    }
//    return self;
//    
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView reloadData];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    self.navigationItem.title = @"RSVPs";

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (PFQuery *)queryForTable
{
    
    [guestlistQuery whereKey:@"guestEmail" equalTo:[[defaults objectForKey:@"userEmail"] lowercaseString]];
    [guestlistQuery includeKey:@"screening"];
    
    [query whereKey:@"objectId" matchesQuery:guestlistQuery];
    
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    
    
    return  query;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.objects count];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(nullable PFObject *)object
{
    ScreeningsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    
    if (!cell) {
        
        [tableView registerNib:[UINib nibWithNibName:@"ScreeningsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScreeningsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
        
        [cell setBackgroundColor:self.tableView.backgroundColor];
    }
    
    [[cell screeningDescriptionLabel] setText:[object objectForKey:@"screeningSynopsis"]];
    
    [[cell screeningLocationLabel] setText:[object objectForKey:@"screeningLocation"]];
    
//    NSLog(@"%@", [object objectForKey:@"createdBy"]);
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
