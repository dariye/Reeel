//
//  RSVPedTableTableViewController.m
//  Reeel
//
//  Created by Paul Dariye on 5/19/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "RSVPedTableTableViewController.h"
#import "RSVPTableViewCell.h"


#define FIRST_ROW_HEIGHT 220;
#define OTHER_ROWS_HEIGHT 110;

@interface RSVPedTableTableViewController ()

@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIView *mapImageView;
@property (nonatomic, strong) UIButton *ticketButton;
@property (nonatomic, strong) UIButton *cancelRSVPButton;


@end

@implementation RSVPedTableTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = [self.screening objectForKey:@"screeningTitle"];
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.91 alpha:1.0];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return ([UIScreen mainScreen].bounds.size.height - 64 - 49) / 2;
    }else {
        return ([UIScreen mainScreen].bounds.size.height - 64 - 49) / 4 - 5;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RSVPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RSVPsCell" forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RSVPsCell"];
    
    if (!cell) {
        
        [tableView registerNib:[UINib nibWithNibName:@"RSVPTableViewCell" bundle:nil] forCellReuseIdentifier:@"RSVPsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"RSVPsCell"];
        
        [cell setBackgroundColor:self.tableView.backgroundColor];
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }

    cell.backgroundColor = [UIColor clearColor];


    CGFloat height = 0;
    if (indexPath.row == 0) {
        height = ([UIScreen mainScreen].bounds.size.height - 64 - 49) / 2;
    } else {
        height = ([UIScreen mainScreen].bounds.size.height - 64 - 49) / 4;
    }

    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, height - 10)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    backgroundView.layer.shadowOffset = CGSizeMake(1, 1);
    backgroundView.layer.shadowOpacity = 0.3;
    backgroundView.layer.shadowRadius = 2.0f;
    backgroundView.layer.cornerRadius = 2.0f;
    
    [cell.contentView addSubview:backgroundView];
    
    
    /* Map View 
    - pull saved screening location image from parse
     */
    
    
   
    //self.button.contentMode = UIViewContentModeScaleAspectFit;
    
    
    if (indexPath.row == 0) {
       self.mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backgroundView.frame.size.width, backgroundView.frame.size.height * 2/3)];
       self.mapImageView.clipsToBounds = YES;
        
       self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.text = [self.screening objectForKey:@"screeningLocation"];
       [cell addSubview:self.descriptionLabel];
        
    }else if (indexPath.row == 1){
        self.ticketButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.ticketButton.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, height - 10);
        [self.ticketButton setContentMode:UIViewContentModeScaleAspectFit];
        [self.ticketButton setClipsToBounds:YES];
        [self.ticketButton setBackgroundColor:[UIColor whiteColor]];
        [self.ticketButton setTitle:@"Ticket" forState:UIControlStateNormal];
        [self.ticketButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.ticketButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
        [cell addSubview:self.ticketButton];
        
    }else {
        self.cancelRSVPButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelRSVPButton.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, height - 10);
        [self.cancelRSVPButton setContentMode:UIViewContentModeScaleAspectFit];
        [self.cancelRSVPButton setClipsToBounds:YES];
        [self.cancelRSVPButton setBackgroundColor:[UIColor whiteColor]];
        [self.cancelRSVPButton setTitle:@"Cancel RSVP" forState:UIControlStateNormal];
        [self.cancelRSVPButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.cancelRSVPButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
 
        [cell addSubview:self.cancelRSVPButton];
    }

    return cell;
}



@end
