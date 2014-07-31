//
//  LogUserViewController.m
//  BabyDiaryiOS
//
//  Created by CRYSTAL MCDONALD on 7/24/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import "LogUserViewController.h"

@interface LogUserViewController ()

@end

@implementation LogUserViewController

@synthesize usernameCredentials, passwordCredentials, activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Login";
    
    [usernameCredentials setDelegate:self];
    [passwordCredentials setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//once username and password entered there's a check to make sure password length is <4
- (IBAction)didTapLogin:(id)sender {
    
    NSString *username = [usernameCredentials text];
    NSString *password = [passwordCredentials text];
    
    //alert pops up if input is less than 5 characters
    
    if ([username length] < 3 || [password length] < 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Username and Password must both be at least 4 characters long." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else {
        [activityIndicator startAnimating];
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            [activityIndicator stopAnimating];
            if (user) {
                [self performSegueWithIdentifier:@"loginToMain" sender:self];
            } else {
                //alert if credentials are wrong
                NSLog(@"%@",error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed." message:@"Enter valid info." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
}

//goes back if nav button pressed and cancels login
- (void)didTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end