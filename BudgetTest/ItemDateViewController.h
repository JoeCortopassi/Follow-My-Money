//
//  ItemDateViewController.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMButton.h"

@protocol ItemDateDelegate
-(void)setPickersDate:(NSDate *)newDate forField:(NSString *)fieldToSet;
@end

@interface ItemDateViewController : UIViewController
{
    IBOutlet UIDatePicker *datePicker;
    NSDate *date;
    id <ItemDateDelegate> delegate;
    NSString *fieldToSet;
}

@property(retain) IBOutlet UIDatePicker *datePicker;
@property(retain) NSDate *date;
@property(retain) id <ItemDateDelegate> delegate;
@property(retain) NSString *fieldToSet;
@property (nonatomic, strong) FMMButton *buttonSet;

-(IBAction)dateSelected;

@end
