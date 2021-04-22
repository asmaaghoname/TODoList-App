//
//  InProgressTableViewController.m
//  TodoApp
//
//  Created by fayza on 4/4/21.
//  Copyright © 2021 fayza. All rights reserved.
//

#import "InProgressTableViewController.h"

@interface InProgressTableViewController ()

@end

@implementation InProgressTableViewController{
    UILabel *label1;
    UILabel *label2;
    NSMutableDictionary *myDictionary;
    NSMutableArray *array;
    NSMutableArray *newArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    newArray = [NSMutableArray new];
    array = [[NSUserDefaults standardUserDefaults] objectForKey:@"ArrayKey"];
    for(int i = 0; i < array.count;i++)
    {
        NSString *status;
        myDictionary = [array objectAtIndex:i];
        status = [myDictionary objectForKey:@"status"];
        if([status  isEqual: @"InProgress"])
        {
            [newArray addObject:myDictionary];
        }
    }
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return newArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    label1 = [cell viewWithTag:0];
     label2 = [cell viewWithTag:1];
     myDictionary = [newArray objectAtIndex:indexPath.row];
     [label1 setText:[myDictionary objectForKey:@"Taskname"]];
     [label2 setText:[myDictionary objectForKey:@"Priority"]];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
