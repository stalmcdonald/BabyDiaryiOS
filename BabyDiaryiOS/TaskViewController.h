//
//  TaskViewController.h
//  BabyDiaryiOS
//
//  Created by CRYSTAL MCDONALD on 7/24/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface TaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *entry;
- (IBAction)addItem:(id)sender;


//Network connection status
@property (assign, nonatomic) IBOutlet UILabel * networkConnection;
@property (assign, nonatomic) IBOutlet UILabel * networkStatus;

@end
