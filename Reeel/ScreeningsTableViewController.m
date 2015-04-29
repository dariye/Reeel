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
#import "Screening.h"
#import "ScreeningStore.h"

@interface ScreeningsTableViewController () <UINavigationControllerDelegate, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, readonly, retain) UIScrollView *scrollView;

@property (nonatomic) float rating;

@end

@implementation ScreeningsTableViewController

@synthesize scrollView;
@synthesize rating;

//- (NSMutableArray *)dataSource
//{
//    if (!_dataSource) {
//        _dataSource = [[NSMutableArray alloc] init];
//    }
//    return _dataSource;
//}

//NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//[formatter setDateFormat:@"yyyy"];
//
////Optionally for time zone conversions
//[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
//
//NSString *stringFromDate = [formatter stringFromDate:myNSDateInstance];
//
////unless ARC is active
//[formatter release];



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[ScreeningStore sharedStore] allScreenings] count] > 1) {
        self.navigationItem.title = @"Upcoming Screenings";
    } else {
        self.navigationItem.title = @"Upcoming Screening";
    }
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"Rows --> %i", [[[ScreeningStore sharedStore] allScreenings] count]);
    return [[[ScreeningStore sharedStore] allScreenings] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreeningsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    rating = 5.5;
    
    NSArray *screenings = [[ScreeningStore sharedStore] allScreenings];
    Screening *screening = screenings[indexPath.row];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ScreeningsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScreeningsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningsCell"];
    }
    
    
    [[cell screeningDescriptionTextView] setText:screening.screeningDescription];
    [[cell screeningDateLabel] setText:screening.screeningDate];
    [[cell screeningLocationLabel] setText:screening.screeningLocation];
    
    // remove padding/margin
    cell.screeningDescriptionTextView.textContainerInset = UIEdgeInsetsZero;
//    [[cell screeningDescriptionLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    
    
    [[cell ratingsLabel] setText:[NSString stringWithFormat:@"Ratings: %.01f/10", rating]];
    
//    self.tableView.tableFooterView = [[UIView alloc] init];
    
    NSLog(@"%@", screening.screeningMetaData);

    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 151;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//         //Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//         //Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}


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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
//    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
//    [self.navigationController pushViewController:detailViewController animated:YES];
    
    ScreeningDetailViewController *detailViewController = [[ScreeningDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//}

@end
