//
//  CategoryTotalViewController.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTotalViewController : UITableViewController
{
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *categories;
    NSMutableArray *categoryTotals;

}

@property(retain)NSManagedObjectContext *managedObjectContext;
@property(retain)NSMutableArray *categories;
@property(retain)NSMutableArray *categoryTotals;
@end
