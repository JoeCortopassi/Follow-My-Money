//
//  FMMButton.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 5/18/13.
//
//

#import "FMMButton.h"
#import <QuartzCore/QuartzCore.h>


@interface FMMButton ()
@property (nonatomic, strong) UIButton *button;
@end




@implementation FMMButton


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupStyle];
        [self setupLabel];
        [self setupButton];
        [self setupActions];
    }
    
    
    return self;
}


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder])
    {
        [self setupStyle];
        [self setupLabel];
        [self setupButton];
        [self setupActions];
        
    }
    
    
    return self;
}



- (void) setupActions
{
    [self.button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchDown];
    [self.button addTarget:self action:@selector(buttonReleased) forControlEvents:UIControlEventTouchUpInside];
    [self.button addTarget:self action:@selector(buttonReleased) forControlEvents:UIControlEventTouchUpOutside];
}


- (void) setupStyle
{
    self.backgroundColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.45];
    self.layer.borderColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:1.0].CGColor;
    self.layer.borderWidth = 2.0;
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
}


- (void) setupLabel
{
    self.titleLabel = [[FXLabel alloc] init];
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"";
    self.titleLabel.shadowBlur = 0.5;
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.shadowOffset = CGSizeMake(1, 1);
    
    [self addSubview:self.titleLabel];
}


- (void) setupButton
{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.button.backgroundColor = [UIColor clearColor];
    [self.button setTitle:@"" forState:UIControlStateNormal];

    
    [self addSubview:self.button];
}


- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.button addTarget:target action:action forControlEvents:controlEvents];
}


- (void) buttonPressed
{
    self.backgroundColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.85];
}


- (void) buttonReleased
{
    self.backgroundColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.45];
}


@end
