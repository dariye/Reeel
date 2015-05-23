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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
        height = FIRST_ROW_HEIGHT;
    } else {
        height = OTHER_ROWS_HEIGHT;
    }

    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, cell.frame.size.width - 20, height - 10)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    backgroundView.layer.shadowOffset = CGSizeMake(1, 1);
    backgroundView.layer.shadowOpacity = 0.3;
    backgroundView.layer.shadowRadius = 2.0f;
    backgroundView.layer.cornerRadius = 2.0f;
    
    [cell.contentView addSubview:backgroundView];
    
    
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.descriptionLabel.textColor = [UIColor blackColor];
    
    self.descriptionLabel.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:self.descriptionLabel];
    
    switch (indexPath.row) {
        case 0:
            break;
            
        case 1:
            self.descriptionLabel.text = @"Ticket";
            break;
        case 2:
            self.descriptionLabel.text = @"Cancel RSVP";
           
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return FIRST_ROW_HEIGHT;
    }else {
        return OTHER_ROWS_HEIGHT;
    }
}


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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
