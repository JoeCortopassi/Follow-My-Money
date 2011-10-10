//
//  Dates.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dates : NSObject
{
    NSDate *periodStartDate;
    NSDate *periodEndDate;
}

@property(retain) NSDate *periodStartDate;
@property(retain) NSDate *periodEndDate;

-(void)setPeriodStartAndEndDates;
-(NSMutableArray *)datesInPeriod;
-(BOOL)isSameDay:(NSDate*)date1 asDay:(NSDate*)date2;

@end
