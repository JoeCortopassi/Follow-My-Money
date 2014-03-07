//
//  CategoryComboBoxController.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMInputField.h"

@protocol CategoryComboBoxDelegate
-(void)setCategoryFromComboBox:(NSString *)string;
@end

@interface CategoryComboBoxController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSString *category_storage;
    IBOutlet FMMInputField *input;
    IBOutlet UITableView *autoSuggest;
    NSMutableArray *autoSuggestList;
    
    NSManagedObjectContext *managedObjectContext;
    id <CategoryComboBoxDelegate> delegate;
}

@property(retain) NSString *category_storage;
@property(retain) IBOutlet FMMInputField *input;
@property(retain) IBOutlet UITableView *autoSuggest;
@property(retain) NSMutableArray *autoSuggestList;

@property(retain) NSManagedObjectContext *managedObjectContext;
@property(retain) id <CategoryComboBoxDelegate> delegate;

-(IBAction)textChanged;
-(id)initWithCategory:(NSString *)newCategory;

@end
