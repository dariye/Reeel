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
#import "Screening.h"
#import "ScreeningStore.h"
#import "RSVPTableViewCell.h"

#define FIRST_ROW_HEIGHT 220;
#define OTHER_ROWS_HEIGHT 110;

@interface RSVPTableViewController () <UINavigationControllerDelegate, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, readonly, retain) UIScrollView *scrollView;

@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, strong) NSArray *rsvps;
@property (nonatomic, strong) NSArray *guestlist;

@property (nonatomic, strong) PFQuery *screeningQuery;
@property (nonatomic, strong) PFQuery *guestlistQuery;

@property (nonatomic, strong) PFQuery *query;
@property (nonatomic, strong) NSArray *screenings;

@end

@implementation RSVPTableViewController

@synthesize scrollView;
@synthesize rsvps;
@synthesize screeningQuery;
@synthesize guestlistQuery;
@synthesize defaults;
@synthesize query;
@synthesize screenings;

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
 
    
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:0.91 alpha:1.0]];

}

- (PFQuery *)queryForTable
{
    
    [guestlistQuery whereKey:@"guestEmail" equalTo:[[defaults objectForKey:@"userEmail"] lowercaseString]];
    [guestlistQuery includeKey:@"screening"];
    
    [query whereKey:@"objectId" matchesQuery:guestlistQuery];
    
//    if ([self.objects count] == 0) {
//        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
//    }
    
    
    
    return  query;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    
    if (!cell) {
        
        [tableView registerNib:[UINib nibWithNibName:@"ScreeningsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScreeningsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"RSVPCell"];
        
        [cell setBackgroundColor:self.tableView.backgroundColor];
    }
    
//    for (UIView *view in cell.contentView.subviews) {
//        [view removeFromSuperview];
//    }
//    
//    cell.backgroundColor = [UIColor clearColor];
//    
//    CGFloat height = 0;
//    if (indexPath.row == 0) {
//        height = FIRST_ROW_HEIGHT;
//    } else {
//        height = OTHER_ROWS_HEIGHT;
//    }
//    
//    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, cell.frame.size.width - 20, height - 10)];
//    backgroundView.backgroundColor = [UIColor whiteColor];
//    backgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
//    backgroundView.layer.shadowOffset = CGSizeMake(1, 1);
//    backgroundView.layer.shadowOpacity = 0.3;
//    backgroundView.layer.shadowRadius = 2.0f;
//    backgroundView.layer.cornerRadius = 2.0f;
//    [cell.contentView addSubview:backgroundView];
    
//    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
//        return FIRST_ROW_HEIGHT;
//    }else {
//        return OTHER_ROWS_HEIGHT;
//    }
    
    return 220;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ScreeningDetailViewController *detailViewController = [[ScreeningDetailViewController alloc] init];
//    screenings = self.objects;
    
    PFObject *selectedScreening = screenings[indexPath.row];
    
    detailViewController.screening = selectedScreening;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
