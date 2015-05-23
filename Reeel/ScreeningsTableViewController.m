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


@interface ScreeningsTableViewController () <UINavigationControllerDelegate, UITableViewDelegate, UIScrollViewDelegate, MKMapViewDelegate>
@property(nonatomic, readonly, retain) UIScrollView *scrollView;

@property (nonatomic) CGFloat height;

@property (nonatomic, strong) NSArray *screenings;


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
    [self queryForTable];
    self.navigationItem.title = @"Upcoming Screening";
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:0.91 alpha:1.0]];

    
    self.tableView.separatorColor = [UIColor clearColor];
    
}


-  (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    self.screenings = self.objects;
    
    return query;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (ScreeningsTableViewCell *cell in [self.tableView visibleCells]) {
        [cell cellOnTableView:self.tableView didScrollOnView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 49)]];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([UIScreen mainScreen].bounds.size.height - 64 - 49) / 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
 
    ScreeningsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    
    if (!cell) {
                
       [tableView registerNib:[UINib nibWithNibName:@"ScreeningsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScreeningsCell"];
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
        
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    // set values for ui objects
    cell.cardView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width - 30, ([UIScreen mainScreen].bounds.size.height - 64 - 49) / 2 - 30)];
    cell.cardView.backgroundColor = [UIColor whiteColor];
    cell.cardView.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.cardView.layer.shadowOffset = CGSizeMake(1, 1);
    cell.cardView.layer.shadowOpacity = 0.3;
    cell.cardView.layer.shadowRadius = 2.0f;
    cell.cardView.layer.cornerRadius = 2.0f;
    
    [cell.contentView addSubview:cell.cardView];
    
    
    // set imageBackgroundView dynamically.
    cell.imageBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.cardView.frame.size.width, cell.cardView.frame.size.height * 2/3)];
    cell.imageBackgroundView.clipsToBounds = YES;
    
    [cell.cardView addSubview:cell.imageBackgroundView];

    cell.screeningImageView = [[UIImageView alloc] init];
    cell.screeningImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.screeningImageView.frame = CGRectMake(0, -20, cell.frame.size.width, cell.frame.size.height + 40);
    [cell.imageBackgroundView addSubview:cell.screeningImageView];
    
    PFFile *screeningPoster = [object objectForKey:@"screeningPoster"];
    
    [screeningPoster getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
        if (!error) {
            cell.screeningImageView.image = [UIImage imageWithData:imageData];
        }
        
    }];
    
    cell.screeningTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.imageBackgroundView.frame.size.height + 10, cell.cardView.frame.size.width, 21)];
    
    [cell.screeningTitleLabel setText:[object objectForKey:@"screeningTitle"]];
    cell.screeningTitleLabel.numberOfLines = 0;
    [cell.screeningTitleLabel sizeToFit];
    cell.screeningTitleLabel.font = [UIFont systemFontOfSize:14];
    cell.screeningLocationLabel.textColor = [UIColor lightGrayColor];
    
    
    [cell.cardView addSubview:cell.screeningTitleLabel];
    
    
    // Date formatter
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"MMM d '@' HH:mm a"];
    
    cell.screeningDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.screeningTitleLabel.frame.origin.y + 5, cell.cardView.frame.size.width - 20, 21)];
    [cell.screeningDateLabel setText:[object objectForKey:@"screeningLocation"]];
    cell.screeningDateLabel.numberOfLines = 0;
    [cell.screeningDateLabel sizeToFit];
    cell.screeningDateLabel.font = [UIFont systemFontOfSize:14];
    cell.screeningDateLabel.textColor = [UIColor lightGrayColor];
    
    [cell.screeningDateLabel setText:[dateFormat stringFromDate:[object objectForKey:@"screeningDate"]]];
    [cell.cardView addSubview:cell.screeningDateLabel];

    
    
    
    cell.screeningLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.cardView.frame.size.height * 2/3 + 40, cell.cardView.frame.size.width - 20, 21)];
    [cell.screeningLocationLabel setText:[object objectForKey:@"screeningLocation"]];
    cell.screeningLocationLabel.numberOfLines = 0;
    [cell.screeningLocationLabel sizeToFit];
    //CGFloat height = [cell.screeningLocationLabel.text boundingRectWithSize:CGSizeMake(cell.screeningLocationLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:nil context:nil].size.height;
    cell.screeningLocationLabel.font = [UIFont systemFontOfSize:14];
    cell.screeningLocationLabel.textColor = [UIColor lightGrayColor];
    

    [cell.cardView addSubview:cell.screeningLocationLabel];
    
    
  

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
