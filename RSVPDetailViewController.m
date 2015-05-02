//
//  RSVPDetailViewController.m
//  
//
//  Created by Collin Grubbs on 5/2/15.
//
//

#import "RSVPDetailViewController.h"

@interface RSVPDetailViewController () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userEmailLabel;
@property (weak, nonatomic) IBOutlet UITextField *guestsLabel;

@property (weak, nonatomic) IBOutlet UILabel *termsLabel;
@property (retain, nonatomic) IBOutlet UISwitch *termsSwitch;
@property (retain, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation RSVPDetailViewController

@synthesize userNameLabel;
@synthesize userEmailLabel;
@synthesize guestsLabel;
@synthesize termsLabel;
@synthesize termsSwitch;
@synthesize confirmButton;

- (void)viewDidLoad {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    userNameLabel.text = [defaults objectForKey:@"userName"];
    userEmailLabel.text = [defaults objectForKey:@"userEmail"];
    guestsLabel.text = @"Number of guests";
    termsLabel.text = @"Agree to Terms and Conditions";
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveUserData:) name:UIKeyboardDidHideNotification object:nil];


    
    // Do any additional setup after loading the view from its nib.
    // Set background color of view
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"RSVP";
    
}


- (IBAction) toggleEnabledConfirmButton: (id) sender {
    if (termsSwitch.on) confirmButton.enabled = YES;
    else {
        confirmButton.enabled = NO;
    }
}

- (void)saveUserData: (NSNotification *)notify
{
    [userNameLabel resignFirstResponder];
    [userEmailLabel resignFirstResponder];
    [guestsLabel resignFirstResponder];
    
    NSString *userName = [userNameLabel text];
    NSString *userEmail = [userEmailLabel text];
    //NSString *guests = [guestsLabel text];
    
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
