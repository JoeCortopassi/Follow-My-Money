//
//  Dates.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Dates.h"

@implementation Dates

@synthesize periodStartDate, periodEndDate;

-(id)init
{
    self = [super init];
    if (self) {
        [self setPeriodStartAndEndDates];
    }
    return self;
}

-(void)setPeriodStartAndEndDates
{
    NSUserDefaults *user_defaults = [[NSUserDefaults alloc] init];
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    float interval = [user_defaults floatForKey:@"period_interval"];
    NSString *start_date = [user_defaults objectForKey:@"period_start_date"];
    
    NSDate *beginning_date = [dateFormat dateFromString:start_date];
    NSDate *ending_date = beginning_date;
    NSDate *current_date = [NSDate date];
    
    do {
        beginning_date = ending_date;
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:beginning_date];
        
        if ( interval < 0.25 ) {
            [comp setDay:[comp day] + 7];
        } else if ( interval >= 0.25 && interval < 0.5 ) {
            [comp setDay:[comp day] + 14];
        } else if ( interval >= 0.5 && interval < 0.75 ) {
            [comp setDay:[comp day] + 15];
        } else {
            [comp setMonth:[comp month] + 1];
        }
        
        ending_date = [gregorian dateFromComponents:comp];
    } while ( [current_date compare:ending_date] == NSOrderedDescending );
    
    NSLog(@"1...%@",beginning_date);
    NSLog(@"2...%@",ending_date);
    
    self.periodStartDate = beginning_date;
    self.periodEndDate = ending_date;
   
    /**
     
    //Get the start date
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    [comp setDay:1];
    self.periodStartDate = [gregorian dateFromComponents:comp];
    
    //Get dat end date
    NSCalendar *gregorian2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp2 = [gregorian2 components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.periodStartDate];
    [comp2 setMonth:[comp2 month] + 1];
    self.periodEndDate = [gregorian2 dateFromComponents:comp2];
    
     */
}



-(NSMutableArray *)datesInPeriod
{
    int daysDifference = (((( [self.periodEndDate timeIntervalSince1970] - [self.periodStartDate timeIntervalSince1970] ) / 24) / 60) / 60);
    
    NSDate *startDate = [self periodStartDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offset = [[NSDateComponents alloc] init];
    NSMutableArray* dates = [NSMutableArray arrayWithObject:startDate];
    
    for (int i = 1; i <= daysDifference; i++) {
        [offset setDay:i];
        NSDate *nextDay = [calendar dateByAddingComponents:offset toDate:startDate options:0];
        [dates addObject:nextDay];
    }
    
    return dates;
}


- (BOOL)isSameDay:(NSDate*)date1 asDay:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}


@end
