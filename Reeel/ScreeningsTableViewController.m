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
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"



@interface ScreeningsTableViewController () <UINavigationControllerDelegate, UITableViewDelegate, UIScrollViewDelegate, MKMapViewDelegate>
@property(nonatomic, readonly, retain) UIScrollView *scrollView;

@property (nonatomic) CGFloat height;

@property (nonatomic, strong) NSArray *screenings;
@property (nonatomic, strong) NSDate *lastRefresh;
@property (nonatomic, strong) NSMutableArray *sections;

@end

@implementation ScreeningsTableViewController

@synthesize scrollView;
@synthesize screenings = _screenings;
@synthesize sections = _sections;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.parseClassName = @"Screening";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
        [self retrieveFromParse];
    }
    
    return self;
    
}

- (void)viewDidLoad
{
    self.tableView.separatorColor = [UIColor clearColor];
    
    [super viewDidLoad];
    self.sections = [[NSMutableArray alloc] init];
    
    // TODO: Find a cleaner way of implementing this
    if([[[self queryForTable] findObjects:nil] count] > 1) {
        self.navigationItem.title = @"Upcoming Screenings";
    }else {
        self.navigationItem.title = @"Upcoming Screening";
    }

    self.tableView.backgroundColor = [UIColor colorWithWhite:0.91 alpha:1.0];
    
    self.lastRefresh = [[NSUserDefaults standardUserDefaults] objectForKey:@"ScreeningsTableViewControllerLastRefreshKey"];
    
}


-  (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query orderByDescending:@"screeningDate"];
    
    return query;
}

- (void)retrieveFromParse
{
   
    [[self queryForTable] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.screenings = [[NSArray alloc] initWithArray:objects];
            
            [self setSections];
            [self.tableView reloadData];
            
        }
    }];
}
- (void)setSections
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM d"];
    
    for (PFObject *object in self.screenings) {
        
        [self.sections addObject:[dateFormat stringFromDate:[object objectForKey:@"screeningDate"]]];
    }
    
}

- (void)objectsDidLoad:(nullable NSError *)error
{
    [super objectsDidLoad:error];
    
    self.lastRefresh = [NSDate date];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.lastRefresh forKey:@"ScreeningsTableViewControllerLastRefreshKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
     if (self.objects.count == 0 && ![[self queryForTable] hasCachedResult]) {
         self.tableView.scrollEnabled = NO;
     }else {
         self.tableView.scrollEnabled = YES;
     }
    
    [self.tableView setShowsVerticalScrollIndicator:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (ScreeningsTableViewCell *cell in [self.tableView visibleCells]) {
        [cell cellOnTableView:self.tableView didScrollOnView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 49)]];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([UIScreen mainScreen].bounds.size.height - 64 - 49) / 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScreeningsCell";
    static NSString *CellNib = @"ScreeningsTableViewCell";
    
    
    ScreeningsTableViewCell *cell = (ScreeningsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
        cell = (ScreeningsTableViewCell *)[nib objectAtIndex:0];
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }

    
    PFObject *screening = self.screenings[indexPath.row];
    
    // set values for ui objects
    cell.cardView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width - 30, ([UIScreen mainScreen].bounds.size.height - 64 - 49) / 2 - 15)];
    cell.cardView.backgroundColor = [UIColor whiteColor];
    cell.cardView.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.cardView.layer.shadowOffset = CGSizeMake(1, 1);
    cell.cardView.layer.shadowOpacity = 0.1;
    cell.cardView.layer.shadowRadius = 1.0f;
    cell.cardView.layer.cornerRadius = 1.0f;
    
    [cell.contentView addSubview:cell.cardView];
    
    
    // set imageBackgroundView dynamically.
    cell.imageBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.cardView.frame.size.width, cell.cardView.frame.size.height * 2/3)];
    cell.imageBackgroundView.clipsToBounds = YES;
    
    [cell.cardView addSubview:cell.imageBackgroundView];

    cell.screeningImageView = [[UIImageView alloc] init];
    cell.screeningImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.screeningImageView.frame = CGRectMake(0, -20, cell.frame.size.width, cell.frame.size.height + 40);
    [cell.imageBackgroundView addSubview:cell.screeningImageView];
    
    PFFile *screeningPoster = [screening objectForKey:@"screeningPoster"];
    
    [screeningPoster getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
        if (!error) {
            cell.screeningImageView.image = [UIImage imageWithData:imageData];
        }
        
    }];
    
    cell.screeningTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.imageBackgroundView.frame.size.height + 10, cell.cardView.frame.size.width, 21)];
    
    [cell.screeningTitleLabel setText:[screening objectForKey:@"screeningTitle"]];
    cell.screeningTitleLabel.numberOfLines = 0;
    [cell.screeningTitleLabel sizeToFit];
    cell.screeningTitleLabel.font = [UIFont systemFontOfSize:14];
    cell.screeningLocationLabel.textColor = [UIColor lightGrayColor];
    
    
    [cell.cardView addSubview:cell.screeningTitleLabel];
    
    // Time Icon
    UIImage *timeImage = [UIImage imageNamed:@"access-time"];
    cell.timeIconImageView = [[UIImageView alloc] initWithImage:timeImage];
     cell.timeIconImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.timeIconImageView.frame = CGRectMake(10, cell.screeningTitleLabel.frame.origin.y + 20, 12, 12);
    cell.timeIconImageView.clipsToBounds = YES;
   
    
    [cell.cardView addSubview:cell.timeIconImageView];
    
    // Date formatter
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM d '@' HH:mm a"];
    
    cell.screeningDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, cell.screeningTitleLabel.frame.origin.y + 14, cell.cardView.frame.size.width - 40, 21)];
    [cell.screeningDateLabel setText:[dateFormat stringFromDate:[screening objectForKey:@"screeningDate"]]];
    cell.screeningDateLabel.numberOfLines = 0;
    [cell.screeningDateLabel sizeToFit];
    cell.screeningDateLabel.font = [UIFont systemFontOfSize:14];
    cell.screeningDateLabel.textColor = [UIColor lightGrayColor];
    
   
    [cell.cardView addSubview:cell.screeningDateLabel];

    // Location Icon
    UIImage *locationImage = [UIImage imageNamed:@"location"];
    cell.locationIconImageView = [[UIImageView alloc] initWithImage:locationImage];
    cell.locationIconImageView.frame = CGRectMake(10, cell.screeningTitleLabel.frame.origin.y + 37, 12, 12);
    cell.locationIconImageView.clipsToBounds = YES;
    cell.locationIconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [cell.cardView addSubview:cell.locationIconImageView];
    
    
    cell.screeningLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, cell.screeningTitleLabel.frame.origin.y + 25, cell.cardView.frame.size.width - 40, 21)];
    [cell.screeningLocationLabel setText:[screening objectForKey:@"screeningLocation"]];
//    CGFloat height = [cell.screeningLocationLabel.text boundingRectWithSize:CGSizeMake(cell.screeningLocationLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:nil context:nil].size.height;
//    
    cell.screeningLocationLabel.numberOfLines = 0;
    [cell.screeningLocationLabel sizeToFit];
    cell.screeningLocationLabel.font = [UIFont systemFontOfSize:14];
    cell.screeningLocationLabel.textColor = [UIColor lightGrayColor];
    [cell.cardView addSubview:cell.screeningLocationLabel];
    
    [cell layoutSubviews];
    [cell setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreeningDetailViewController *detailViewController = [[ScreeningDetailViewController alloc] init];
    
    PFObject *selectedScreening = self.screenings[indexPath.row];
    
    detailViewController.screening = selectedScreening;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
