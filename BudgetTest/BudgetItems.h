//
//  BudgetItems.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BudgetItems : NSManagedObject

@property (nonatomic, retain) NSString * amount;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * item;
@property (nonatomic, retain) NSManagedObject *category;

@end
