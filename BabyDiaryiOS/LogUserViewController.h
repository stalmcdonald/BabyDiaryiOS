//
//  LogUserViewController.h
//  BabyDiaryiOS
//
//  Created by CRYSTAL MCDONALD on 7/24/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogUserViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameCredentials;
@property (weak, nonatomic) IBOutlet UITextField *passwordCredentials;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)didTapLogin:(id)sender;

@end