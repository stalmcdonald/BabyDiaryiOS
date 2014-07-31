//
//  ViewController.h
//  BabyDiaryiOS
//
//  Created by CRYSTAL MCDONALD on 7/24/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

//Network connection status
@property (assign, nonatomic) IBOutlet UILabel * networkConnection;
@property (assign, nonatomic) IBOutlet UILabel * networkStatus;

- (IBAction)logUserIn:(id)sender;
- (IBAction)signUserUp:(id)sender;

@end
