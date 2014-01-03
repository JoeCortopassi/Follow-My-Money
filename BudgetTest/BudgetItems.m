//
//  BudgetItems.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BudgetItems.h"
#import "Categories.h"


@implementation BudgetItems

//@dynamic amount;
@dynamic date;
@dynamic item;
@dynamic category;

- (double)amount
{
    NSNumber *tmpValue = [self primitiveValueForKey:@"amount"];
    [self didAccessValueForKey:@"amount"];
    return (tmpValue!=nil) ? [tmpValue doubleValue] : 0.0; // Or a suitable representation for nil.
}

- (void)setAmount:(double)amount
{
    NSNumber* temp = [[NSNumber alloc] initWithDouble:amount];
    [self willChangeValueForKey:@"length"];
    [self setPrimitiveValue:temp forKey:@"amount"];
    [self didChangeValueForKey:@"amount"];
}

@end
