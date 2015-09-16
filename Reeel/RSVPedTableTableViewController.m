//
//  RSVPedTableTableViewController.m
//  Reeel
//
//  Created by Paul Dariye on 5/19/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "RSVPedTableTableViewController.h"
#import "RSVPTableViewController.h"
#import "RSVPTableViewCell.h"
#import "UIColor+BFPaperColors.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SIAlertView/SIAlertView.h>
#import <MapKit/MapKit.h>
#import "GoogleMapsKit.h"
#import "RSVPDetailViewController.h"

#define FIRST_ROW_HEIGHT 220;
#define OTHER_ROWS_HEIGHT 110;

@interface RSVPedTableTableViewController () <UIActionSheetDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIImageView *mapImageView;
@property (nonatomic, strong) UIButton *ticketButton;
@property (nonatomic, strong) UIButton *cancelRSVPButton;
@property (nonatomic, strong) UIButton *mapButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) double currentLat;
@property (nonatomic) double currentLng;

@end

@implementation RSVPedTableTableViewController

@synthesize mapButton = _mapButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = [self.screening objectForKey:@"screeningTitle"];
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.91 alpha:1.0];
    [[SIAlertView appearance] setMessageFont:[UIFont systemFontOfSize:13]];
    [[SIAlertView appearance] setButtonColor:[UIColor paperColorGreen]];
    [[SIAlertView appearance] setCancelButtonColor:[UIColor paperColorRed]];
    [[SIAlertView appearance] setDestructiveButtonColor:[UIColor paperColorBlue]];
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
    backgroundView.layer.shadowOpacity = 0.2;
    backgroundView.layer.shadowRadius = 1.0f;
    backgroundView.layer.cornerRadius = 1.0f;
    
    [cell.contentView addSubview:backgroundView];
    
    
    /* Map View 
    - pull saved screening location image from parse
     */
    
    
    if (indexPath.row == 0) {
        
        self.mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.mapButton.frame = CGRectMake(0, 0, backgroundView.frame.size.width, backgroundView.frame.size.height * 2/3);
        [self.mapButton addTarget:self action:@selector(openLocationInMaps:) forControlEvents:UIControlEventTouchUpInside];
        
        self.mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backgroundView.frame.size.width, backgroundView.frame.size.height * 2/3)];
        self.mapImageView.clipsToBounds = YES;
        [self.mapImageView sd_setImageWithURL:[NSURL URLWithString:[self.screening objectForKey:@"locationImage"]] placeholderImage:nil];
        [self.mapButton addSubview:self.mapImageView];

        [backgroundView addSubview:self.mapButton];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.mapButton.frame.size.height + 5, backgroundView.frame.size.width - 25, 21)];
        [self.descriptionLabel setText:[self.screening objectForKey:@"screeningLocation"]];
        self.descriptionLabel.numberOfLines = 0;
        [self.descriptionLabel sizeToFit];
        self.descriptionLabel.font = [UIFont systemFontOfSize:14];
        self.descriptionLabel.textColor = [UIColor lightGrayColor];
        [backgroundView addSubview:self.descriptionLabel];
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
        [self.cancelRSVPButton setBackgroundColor:[UIColor paperColorRed600]];
        [self.cancelRSVPButton setTitle:@"Cancel RSVP" forState:UIControlStateNormal];
        [self.cancelRSVPButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.cancelRSVPButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
        
        [self.cancelRSVPButton addTarget:self action:@selector(confirmButton:) forControlEvents:UIControlEventTouchUpInside];
 
        [cell addSubview:self.cancelRSVPButton];
    }

    return cell;
}

- (void)confirmButton:(id)sender
{
    SIAlertView *confirmAlertView = [[SIAlertView alloc] initWithTitle:@"Cancel RSVP" andMessage:@"Are you sure you want to cancel your RSVP?"];
    [confirmAlertView addButtonWithTitle:@"Cancel" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alert) { return; }];
    [confirmAlertView addButtonWithTitle:@"OK" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert) { [self optOutButton:self]; }];
    
    confirmAlertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    
    [confirmAlertView show];
}

- (void)optOutButton:(id)sender
{
    
    SIAlertView *cancelAlertView = [[SIAlertView alloc] initWithTitle:@"RSVP Removed!" andMessage:@"We'll miss you"];
    
    [cancelAlertView addButtonWithTitle:@"OK" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert) { NSLog(@"OK button Clicked");}];
    
    cancelAlertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    PFQuery *query = [PFQuery queryWithClassName:@"GuestList"];
    [query whereKey:@"screening" equalTo:self.screening];
    [query includeKey:@"user"];
    
    PFQuery *guestlistQuery = [PFQuery queryWithClassName:@"GuestList"];
    [guestlistQuery fromLocalDatastore];
    [guestlistQuery whereKey:@"screening" equalTo:self.screening];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        if (!error) {
            RSVPTableViewController *rsvpView = [[RSVPTableViewController alloc] init];
            [object unpinInBackground];
//            [detailView.tableView reloadData];
            [self.navigationController popViewControllerAnimated:YES];
            [rsvpView.navigationController popToRootViewControllerAnimated:YES];
            [self.navigationController pushViewController:rsvpView animated:YES];
            [cancelAlertView show];
            [object deleteInBackground];
        }
        
    }];
}

- (void)openLocationInMaps:(id)sender
{
    
    if([GoogleMapsKit isGoogleMapsInstalled]){
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Maps", @"Open in Google Maps", nil];
        [actionSheet showInView:self.view];
    } else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Maps", nil];
        [actionSheet showInView:self.view];
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    self.currentLat = location.coordinate.latitude;
    self.currentLng = location.coordinate.latitude;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //TODO: Review this 
    [self.locationManager stopUpdatingLocation];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(nil == self.locationManager){
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    
    double lat = [[[self.screening objectForKey:@"latlng"] objectForKey:@"lat"] doubleValue];
    double lng = [[[self.screening objectForKey:@"latlng"] objectForKey:@"lng"] doubleValue];
    
    CLLocationCoordinate2D screeningLocation = CLLocationCoordinate2DMake(lat,lng);
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:screeningLocation addressDictionary:nil];
    
    if (buttonIndex == 0) {
        if ([CLLocationManager locationServicesEnabled]) {
            MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
            destination.name = [self.screening objectForKey:@"screeningLocation"];
        
            NSArray *items = [[NSArray alloc] initWithObjects:destination, nil];
            NSDictionary *options = [[NSDictionary alloc] initWithObjectsAndKeys:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsDirectionsModeDriving, nil];
            [MKMapItem openMapsWithItems:items launchOptions:options];
 
        }else {
            MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
            destination.name = [self.screening objectForKey:@"screeningLocation"];
            [destination openInMapsWithLaunchOptions:nil];
        }
       
    }else if (buttonIndex == 1) {
        if([GoogleMapsKit isGoogleMapsInstalled]){
            if ([CLLocationManager locationServicesEnabled]) {
                [GoogleMapsKit showMapWithDirectionsForStartingPointCoordinate:CLLocationCoordinate2DMake(self.currentLat, self.currentLng) endPointCoordinate:screeningLocation directionsMode:GoogleMapsDirectionsModeTransit];
                
            } else {
                [GoogleMapsKit  showMapWithCenter:CLLocationCoordinate2DMake(lat, lng) zoom:14 mapMode:GoogleMapsModeDefault view:GoogleMapsViewClearAll];
            }
        }
    }
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}



@end
