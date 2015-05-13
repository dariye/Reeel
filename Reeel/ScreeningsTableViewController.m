//
//  ScreeningsTableViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ScreeningsTableViewController.h"
#import <MaterialDesignCocoa/MDCTableViewCell.h>
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

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Upcoming Screening";
    
    self.tableView.rowHeight = 64.0;
    
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:0.91 alpha:1.0]];
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
        cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
        
        [cell setBackgroundColor:self.tableView.backgroundColor];
    }
    
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
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 151;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreeningDetailViewController *detailViewController = [[ScreeningDetailViewController alloc] init];
    NSArray *screenings = self.objects;
    
    PFObject *selectedScreening = screenings[indexPath.row];
    detailViewController.screening = selectedScreening;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}


@end
