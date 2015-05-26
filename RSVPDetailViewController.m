//
//  RSVPDetailViewController.m
//  
//
//  Created by Collin Grubbs on 5/2/15.
//
//

#import "RSVPDetailViewController.h"



@interface RSVPDetailViewController () <UINavigationControllerDelegate, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userEmailLabel;
@property (weak, nonatomic) IBOutlet UITextField *guestsLabel;

@property (weak, nonatomic) IBOutlet UILabel *termsLabel;
@property (retain, nonatomic) IBOutlet UISwitch *termsSwitch;
@property (retain, nonatomic) IBOutlet UIButton *confirmButton;

@property (nonatomic, assign) id currentResponder;

@property (nonatomic, strong) PFObject *guestList;

@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, strong) PFQuery *query;


@end

@implementation RSVPDetailViewController 

@synthesize userNameLabel;
@synthesize userEmailLabel;
@synthesize guestsLabel;
@synthesize termsLabel;
@synthesize termsSwitch;
@synthesize confirmButton;
@synthesize guestList;
@synthesize screening = _screening;
@synthesize defaults;
@synthesize query;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initialize new Guestlist Object
    guestList = [PFObject objectWithClassName:@"GuestList"];
    // query
    query = [PFQuery queryWithClassName:@"GuestList"];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    userNameLabel.text = [defaults objectForKey:@"userName"];
    userEmailLabel.text = [defaults objectForKey:@"userEmail"];
    guestsLabel.text = [defaults objectForKey:@"guestCount"];
    termsLabel.text = @"Agree to Terms and Conditions";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveUserData:) name:UIKeyboardDidHideNotification object:nil];
    
    // remove keyboard with outside touch
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    
    [singleTap setNumberOfTapsRequired:1];
    
    [singleTap setNumberOfTouchesRequired:1];
    
    [self.view addGestureRecognizer:singleTap];
    //[singleTap release];
    
}

- (IBAction)RSVPButtonPressed:(UIButton *)sender
{
    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:@"Thank You" message:@"Your RSVP has been confirmed." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
     UIAlertView *updateAlert = [[UIAlertView alloc] initWithTitle:@"RSVP Updated" message:@"Your RSVP Information has been updated" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    guestList[@"screening"] = self.screening;
    guestList[@"user"] = [PFUser currentUser];
    guestList[@"guestName"] = [defaults objectForKey:@"userName"];
    guestList[@"guestEmail"] = [[defaults objectForKey:@"userEmail"] lowercaseString];
    guestList[@"guestCount"] = [defaults objectForKey:@"guestCount"];
    
    [query whereKey:@"screening" equalTo:self.screening];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        if (!error) {
            object[@"screening"] = self.screening;
            object[@"user"] = [PFUser currentUser];
            object[@"guestName"] = [defaults objectForKey:@"userName"];
            object[@"guestEmail"] = [[defaults objectForKey:@"userEmail"] lowercaseString];
            object[@"guestCount"] = [defaults objectForKey:@"guestCount"];
            [object saveInBackground];
            [object pinInBackground];
            [updateAlert show];
            
        }else {
            
            [guestList saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [guestList pinInBackground];
                    [guestList saveEventually];
                    [saveAlert show];
                    
                }else {
                    
                }
            }];
            
           
        }
        
    }];

}

- (IBAction)optOutButton:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"RSVP Removed" message:@"We'll miss you" delegate:self cancelButtonTitle:@"Not sure?" otherButtonTitles:@"OK", nil];
    
    
    [query whereKey:@"screening" equalTo:self.screening];
    [query includeKey:@"user"];
    
    PFQuery *guestlistQuery = [PFQuery queryWithClassName:@"GuestList"];
    [guestlistQuery fromLocalDatastore];
    [guestlistQuery whereKey:@"screening" equalTo:self.screening];
    
    [query getObjectInBackgroundWithId:guestList.objectId block:^(PFObject *gl, NSError *error){
        
        if (!error) {
            [alert show];
            [gl deleteInBackground];
            
        } else {
            [guestlistQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
                if (!error) {
                    [alert show];
                    [object unpinInBackground];
                    
                }
            }];
        }
        
    }];

}


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

// restrict keyboard selection to non-zero integers for guests label
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == guestsLabel) {
        NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"123456789"] invertedSet];
        if ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0)return YES;
        if (!string.length)return YES;

        return NO;
    }
    else {
        return YES;
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

// terms and conditions must be accepted, all fields completed correctly before confirmation enabled. specific warnings on exit of uncompleted fields
- (IBAction)toggleEnabledConfirmButton: (id) sender {
    if (sender == guestsLabel) {
        if ((!guestsLabel.text.length > 0) && (![guestsLabel.text intValue] > 0)) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a valid number of guests" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
    if (sender == userNameLabel) {
        if (!userNameLabel.text.length > 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a valid name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
    if (sender == userEmailLabel) {
        [self checkEmailAndDisplayAlert];
    }
    if ((termsSwitch.on) && (guestsLabel.text.length > 0) && (userEmailLabel.text.length > 0) && (userNameLabel.text.length > 0) && [self validateEmail:[userEmailLabel text]] && ([guestsLabel.text intValue] > 0)) {
        confirmButton.enabled = YES;
    }
    else {
        confirmButton.enabled = NO;
    }
    }


// data persistence
- (void)saveUserData: (NSNotification *)notify
{
    [userNameLabel resignFirstResponder];
    [userEmailLabel resignFirstResponder];
    [guestsLabel resignFirstResponder];
    
    NSString *userName = [userNameLabel text];
    NSString *userEmail = [userEmailLabel text];
    NSString *guests = [guestsLabel text];
    
    [defaults setObject:userName forKey:@"userName"];
    [defaults setObject:userEmail forKey:@"userEmail"];
    [defaults setObject:guests forKey:@"guestCount"];
    [defaults synchronize];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
