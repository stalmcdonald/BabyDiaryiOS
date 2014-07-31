//
//  ViewController.m
//  BabyDiaryiOS
//
//  Created by CRYSTAL MCDONALD on 7/24/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//


#import "ViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@interface ViewController ()

//-(void)reachabilityChanged:(NSNotification*)note;

@end

@implementation ViewController

//@synthesize networkConnection, networkStatus;

@synthesize indicator, logInButton, signUpButton;

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
	// Do any additional setup after loading the view.
    [self checkStatus];
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(reachabilityChanged:)
    //                                                 name:kReachabilityChangedNotification
    //                                               object:nil];
    //
    //    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    //
    //    reach.reachableBlock = ^(Reachability * reachability)
    //    {
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            networkConnection.text = @"Network Status: ONLINE";
    //        });
    //    };
    //
    //    reach.unreachableBlock = ^(Reachability * reachability)
    //    {
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            networkConnection.text = @"Network Status: OFFLINE";
    //        });
    //    };
    //
    //    [reach startNotifier];
}

//comment code below to prompt login each time
- (void)viewDidAppear:(BOOL)animated {
    //    [self checkStatus];
}

//checks status of user login/signup if its yes goes to ListViewController to show Data table with users tasks for the day
- (void)checkStatus {
    [indicator startAnimating];
    [logInButton setHidden:YES];
    [signUpButton setHidden:YES];
    
    if ([PFUser currentUser]) {
        [self performSegueWithIdentifier:@"gotoMainView" sender:self];
    } else {
        [indicator stopAnimating];
        [logInButton setHidden:NO];
        [signUpButton setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////checks network status
//-(void)reachabilityChanged:(NSNotification*)note
//{
//    Reachability * reach = [note object];
//
//    if([reach isReachable])
//    {
//        networkStatus.text = @"Notification";
//    }
//    else
//    {
//        networkStatus.text = @"Offline features limited";
//    }
//}


//automatically skips code below if user is logged in/signed up

//if user is signed out this button goes to login screen
- (IBAction)logUserIn:(id)sender {
    [self performSegueWithIdentifier:@"gotoLogUserView" sender:self];
}

//if user needs to sign up this button goes to the signup page
- (IBAction)signUserUp:(id)sender {
    [self performSegueWithIdentifier:@"gotoSignUpView" sender:self];
}
@end