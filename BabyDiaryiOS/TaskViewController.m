//
//  TaskViewController.m
//  BabyDiaryiOS
//
//  Created by CRYSTAL MCDONALD on 7/24/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import "TaskViewController.h"
#import "Reachability.h"

@interface TaskViewController ()

-(void)reachabilityChanged:(NSNotification*)note;

@end

@implementation TaskViewController
@synthesize entry, networkConnection, networkStatus;

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
    [entry becomeFirstResponder];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            networkConnection.text = @"Milestone Entry";
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            networkConnection.text = @"Network Status: OFFLINE";
        });
    };
    
    [reach startNotifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//checks network status
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        networkStatus.text = @"Baby Diary";
    }
    else
    {
        networkStatus.text = @"Offline features limited, new task cannot be saved.";
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning." message:@"Check internet connection. User input restricted." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        //        [alert show];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == entry)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    else
        return YES;
}

- (IBAction)addItem:(id)sender {
    
    NSString *taskEntered = [entry text];
    
    //validation length checker
    if([taskEntered length] < 2 ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unacceptable Entry" message:@"Milestone entered must be at least 2 characters." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        
    }else{
        
        //saves tasks to task list in TaskViewController and gives a confirmation
        PFObject *task = [PFObject objectWithClassName:@"Diary"];
        [task setObject:entry.text forKey:@"entry"];
        
        [task saveInBackground];
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BabyDiary"
                                                        message:@"Milestone added to Diary."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        entry.text=@"";
        
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end