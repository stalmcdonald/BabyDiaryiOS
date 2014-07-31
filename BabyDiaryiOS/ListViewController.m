//
//  ListViewController.m
//  BabyDiaryiOS
//
//  Created by CRYSTAL MCDONALD on 7/24/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//


#import "ListViewController.h"
#import "DetailViewController.h"
#import "ViewController.h"
#import "LogUserViewController.h"

@interface ListViewController ()

@end

//static NSString *CellIdentifier = @"TaskNameCell";

@implementation ListViewController

@synthesize networkConnection, networkStatus;

-  (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithClassName:@"Diary"];
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Diary";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"entry";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // PUll down to refresh cells
        self.pullToRefreshEnabled = YES;
        
        // Pagination disabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    List = @"<html><body>";
    refreshData =0;
	// Do any additional setup after loading the view, typically from a nib.
    
    //edit bar button
    UIBarButtonItem *editButton =[[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEdit)];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.702 green:0 blue:0 alpha:1]; /* red #b30000*/
    self.tabBarController.tabBar.tintColor =[UIColor colorWithRed:0.702 green:0 blue:0 alpha:1]; /* red #b30000*/
    self.navigationItem.rightBarButtonItem = editButton;
    self.navigationItem.rightBarButtonItem = editButton;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"edit"]) {
//        UITableViewCell *cell = sender;
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//
//        UINavigationController *navigationController = segue.destinationViewController;
//        ViewController *viewController = (ViewController *)navigationController.topViewController;
//        viewController. = [self.fetchedResultsController objectAtIndexPath: indexPath];
//
//    }
//}

#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    counter =[query countObjects];
    NSLog(@"%ld",(long)counter);
    
    
    
    // If no objects are loaded in memory, goes to cache first to fill the table
    // and then does a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    
    return query;
    
}



// customizing cell so it doesnt start with the first key in object but the last
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"entry"];
    
    
    
    //Create the list
    if(refreshData <counter)
    {
        NSString *br = @"<br>";
        List = [NSString stringWithFormat:@"%@%@%@", List, br, cell.textLabel.text];
        NSLog(@"%@",List);
        refreshData ++;
    }
    
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self loadObjects];
        }];
    }
}
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//        //reset uitableviewcell textlabel with default input "empty"
//        List = @"empty";
//        [self.tableView reloadData]; //reloads the tabels so you can see the value.
//
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}

-(IBAction)logoutBttn:(id)sender {
    
    [PFUser logOut];;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    
    //selecting row seques to TaskViewController
    [self performSegueWithIdentifier:@"editing" sender:self];
    
    
}

//edit/delete
-(void)toggleEdit
{
    //toggle the edit/delete view
    [TaskTabView setEditing:!TaskTabView.editing animated:YES];
    
    if (TaskTabView.editing)
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    }
    else
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
    }
    
}

@end