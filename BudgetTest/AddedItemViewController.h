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

@interface AddedItemViewController : UIViewController <ItemDateDelegate,CategoryComboBoxDelegate>
{
    UILabel *labelTitle;
    UITextField *inputDate;
    UITextField *inputAmount;
    UITextField *inputItem;
    UITextField *inputCategory;
    NSManagedObjectContext *managedObjectContext;
    NSManagedObject *budgetItem;
    ItemDateViewController *itemDateViewController;
    CategoryComboBoxController *categoryComboBoxController;
}

@property(nonatomic, strong) UILabel *labelTitle;
@property(nonatomic, strong) UITextField *inputDate;
@property(nonatomic, strong) UITextField *inputAmount;
@property(nonatomic, strong) UITextField *inputItem;
@property(nonatomic, strong) UITextField *inputCategory;
@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSManagedObject *budgetItem;
@property(nonatomic, strong) ItemDateViewController *itemDateViewController;
@property(nonatomic, strong) CategoryComboBoxController *categoryComboBoxViewController;

-(id)initWithBudgetItem:(BudgetItems *)newBudgetItem;
-(void)saveBudgetItem;
-(void)hideKeyboard;
-(void)setPickersDate:(NSDate *)newDate forField:(NSString *)newFieldToSet;
-(void)showCategoryComboBox;
-(void)setCategoryFromComboBox:(NSString *)string;

@end
