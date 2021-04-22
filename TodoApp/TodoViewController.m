//
//  TodoViewController.m
//  TodoApp
//
//  Created by Asmaa Mohamed on 4/9/21.
//  Copyright © 2021 Asmaa Mohamed. All rights reserved.
//

#import "TodoViewController.h"
#import "AddNewTaskViewController.h"
#import "EditTasksViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface TodoViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation TodoViewController
{
    AddNewTaskViewController *addTaskView;
    EditTasksViewController *editTaskView;
    UILabel *label1;
    UILabel *label2;
    NSMutableDictionary *myDictionary;
    NSMutableArray *filteredTaskName;
    BOOL isFiltered;
    NSMutableArray *tasksName;
    NSUserDefaults *defaults;//this will keep track as to whether the notification is on or off
    NSMutableArray *lastArray;

}
- (void)viewWillAppear:(BOOL)animated
{
    lastArray = [NSMutableArray new];
    tasksName = [[NSMutableArray alloc] init ];
    myDictionary = [[NSMutableDictionary alloc] init];
    _array = [[NSUserDefaults standardUserDefaults] objectForKey:@"ArrayKey"];
    NSLog(@"may array %@", _array);
    for(int i = 0; i <_array.count;i++)
    {
        myDictionary = [_array objectAtIndex:i];
        if([[myDictionary objectForKey:@"status"] isEqual:@"InProgress"]||[[myDictionary objectForKey:@"status"] isEqual:@"Done"])
        {
            //NSLog(myDictionary);
        }
        else{
            [lastArray addObject:myDictionary];
            [tasksName addObject:[myDictionary objectForKey:@"Taskname"]];

        }
    }
    NSLog(@"last array is %@", lastArray);
    printf("_______________");
    [self.tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    addTaskView.premissionHasGranted = false;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        self->addTaskView.premissionHasGranted = granted;
    }];
    
    isFiltered = false;
    self.searchBar.delegate = self;
   addTaskView= [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewTaskViewController"];
      editTaskView= [self.storyboard instantiateViewControllerWithIdentifier:@"EditTasksViewController"];
}
- (IBAction)addTaskBtn:(id)sender {
   
            [self.navigationController pushViewController:addTaskView
                                animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myDictionary = lastArray[indexPath.row];
    editTaskView.global_dictonary = myDictionary;
    [self.navigationController pushViewController:editTaskView animated:YES];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if(isFiltered)
    {
        return filteredTaskName.count;
    }
    return  [lastArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    label1 = [cell viewWithTag:1];
    label2 = [cell viewWithTag:2];
    myDictionary = [lastArray objectAtIndex:indexPath.row];
    
    if(isFiltered)
    {
        [label1 setText:filteredTaskName[indexPath.row]];
        //[label2 setText:[myDictionary objectForKey:@"Priority"]];
    }
    else
    {
        [label1 setText:[myDictionary objectForKey:@"Taskname"]];
        [label2 setText:[myDictionary objectForKey:@"Priority"]];
    }
    

    
    
    return cell;
}
//search bar methods
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        isFiltered = false;
    }
    else{
        isFiltered = true;
        filteredTaskName = [[NSMutableArray alloc] init];
        for(NSString *task in tasksName)
        {
            NSRange nameRang = [task rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRang.location != NSNotFound)
            {
                [filteredTaskName addObject:task];
            }
        }
        
    }
    [self.tableView reloadData];
    NSLog(@"%@", filteredTaskName);

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        [lastArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData] ;
       
    }
   
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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
