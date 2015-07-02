//
//  ProfileInformationViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/29/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ProfileInformationViewController.h"
#import <SIAlertView/SIAlertView.h>

NSString *const kName = @"kName";
NSString *const kEmail = @"kEmail";

@interface ProfileInformationViewController ()
@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation ProfileInformationViewController

@synthesize defaults = _defaults;

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
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveLocal:) name:UIKeyboardDidHideNotification object:nil];
    
    XLFormDescriptor *form;
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    form = [XLFormDescriptor formDescriptorWithTitle:@"Information"];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kName rowType:XLFormRowDescriptorTypeName];
    [row.cellConfigAtConfigure setObject:@"Name" forKey:@"textField.placeholder"];
    row.required = YES;
    row.value = [self.defaults objectForKey:@"name"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kEmail rowType:XLFormRowDescriptorTypeEmail];
    [row.cellConfigAtConfigure setObject:@"Email" forKey:@"textField.placeholder"];
    row.required = YES;
    row.value = [self.defaults objectForKey:@"email"];
    [row addValidator: [XLFormValidator emailValidator]];
    [section addFormRow:row];
    
    self.form = form;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:@"Button"]){
        return 100.0;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)saveLocal:(NSNotification *)notify
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Personal Info Updated!" andMessage:@""];
    
    [alertView addButtonWithTitle:@"OK" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert) { NSLog(@"OK button Clicked");}];
    
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    for (id key in [self.form formValues]) {
        if ([key isEqualToString:kName]) {
            [self.defaults setObject:[[self.form formValues] objectForKey:key] forKey:@"name"];
            [self.defaults synchronize];
            [alertView show];
        } else if ([key isEqualToString:kEmail]){
            [self.defaults setObject:[[self.form formValues] objectForKey:key] forKey:@"email"];
            [self.defaults synchronize];
            [alertView show];
        }
    }
}


@end
