//
//  SettingsViewController.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ItemDateViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class ItemDateViewController;

@interface SettingsViewController : UIViewController <UIScrollViewDelegate, ItemDateDelegate, MFMailComposeViewControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSUserDefaults *userDefaults;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *period_start_date;
    IBOutlet UILabel *period_interval_label;
    IBOutlet UISlider *period_interval;
    IBOutlet UITextField *backup_from_date;
    IBOutlet UITextField *backup_to_date;
    IBOutlet UITextField *backup_email;
    ItemDateViewController *periodStartDatePicker;
    ItemDateViewController *backupFromDatePicker;
    ItemDateViewController *backupToDatePicker;
}

@property(retain) NSManagedObjectContext *managedObjectContext;
@property(retain) NSUserDefaults *userDefaults;
@property(retain) IBOutlet UIScrollView *scrollView;
@property(retain) IBOutlet UITextField *period_start_date;
@property(retain) IBOutlet UILabel *period_interval_label;
@property(retain) IBOutlet UISlider *period_interval;
@property(retain) IBOutlet UITextField *backup_from_date;
@property(retain) IBOutlet UITextField *backup_to_date;
@property(retain) IBOutlet UITextField *backup_email;
@property(retain) ItemDateViewController *periodStartDatePicker;
@property(retain) ItemDateViewController *backupFromDatePicker;
@property(retain) ItemDateViewController *backupToDatePicker;


-(IBAction)pickPeriodStartDate;
-(IBAction)setPeriodDefaults;
-(IBAction)pickBackupFromDate;
-(IBAction)pickBackupToDate;
-(IBAction)sendBackupEmail;
-(IBAction)periodIntervalSlider;

@end
