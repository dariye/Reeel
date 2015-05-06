//
//  ProfileInformationViewController.m
//  Reeel
//
//  Created by Paul Dariye on 4/29/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ProfileInformationViewController.h"

@interface ProfileInformationViewController () <UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userEmailLabel;

@property (nonatomic, assign) id currentResponder;

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
    
    // remove keyboard with outside touch
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
    //[singleTap release];
    

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

// check to see if text field is in the format of an email, triggers an alert if it is not
- (void)checkEmailAndDisplayAlert {
    if(![self validateEmail:[userEmailLabel text]]) {
        // user entered invalid email address
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a valid email address." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        //[alert release];
    } else {
        // user entered valid email address
    }
}

// check to determine whether a text field is a valid email
- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}


// makes sure fields are valid when edited
- (IBAction) checkFields: (id) sender {
    if (sender == userNameLabel) {
        if (!userNameLabel.text.length > 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a valid name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
    if (sender == userEmailLabel) {
        [self checkEmailAndDisplayAlert];
    }
    if (sender == userNameLabel) {
        if (!userEmailLabel.text.length > 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a valid name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            }
        }
    }

// keyboard removal through touch outside keyboard
- (void)resignOnTap:(id)iSender {
    [self.currentResponder resignFirstResponder];
}

// assist keyboard removal by identifying first responder
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}


// hide keyboard on return key
-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
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
