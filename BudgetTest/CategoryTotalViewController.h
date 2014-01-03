//
//  CategoryTotalViewController.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategorySectionHeaderView.h"

@interface CategoryTotalViewController : UITableViewController <SectionHeaderViewDelegate>
{
    NSManagedObjectContext *managedObjectContext;
}

@property(retain)NSManagedObjectContext *managedObjectContext;
@end
