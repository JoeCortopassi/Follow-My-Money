//
//  ItemDateViewController.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemDateDelegate
-(void)setPickersDate:(NSDate *)newDate;
@end

@interface ItemDateViewController : UIViewController
{
    IBOutlet UIDatePicker *datePicker;
    NSDate *date;
    id <ItemDateDelegate> delegate;
}

@property(retain) IBOutlet UIDatePicker *datePicker;
@property(retain) NSDate *date;
@property(retain) id <ItemDateDelegate> delegate;

-(IBAction)dateSelected;

@end
