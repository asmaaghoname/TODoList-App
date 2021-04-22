//
//  AddNewTaskViewController.m
//  TodoApp
//
//  Created by Asmaa Mohamed on 4/9/21.
//  Copyright © 2021 Asmaa Mohamed. All rights reserved.
//

#import "AddNewTaskViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface AddNewTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *descriptionName;
@property (weak, nonatomic) IBOutlet UITextField *priority;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddNewTaskViewController
{
     NSMutableDictionary *myDictionary;
     NSUserDefaults *userD;
    NSMutableArray *myArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [_taskName setText:@""];
    [_descriptionName setText:@""];
    [_priority setText:@""];
    myArray = [[NSMutableArray new]mutableCopy];
    myArray =  [[[NSUserDefaults standardUserDefaults]objectForKey:@"ArrayKey"] mutableCopy];
     myDictionary = [[NSMutableDictionary alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)addTaskBtn:(id)sender {
    
    NSDate *choice = [_datePicker date];
    NSString *dateInWords = [[NSString alloc] initWithFormat:@"%@",choice];
    NSLog(@"%@", dateInWords);

    
       NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
       [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
       // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
       NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
       NSString *creationDate =[dateFormatter stringFromDate:[NSDate date]];
       [myDictionary setObject:[_taskName text]  forKey:@"Taskname"];
       [myDictionary setObject:[_descriptionName text] forKey:@"Description"];
       [myDictionary setObject:[_priority text] forKey:@"Priority"];
       [myDictionary setObject:dateInWords forKey:@"ReminderDate"];
       [myDictionary setObject:creationDate forKey:@"DateOfCreation"];
       NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
       NSLog(@"in add%@", myDictionary);
    
    
    
    [myArray addObject:myDictionary];
    [[NSUserDefaults standardUserDefaults] setObject:myArray forKey:@"ArrayKey"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"in add%@", myArray);
    [self.navigationController popViewControllerAnimated:YES];
    
     if(_premissionHasGranted)
     {
         UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
         UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
         content.title = @"Task Remainder";
         content.subtitle = [_descriptionName text];
         content.body = [_taskName text];
         content.sound = [UNNotificationSound defaultSound];
    
         
         NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitYear+NSCalendarUnitMonth+NSCalendarUnitDay+NSCalendarUnitHour+NSCalendarUnitMinute+NSCalendarUnitSecond fromDate:choice];
         
         UNCalendarNotificationTrigger *cal_trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:component repeats:NO];
         
         UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"localNotification" content:content trigger:cal_trigger];
          
         [center addNotificationRequest:request withCompletionHandler:nil];
         
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

@end
