//
//  ItemListViewController.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dates, AddedItemViewController;

@interface ItemListViewController : UITableViewController
{
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *itemList;
    NSMutableArray *periodDates;
    NSMutableArray *itemListByDatesInPeriod;
    Dates *dates;
    AddedItemViewController *addItemViewController;
}

@property(retain)NSManagedObjectContext *managedObjectContext;
@property(retain)NSMutableArray *itemList;
@property(retain)NSMutableArray *periodDates;
@property(retain)NSMutableArray *itemListByDatesInPeriod;
@property(retain)Dates *dates;
@property(retain)AddedItemViewController *addItemViewController;

@end
