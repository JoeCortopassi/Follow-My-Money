//
//  FMMInputField.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 5/19/13.
//
//

#import "FMMInputField.h"
#import <QuartzCore/QuartzCore.h>

@implementation FMMInputField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupStyle];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupStyle];
    }
    return self;
}



- (void) setupStyle
{
    self.borderStyle = UITextBorderStyleNone;
    self.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.5].CGColor;
}
@end
