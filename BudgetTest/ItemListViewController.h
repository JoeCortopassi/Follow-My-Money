//
//  ItemListViewController.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemListViewController : UITableViewController
{
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *itemList;
}

@property(retain)NSManagedObjectContext *managedObjectContext;
@property(retain)NSMutableArray *itemList;

@end
