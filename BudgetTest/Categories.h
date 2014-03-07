//
//  Categories.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BudgetItems;

@interface Categories : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *items;
@end

@interface Categories (CoreDataGeneratedAccessors)

- (void)addItemsObject:(BudgetItems *)value;
- (void)removeItemsObject:(BudgetItems *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;
@end
