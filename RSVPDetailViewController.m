//
//  RSVPDetailViewController.m
//  
//
//  Created by Collin Grubbs on 5/2/15.
//
//

#import "RSVPDetailViewController.h"
#import "UIColor+BFPaperColors.h"
#import "RSVPedTableTableViewController.h"
#import <SIAlertView/SIAlertView.h>

NSString *const kValidationName = @"kName";
NSString *const kValidationEmail = @"kEmail";
NSString *const kValidationInteger = @"kInteger";
NSString *const khiderow = @"kTerms";
NSString *const khidesection = @"tag2";
NSString *const khidetext = @"tag3";

@interface RSVPDetailViewController ()

@property (nonatomic, strong) PFObject *guestList;

@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, strong) PFQuery *query;


@end


@implementation RSVPDetailViewController
@synthesize guestList = _guestList;
@synthesize screening = _screening;
@synthesize defaults = _defaults;
@synthesize query = _query;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (void)initializeForm
{
    //initialize new Guestlist Object
    self.guestList = [PFObject objectWithClassName:@"GuestList"];
    // query
    self.query = [PFQuery queryWithClassName:@"GuestList"];
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveLocal:) name:UIKeyboardDidHideNotification object:nil];
    
    XLFormDescriptor *form;
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    form = [XLFormDescriptor formDescriptorWithTitle:@"RSVP"];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Information"];
    section.footerTitle = @"No more than 4 tickets";
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kValidationName rowType:XLFormRowDescriptorTypeName];
    [row.cellConfigAtConfigure setObject:@"Name" forKey:@"textField.placeholder"];
    row.required = YES;
    row.value = [self.defaults objectForKey:@"name"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kValidationEmail rowType:XLFormRowDescriptorTypeEmail];
    [row.cellConfigAtConfigure setObject:@"Email" forKey:@"textField.placeholder"];
    row.required = YES;
    row.value = [self.defaults objectForKey:@"email"];
    [row addValidator: [XLFormValidator emailValidator]];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kValidationInteger rowType:XLFormRowDescriptorTypeInteger];
    [row.cellConfigAtConfigure setObject:@"Guests" forKey:@"textField.placeholder"];
    row.required = YES;
    
    if ([self.defaults objectForKey:@"sitting"]) {
        row.value = [self.defaults objectForKey:@"sitting"];
    } else {
        row.value = @1;
    }
    
    [row addValidator:[XLFormRegexValidator formRegexValidatorWithMsg:@"Sorry, no more than 4 seats" regex:@"^[1-4]$"]];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Terms & Conditions"];
    NSLog(@"%@", [self.screening objectForKey:@"screeningTerms"]);
    // TODO: Check to usability.
    section.footerTitle = [self.screening objectForKey:@"screeningTerms"];
    
    [form addFormSection:section];
    
    // TODO: remember that user has accepted terms & conditions for screening
    row = [XLFormRowDescriptor formRowDescriptorWithTag:khiderow rowType:XLFormRowDescriptorTypeBooleanSwitch title:@" I agree to the Terms & Conditions"];
//    row.hidden = [NSString stringWithFormat:@"$%@==0", khiderow];
    row.value = @0;
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:khidesection rowType:XLFormRowDescriptorTypeButton title:@"Sign me up!"];
    [row.cellConfigAtConfigure setObject:[UIColor paperColorRed] forKey:@"backgroundColor"];
    [row.cellConfig setObject:[UIColor whiteColor] forKey:@"textLabel.color"];
    [row.cellConfig setObject:[UIFont fontWithName:@"Helvetica" size:38] forKey:@"textLabel.font"];
    row.hidden = [NSString stringWithFormat:@"$%@==0", khiderow];
    row.value = @1;
    row.action.formSelector = @selector(rsvp:);
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    [form addFormSection:section];

    self.form = form;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:@"Button"]){
        return 100.0;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[SIAlertView appearance] setMessageFont:[UIFont systemFontOfSize:13]];
    [[SIAlertView appearance] setButtonColor:[UIColor paperColorGreen]];
    [[SIAlertView appearance] setCancelButtonColor:[UIColor paperColorRed]];
    [[SIAlertView appearance] setDestructiveButtonColor:[UIColor paperColorBlue]];
}

- (void)rsvp:(UIButton *)sender
{
    SIAlertView *saveAlert = [[SIAlertView alloc] initWithTitle:@"RSVP Saved!" andMessage:@"Your reservations has been saved."];
    SIAlertView *updateAlert = [[SIAlertView alloc] initWithTitle:@"RSVP Updated!" andMessage:@"Your reservation has been updated."];
    
    [saveAlert addButtonWithTitle:@"OK" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert) { NSLog(@"OK button Clicked");}];
    [updateAlert addButtonWithTitle:@"OK" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert) { NSLog(@"OK button Clicked");}];
    
    saveAlert.transitionStyle = SIAlertViewTransitionStyleBounce;
    updateAlert.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    NSLog(@"%@", [self formValidationErrors]);
    if ([[self formValidationErrors] count] >= 1) {
        [self validateForm:self];
        return;
    } else {
        self.guestList[@"screening"] = self.screening;
        self.guestList[@"user"] = [PFUser currentUser];
        self.guestList[@"name"] = [self.defaults objectForKey:@"name"];
        self.guestList[@"email"] = [self.defaults objectForKey:@"email"];
        self.guestList[@"sitting"] = [self.defaults objectForKey:@"sitting"];

        [self.query whereKey:@"screening" equalTo:self.screening];
        [self.query whereKey:@"user" equalTo:[PFUser currentUser]];

        [self.query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                object[@"screening"] = self.screening;
                object[@"user"] = [PFUser currentUser];
                object[@"name"] = [self.defaults objectForKey:@"name"];
                object[@"email"] = [self.defaults objectForKey:@"email"];
                object[@"sitting"] = [self.defaults objectForKey:@"sitting"];
                [object saveInBackground];
                [object pinInBackground];
                [updateAlert show];
            }else {
                [self.guestList saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        [self.guestList pinInBackground];
                        [self.guestList saveEventually];
                        [saveAlert show];
                    }else {

                    }
                }];
            }

        }];
        
        RSVPedTableTableViewController *detailViewController = [[RSVPedTableTableViewController alloc] init];
        detailViewController.screening = self.screening;
        [detailViewController.tableView reloadData];
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    }
}

- (void)validateForm:(id)sender
{
    NSArray *array = [self formValidationErrors];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XLFormValidationStatus *validationStatus  = [[obj userInfo] objectForKey:XLValidationStatusErrorKey];
        
        if ([validationStatus.rowDescriptor.tag isEqualToString:kValidationName]) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:validationStatus.rowDescriptor]];
//            [validationStatus.rowDescriptor.cellConfigAtConfigure setObject:[UIColor paperColorRed300] forKey:@"textLabel.textColor"];
//            [self reloadFormRow:validationStatus.rowDescriptor];
            [self animateCell:cell];
            
        }else if ([validationStatus.rowDescriptor.tag isEqualToString:kValidationEmail]){
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:validationStatus.rowDescriptor]];
            cell.textLabel.textColor = [UIColor paperColorRed300];
            [self animateCell:cell];
        }else if ([validationStatus.rowDescriptor.tag isEqualToString:kValidationInteger]){
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:validationStatus.rowDescriptor]];
            cell.textLabel.textColor = [UIColor paperColorRed300];
            [self animateCell:cell];
        }
        
    }];
    
}

- (void)saveLocal:(NSNotification *)notify
{
    for (id key in [self.form formValues]) {
        if ([key isEqualToString:kValidationName]) {
            [self.defaults setObject:[[self.form formValues] objectForKey:key] forKey:@"name"];
            [self.defaults synchronize];
        } else if ([key isEqualToString:kValidationEmail]){
            [self.defaults setObject:[[self.form formValues] objectForKey:key] forKey:@"email"];
            [self.defaults synchronize];
        } else if ([key isEqualToString:kValidationInteger]) {
            [self.defaults setObject:[[self.form formValues] objectForKey:key] forKey:@"sitting"];
            [self.defaults synchronize];
        }
    }
}

-(void)animateCell:(UITableViewCell *)cell
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values =  @[ @0, @20, @-20, @10, @0];
    animation.keyTimes = @[@0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.additive = YES;
    
    [cell.layer addAnimation:animation forKey:@"shake"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end

