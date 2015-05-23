//
//  RSVPTableViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "RSVPTableViewController.h"
#import <MaterialDesignCocoa/UIColor+MaterialDesignCocoa.h>
#import <MaterialDesignCocoa/UIFont+MaterialDesignCocoa.h>
#import "ScreeningsTableViewCell.h"
#import "ScreeningDetailViewController.h"
#import "RSVPedTableTableViewController.h"
#import "RSVPTableViewCell.h"

#define FIRST_ROW_HEIGHT 220;
#define OTHER_ROWS_HEIGHT 110;

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
    NSString *userEmail = @"paul.dariye@gmail.com";
    
    guestlistQuery = [PFQuery queryWithClassName:@"GuestList"];
    screeningQuery = [PFQuery queryWithClassName:@"Screening"];
    
    if (userEmail) {
        [guestlistQuery whereKey:@"guestEmail" equalTo:userEmail];
        
        [guestlistQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            
            if (!error) {
                for (PFObject *object in objects) {
                    NSLog(@"yayaya %@", object[@"guestEmail"]);
                    [screeningQuery  whereKey:@"objectId" equalTo:object[@"screeningId" ]];
                    [screeningQuery getFirstObjectInBackgroundWithBlock:^(PFObject *screening, NSError *error) {
                        if (!error) {
                            [self.screenings addObject:screening];
                            [self.tableView reloadData];

                        } else {
                            
                        }
                    }];
                }
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            
        }];
    }
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
    NSLog(@"%ld", [_screenings count]);
    return [_screenings count];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (ScreeningsTableViewCell *cell in [self.tableView visibleCells]) {
        [cell cellOnTableView:self.tableView didScrollOnView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 49)]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PFObject *screening = self.screenings[indexPath.row];
    
    NSLog(@"%@", screening);
    
    
    RSVPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RSVPsCell"];
    
    if (!cell) {
        
        [tableView registerNib:[UINib nibWithNibName:@"RSVPTableViewCell" bundle:nil] forCellReuseIdentifier:@"RSVPsCell"];
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"RSVPsCell"];
        
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
    
    
    // Date formatter
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"MMM d '@' HH:mm a"];
    
    cell.screeningDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.screeningTitleLabel.frame.origin.y + 5, cell.cardView.frame.size.width - 20, 21)];
    [cell.screeningDateLabel setText:[screening objectForKey:@"screeningLocation"]];
    cell.screeningDateLabel.numberOfLines = 0;
    [cell.screeningDateLabel sizeToFit];
    cell.screeningDateLabel.font = [UIFont systemFontOfSize:14];
    cell.screeningDateLabel.textColor = [UIColor lightGrayColor];
    
    [cell.screeningDateLabel setText:[dateFormat stringFromDate:[screening objectForKey:@"screeningDate"]]];
    [cell.cardView addSubview:cell.screeningDateLabel];
    
    
    
    
    cell.screeningLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, cell.cardView.frame.size.height * 2/3 + 40, cell.cardView.frame.size.width - 20, 21)];
    [cell.screeningLocationLabel setText:[screening objectForKey:@"screeningLocation"]];
    cell.screeningLocationLabel.numberOfLines = 0;
    [cell.screeningLocationLabel sizeToFit];
    //CGFloat height = [cell.screeningLocationLabel.text boundingRectWithSize:CGSizeMake(cell.screeningLocationLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:nil context:nil].size.height;
    cell.screeningLocationLabel.font = [UIFont systemFontOfSize:14];
    cell.screeningLocationLabel.textColor = [UIColor lightGrayColor];
    
    
    [cell.cardView addSubview:cell.screeningLocationLabel];

    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    RSVPedTableTableViewController *detailViewController = [[RSVPedTableTableViewController alloc] init];
    
    PFObject *selectedScreening = self.screenings[indexPath.row];
    
    detailViewController.screening = selectedScreening;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
