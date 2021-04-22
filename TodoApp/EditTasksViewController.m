//
//  EditTasksViewController.m
//  TodoApp
//
//  Created by Asmaa Mohamed on 4/9/21.
//  Copyright © 2021 Asmaa Mohamed. All rights reserved.
//

#import "EditTasksViewController.h"
#import "TodoViewController.h"
@interface EditTasksViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *descriptionName;
@property (weak, nonatomic) IBOutlet UITextField *priority;
@property (weak, nonatomic) IBOutlet UITextField *status;
@property (weak, nonatomic) IBOutlet UITextField *dateOfCreation;
@property (weak, nonatomic) IBOutlet UITextField *reminderDate;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation EditTasksViewController{
    TodoViewController *todoView;
    NSMutableDictionary *myDictionary;
    NSMutableArray *newArray;

}
- (void)viewWillAppear:(BOOL)animated{
    
    _taskName.userInteractionEnabled = false;
      _descriptionName.userInteractionEnabled = false;
      _dateOfCreation.userInteractionEnabled = false;
      _reminderDate.userInteractionEnabled = false;
      _priority.userInteractionEnabled = false;
      _status.userInteractionEnabled = false;
    _status.hidden = true;
       _statusLabel.hidden = true;
    [_taskName setText:[_global_dictonary objectForKey:@"Taskname"]];
         [_priority setText:[_global_dictonary objectForKey:@"Priority"]];
        [_descriptionName setText:[_global_dictonary objectForKey:@"Description"]];
       [_dateOfCreation setText:[_global_dictonary objectForKey:@"DateOfCreation"]];
       [_reminderDate setText:[_global_dictonary objectForKey:@"ReminderDate"]];
      [_status setText:@""];
    NSLog(@"creation date : %@", [_global_dictonary objectForKey:@"DateOfCreation"]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    myDictionary = [[NSMutableDictionary alloc] init];
     todoView= [self.storyboard instantiateViewControllerWithIdentifier:@"TodoViewController"];
    _status.hidden = true;
    _statusLabel.hidden = true;

}
- (IBAction)editBtn:(id)sender {
    _taskName.userInteractionEnabled = YES;
    [_taskName becomeFirstResponder];
    _descriptionName.userInteractionEnabled = YES;
    _dateOfCreation.userInteractionEnabled = YES;
    _reminderDate.userInteractionEnabled = YES;
    _priority.userInteractionEnabled = YES;
    _status.userInteractionEnabled = YES;
    _status.hidden = false;
    _statusLabel.hidden = false;
    
}
- (IBAction)addBtn:(id)sender {
    
    [myDictionary setObject:[_taskName text]forKey:@"Taskname"];
    [myDictionary setObject:[_descriptionName text] forKey:@"Description"];
    [myDictionary setObject:[_priority text] forKey:@"Priority"];
    [myDictionary setObject:[_reminderDate text] forKey:@"ReminderDate"];
    [myDictionary setObject:[_status text] forKey:@"status"];
    
    
    NSMutableArray *myArray = [[[NSUserDefaults standardUserDefaults]objectForKey:@"ArrayKey"] mutableCopy];
       NSLog(@"%@", myArray);
       newArray = [myArray mutableCopy];
    
    for( int i= 0; i < myArray.count;i++ )
       {
           if([_global_dictonary isEqualToDictionary:[myArray objectAtIndex:i]])
           {
               newArray[i] = myDictionary;
               myArray = [NSMutableArray arrayWithArray:newArray];
           }
       }
      [[NSUserDefaults standardUserDefaults] setObject:myArray forKey:@"ArrayKey"];
      [[NSUserDefaults standardUserDefaults]synchronize];
      NSLog(@"%@", myArray);
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
