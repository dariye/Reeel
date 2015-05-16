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

@interface ScreeningsTableViewController () <UINavigationControllerDelegate, UITableViewDelegate, UIScrollViewDelegate>
@property(nonatomic, readonly, retain) UIScrollView *scrollView;

@property (nonatomic) CGFloat height;

@property (nonatomic, strong) NSArray *screenings;
\


@end

@implementation ScreeningsTableViewController

@synthesize scrollView;
@synthesize screenings;

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
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
    
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    for (ParallaxTableViewCell *cell in [self.tableView visibleCells]) {
//        [cell cellOnTableView:self.tableView didScrollOnView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 49)]];
//    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenHeight = screenRect.size.height;
    //CGFloat tabbarHeight = self.tabBarController.tabBar.frame.size.height;
    //CGFloat navbarHeight = self.navigationController.navigationBar.frame.size.height;
    //CGFloat rowHeight = (screenHeight - (tabbarHeight + navbarHeight + 30))/2;
//    self.height = rowHeight;
    return 220;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(nullable PFObject *)object
{
    
    ScreeningsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    
    if (!cell) {
                
       [tableView registerNib:[UINib nibWithNibName:@"ScreeningsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScreeningsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
        
        [cell setBackgroundColor:self.tableView.backgroundColor];
    }
    

    
    PFFile *screeningPoster = [object objectForKey:@"screeningPoster"];
    
    [screeningPoster getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
        if (!error) {
            cell.screeningImageView.image = [UIImage imageWithData:imageData];
        }
        
    }];
    
    [[cell screeningTitleLabel] setText:[object objectForKey:@"screeningTitle"]];
    
    [[cell screeningLocationLabel] setText:[object objectForKey:@"screeningLocation"]];
    
    NSLog(@"%@", [object objectForKey:@"createdBy"]);
    // Date formatter
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  
    [dateFormat setDateFormat:@"MMM d '@' HH:mm a"];
    
    [[cell screeningDateLabel] setText:[dateFormat stringFromDate:[object objectForKey:@"screeningDate"]]];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreeningDetailViewController *detailViewController = [[ScreeningDetailViewController alloc] init];
    screenings = self.objects;
    
    PFObject *selectedScreening = screenings[indexPath.row];
    
    detailViewController.screening = selectedScreening;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}


@end
