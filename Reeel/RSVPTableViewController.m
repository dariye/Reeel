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
@synthesize screenings;

- (id)init
{
    
    defaults = [NSUserDefaults standardUserDefaults];
    guestlist = [[NSArray alloc] init];
    screenings = [[NSMutableArray alloc] init];
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
                            [screenings addObject:screening];
                        } else {
                            
                        }
                    }];
                }
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            
        }];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView reloadData];
    
    

    self.navigationItem.title = @"RSVPs";
 
    
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:0.91 alpha:1.0]];
    
    
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.separatorColor  = [UIColor clearColor];


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [screenings count];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (ScreeningsTableViewCell *cell in [self.tableView visibleCells]) {
        [cell cellOnTableView:self.tableView didScrollOnView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 49)]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreeningsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    
    if (!cell) {
        
        [tableView registerNib:[UINib nibWithNibName:@"ScreeningsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScreeningsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
        
        [cell setBackgroundColor:self.tableView.backgroundColor];
    }
    
    // set imageBackgroundView dynamically.
    CGRect newFrame = cell.imageBackgroundView.frame;
    
    newFrame.size.width = cell.imageBackgroundView.frame.size.width;
    newFrame.size.height = cell.frame.size.height * 2/3 - 5;
    [cell.imageBackgroundView setFrame:newFrame];
    
    PFObject *screening = screenings[indexPath.row];
    
    PFFile *screeningPoster = [screening objectForKey:@"screeningPoster"];
    
    [screeningPoster getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
        if (!error) {
            cell.screeningImageView.image = [UIImage imageWithData:imageData];
            cell.screeningImageView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height + 40);
        }
        
    }];
    
    [[cell screeningTitleLabel] setText:[screening objectForKey:@"screeningTitle"]];
    
    [[cell screeningLocationLabel] setText:[screening objectForKey:@"screeningLocation"]];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"MMM d '@' HH:mm a"];
    
    [[cell screeningDateLabel] setText:[dateFormat stringFromDate:[screening objectForKey:@"screeningDate"]]];

    return cell;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    RSVPedTableTableViewController *detailViewController = [[RSVPedTableTableViewController alloc] init];
    
    PFObject *selectedScreening = screenings[indexPath.row];
    
    detailViewController.screening = selectedScreening;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
