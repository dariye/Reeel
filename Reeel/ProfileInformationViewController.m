//
//  ProfileInformationViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/29/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ProfileInformationViewController.h"

@interface ProfileInformationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userEmailLabel;

@end

@implementation ProfileInformationViewController

@synthesize userNameLabel;
@synthesize userEmailLabel;

- (void)viewDidLoad {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    userNameLabel.text = [defaults objectForKey:@"userName"];
    userEmailLabel.text = [defaults objectForKey:@"userEmail"];
    
    [super viewDidLoad];
    self.navigationItem.title = @"Information";
    // Do any additional setup after loading the view from its nib.
    
    // Listen for keyboard appearances and disappearances
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveUserData:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)saveUserData: (NSNotification *)notify
{
    [userNameLabel resignFirstResponder];
    [userEmailLabel resignFirstResponder];
    
    NSString *userName = [userNameLabel text];
    NSString *userEmail = [userEmailLabel text];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:userName forKey:@"userName"];
    [defaults setObject:userEmail forKey:@"userEmail"];
    [defaults synchronize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
