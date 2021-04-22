//
//  DoneViewController.m
//  TodoApp
//
//  Created by Asmaa Mohamed on 4/9/21.
//  Copyright © 2021 Asmaa Mohamed. All rights reserved.
//

#import "DoneViewController.h"

@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DoneViewController
{
    UILabel *label1;
    UILabel *label2;
    NSMutableDictionary *myDictionary;
    NSMutableArray *array;
    NSMutableArray *newArray;
    BOOL sort;
    NSMutableArray *headerTitle;
    NSMutableArray *arrHigh;
    NSMutableArray *arrMedium;
    NSMutableArray *arrLow;
    NSDictionary *nd;
}
- (void)viewWillAppear:(BOOL)animated
{

    arrMedium = [NSMutableArray new];
    arrLow = [NSMutableArray new];
    arrHigh = [NSMutableArray new];
    headerTitle = [NSMutableArray new];
    nd = [NSMutableDictionary new];
    sort = false;
    newArray = [NSMutableArray new];
    array = [[NSUserDefaults standardUserDefaults] objectForKey:@"ArrayKey"];
    for(int i = 0; i < array.count;i++)
    {
        NSString *status;
        myDictionary = [array objectAtIndex:i];
        status = [myDictionary objectForKey:@"status"];
        if([status  isEqual: @"Done"])
        {
            [newArray addObject:myDictionary];
        }
    }
    //NSLog(@"%@", newArray);
    for(int i = 0; i < newArray.count;i++)
    {
        nd = [newArray objectAtIndex:i];
        if([[nd objectForKey:@"Priority"]  isEqual: @"high"])
          {
              [arrHigh addObject:nd];
          }
        else if([[nd objectForKey:@"Priority"]  isEqual: @"low"])
          {
              [arrLow addObject:nd];

          }
        else if([[nd objectForKey:@"Priority"]  isEqual: @"medium"]){
              [arrMedium addObject:nd];

          }
        printf("---------\n");
    }
    NSLog(@"%@", arrHigh);

    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)sortBtn:(id)sender {
    sort = true;
    [self.tableView reloadData];
}

#pragma mark - Table view data source


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    
    header.backgroundColor = UIColor.grayColor;
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:header.bounds];
    [header addSubview:headerLabel];
    
    headerTitle = [NSMutableArray new];
    [headerTitle addObject:@"High Priority"];
    [headerTitle addObject:@"Medium Priority"];
    [headerTitle addObject:@"Low Priority"];
    
    NSString *title = [headerTitle objectAtIndex:section];
    [headerLabel setText:title];
    headerLabel.textColor = UIColor.purpleColor;
    if(sort)
    {
        return header;
    }
    return [UIView new];

    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections

    if(sort)
    {
        return 3;
        
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if(sort)
    {
        if(section == 0)
            return arrHigh.count;
        if(section == 1)
            return arrMedium.count;
        if(section == 2)
            return arrLow.count;
    }
    return newArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
     label1 = [cell viewWithTag:1];
     label2 = [cell viewWithTag:2];
     myDictionary = [newArray objectAtIndex:indexPath.row];
    if(sort)
    {
       if(indexPath.section == 0)
        {
            for (int i = 0; i < arrHigh.count; i++) {
             nd = [arrHigh objectAtIndex:i];
             [label1 setText:[nd objectForKey:@"Taskname"]];
             [label2 setText:[nd objectForKey:@"Priority"]];

            }
        }else if(indexPath.section == 1)
        {
        for (int i = 0; i < arrMedium.count; i++) {
            nd = [arrMedium objectAtIndex:i];
            [label1 setText:[nd objectForKey:@"Taskname"]];
            [label2 setText:[nd objectForKey:@"Priority"]];

           }
       }
        else{
         for (int i = 0; i < arrLow.count; i++) {
             nd = [arrLow objectAtIndex:i];
            [label1 setText:[nd objectForKey:@"Taskname"]];
            [label2 setText:[nd objectForKey:@"Priority"]];
             
         }
        }
        
        
    }else
    {

    [label1 setText:[myDictionary objectForKey:@"Taskname"]];
    [label2 setText:[myDictionary objectForKey:@"Priority"]];
        
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(sort)
        {
           if(indexPath.section == 0)
            {
                for (int i = 0; i < arrHigh.count; i++) {
                  [arrHigh removeObjectAtIndex:i];
                }
            }else if(indexPath.section == 1)
            {
            for (int i = 0; i < arrMedium.count; i++) {
                [arrMedium removeObjectAtIndex:i];
               }
           }
            else{
             for (int i = 0; i < arrLow.count; i++) {
                [arrLow removeObjectAtIndex:i];

             }
            }
            
            
        }else
        {
            [newArray removeObjectAtIndex:indexPath.row];

            
        }

    }
    [tableView reloadData];
    
}
@end
