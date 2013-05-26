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

@class BudgetItems;

@interface AddItemViewController : UIViewController <ItemDateDelegate,CategoryComboBoxDelegate>
{
    UILabel *titleLabel;
    UITextField *inputDate;
    UITextField *inputAmount;
    UITextField *inputItem;
    UITextField *inputCategory;
    NSManagedObjectContext *managedObjectContext;
    NSManagedObject *budgetItem;
    ItemDateViewController *itemDateViewController;
    CategoryComboBoxController *categoryComboBoxController;
}

@property(retain) UILabel *titleLabel;
@property(retain) UILabel *labelDate;
@property(retain) UILabel *labelAmount;
@property(retain) UILabel *labelItem;
@property(retain) UILabel *labelCategory;
@property(retain) UITextField *inputDate;
@property(retain) UITextField *inputAmount;
@property(retain) UITextField *inputItem;
@property(retain) UITextField *inputCategory;
@property(retain) NSManagedObjectContext *managedObjectContext;
@property(retain) NSManagedObject *budgetItem;
@property(retain) ItemDateViewController *itemDateViewController;
@property(retain) CategoryComboBoxController *categoryComboBoxViewController;

-(id)initWithBudgetItem:(BudgetItems *)newBudgetItem;
-(void)saveBudgetItem;
-(void)hideKeyboard;
-(void)setPickersDate:(NSDate *)newDate forField:(NSString *)newFieldToSet;
-(void)showCategoryComboBox;
-(void)setCategoryFromComboBox:(NSString *)string;

@end
