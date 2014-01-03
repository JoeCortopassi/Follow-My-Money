//
//  CategorySectionHeaderView.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 5/19/13.
//
//

#import "CategorySectionHeaderView.h"
#import <QuartzCore/QuartzCore.h>


@interface CategorySectionHeaderView ()

@end





@implementation CategorySectionHeaderView


- (id) init
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50.0);
        self.selected = NO;
        [self setupStyle];
        [self setupLabelCategory];
        [self setupLabelTotal];
        [self setupActions];
    }
    
    
    return self;
}


- (void) setupStyle
{
    self.backgroundColor = [UIColor colorWithRed:133.00/255.00 green:194.00/255.00 blue:160.00/255.00 alpha:1.0];
    self.layer.borderColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.65].CGColor;
    self.layer.borderWidth = 1;
}


- (void) setupLabelCategory
{
    self.labelCategory = [[UILabel alloc] init];
    self.labelCategory.frame = CGRectMake(10, 0, (self.frame.size.width*0.66)-10, 50.0);
    self.labelCategory.font = [UIFont boldSystemFontOfSize:22];
    self.labelCategory.textColor = [UIColor whiteColor];
    self.labelCategory.shadowColor = [UIColor darkGrayColor];
    self.labelCategory.shadowOffset = CGSizeMake(1, 1);
    self.labelCategory.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.labelCategory];
}


- (void) setupLabelTotal
{
    self.labelTotal = [[UILabel alloc] init];
    self.labelTotal.frame = CGRectMake(self.frame.size.width*0.67, 0, (self.frame.size.width*0.33)-10, 50.0);
    self.labelTotal.font = [UIFont systemFontOfSize:22];
    self.labelTotal.textColor = [UIColor whiteColor];
    self.labelTotal.shadowColor = [UIColor darkGrayColor];
    self.labelTotal.shadowOffset = CGSizeMake(1, 1);
    self.labelTotal.backgroundColor = [UIColor clearColor];
    self.labelTotal.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:self.labelTotal];
}


- (void) setupActions
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
    [self addGestureRecognizer:tapGesture];
    
}


- (void) setSection:(int)newSection
{
    _section = newSection;
    self.labelCategory.text = [NSString stringWithFormat:@"%i", newSection];
}

-(void)toggleOpen:(id)sender
{
    [self toggleOpenWithUserAction:YES];
}

-(void)toggleOpenWithUserAction:(BOOL)userAction
{
    self.selected = !self.selected;
    
    if (userAction)
    {
        if (self.selected)
        {
            if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)])
            {
                [self.delegate sectionHeaderView:self sectionOpened:self.section];
            }
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)])
            {
                [self.delegate sectionHeaderView:self sectionClosed:self.section];
            }
        }
    }
}




@end
