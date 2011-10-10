//
//  BudgetItems.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categories;

@interface BudgetItems : NSManagedObject

@property double amount;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * item;
@property (nonatomic, retain) Categories *category;

@end
