//
//  AddItemViewController.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDateViewController.h"
#import "CategoryComboBoxController.h"

@interface AddItemViewController : UIViewController <ItemDateDelegate,CategoryComboBoxDelegate>
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextField *date;
    IBOutlet UITextField *amount;
    IBOutlet UITextField *item;
    IBOutlet UITextField *category;
    NSManagedObjectContext *managedObjectContext;
    ItemDateViewController *itemDateViewController;
    CategoryComboBoxController *categoryComboBoxController;
}

@property(retain) IBOutlet UILabel *titleLabel;
@property(retain) IBOutlet UITextField *date;
@property(retain) IBOutlet UITextField *amount;
@property(retain) IBOutlet UITextField *item;
@property(retain) IBOutlet UITextField *category;
@property(retain) NSManagedObjectContext *managedObjectContext;
@property(retain) ItemDateViewController *itemDateViewController;
@property(retain) CategoryComboBoxController *categoryComboBoxViewController;

-(IBAction)saveBudgetItem;
-(IBAction)hideKeyboard;
-(void)setPickersDate:(NSDate *)newDate;
-(IBAction)showCategoryComboBox;
-(void)setCategoryFromComboBox:(NSString *)string;

@end
