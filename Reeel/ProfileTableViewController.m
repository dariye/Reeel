//
//  ProfileTableViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "ProfileInformationViewController.h"
#import "TermsAndConditionsViewController.h"
@interface ProfileTableViewController ()


@end

@implementation ProfileTableViewController

// differentiate alerts
#define TAG_PRIMARY 1
#define TAG_SECONDARY 2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Profile";
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Personal";
    }else if(section == 1) {
        return @"Notifications";
    } else {
        return @"";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"ProfileTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"Information";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"Allow Notifications?";
    } else if (indexPath.section == 2) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"Terms & Conditions";
    } else {
        
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 50;
    return 30;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ProfileInformationViewController *detailViewController = [[ProfileInformationViewController alloc] init];
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    if (indexPath.section == 1) {
        if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
            UIAlertView *notice = [[UIAlertView alloc] initWithTitle:@"You've Already Permitted 'Reeel' to Send You Push Notifications" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [notice show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"'Reeel' Would Like to Send You Push Notifications" message:@"Notifications may include alerts, sounds and icon badges. These can be configured in Settings." delegate:self cancelButtonTitle:@"Don't Allow" otherButtonTitles:@"OK", nil];
            [self.tableView deselectRowAtIndexPath:[self.tableView
                                                    indexPathForSelectedRow] animated: YES];
            alert.tag = TAG_PRIMARY;
            [alert show];
        }
        
    }
    if (indexPath.section == 2) {
        TermsAndConditionsViewController *detailViewController = [[TermsAndConditionsViewController alloc] init];
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == TAG_PRIMARY){
        if (buttonIndex == 0) {
            if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
                [[UIApplication sharedApplication] unregisterForRemoteNotifications];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"'Reeel' Will No Longer Send You Push Notifications" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                alert.tag = TAG_SECONDARY;
                [alert show];
            }
        }
        if (buttonIndex == 1) {
            if (![[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"'Reeel' Will Now Send You Push Notifications" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                alert.tag = TAG_SECONDARY;
                [alert show];
            }
        }
        
    }
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
