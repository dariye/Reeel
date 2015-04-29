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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Profile";

    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
// #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
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
//
//-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 5)];
//}
//

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
        // Pass the selected object to the new view controller.
    
    // Push the view controller.
    if (indexPath.section == 0) {
        ProfileInformationViewController *detailViewController = [[ProfileInformationViewController alloc] init];

        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    if (indexPath.section == 2) {
        TermsAndConditionsViewController *detailViewController = [[TermsAndConditionsViewController alloc] init];

        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
