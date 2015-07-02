//
//  RSVPTableViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "RSVPTableViewController.h"
#import "RSVPedTableTableViewController.h"
#import "RSVPTableViewCell.h"

@interface RSVPTableViewController () <UINavigationControllerDelegate, UITableViewDelegate>
@property (nonatomic, readonly, retain) UIScrollView *scrollView;

@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, strong) NSArray *rsvps;
@property (nonatomic, strong) NSArray *guestlist;

@property (nonatomic, strong) PFQuery *screeningQuery;
@property (nonatomic, strong) PFQuery *guestlistQuery;

@property (nonatomic, strong) PFQuery *query;
@property (nonatomic, strong) NSMutableArray *screenings;

@property (nonatomic) CGFloat height;

@end

@implementation RSVPTableViewController

@synthesize scrollView;
@synthesize rsvps;
@synthesize screeningQuery;
@synthesize guestlist;
@synthesize guestlistQuery;
@synthesize defaults;
@synthesize query;
@synthesize screenings = _screenings;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    defaults = [NSUserDefaults standardUserDefaults];
    guestlist = [[NSArray alloc] init];
    self.screenings = [[NSMutableArray alloc] init];
    
    guestlistQuery = [PFQuery queryWithClassName:@"GuestList"];
    screeningQuery = [PFQuery queryWithClassName:@"Screening"];
    [guestlistQuery whereKey:@"user" equalTo:[PFUser currentUser]];
    [guestlistQuery includeKey:@"screening"];
//    [guestlistQuery fromLocalDatastore];

    [guestlistQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        
        if (!error) {
            for (PFObject *object in objects) {
                [self.screenings addObject:[object objectForKey:@"screening" ]];
            }
            [self.tableView reloadData];
        
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];

}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"RSVPs";
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:0.91 alpha:1.0]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.separatorColor  = [UIColor clearColor];


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGFloat tabbarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat navbarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat rowHeight = (screenHeight - (tabbarHeight + navbarHeight + 30))/2;
    self.height = rowHeight;
    
    return self.height;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.screenings count];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (RSVPTableViewCell *cell in [self.tableView visibleCells]) {
        [cell cellOnTableView:self.tableView didScrollOnView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 49)]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"RSVPsCell";
    static NSString *CellNib = @"RSVPTableViewCell";
    
    RSVPTableViewCell *cell = (RSVPTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
        cell = (RSVPTableViewCell *)[nib objectAtIndex:0];
    }
    
    for (UIView *view in cell.contentView.subviews) {
       [view removeFromSuperview];
    }
    
    PFObject *screening = self.screenings[indexPath.row];
    
    // set values for ui objects
    cell.cardView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width - 30, ([UIScreen mainScreen].bounds.size.height - 64 - 49) / 2 - 30)];
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
    
    cell.screeningDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, cell.screeningTitleLabel.frame.origin.y + 5, cell.cardView.frame.size.width - 40, 21)];
    [cell.screeningDateLabel setText:[screening objectForKey:@"screeningLocation"]];
    cell.screeningDateLabel.numberOfLines = 0;
    [cell.screeningDateLabel sizeToFit];
    cell.screeningDateLabel.font = [UIFont systemFontOfSize:14];
    cell.screeningDateLabel.textColor = [UIColor lightGrayColor];
    
    [cell.screeningDateLabel setText:[dateFormat stringFromDate:[screening objectForKey:@"screeningDate"]]];
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSVPedTableTableViewController *detailViewController = [[RSVPedTableTableViewController alloc] init];
    PFObject *selectedScreening = self.screenings[indexPath.row];
    detailViewController.screening = selectedScreening;
    [self.navigationController pushViewController:detailViewController animated:YES];
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
