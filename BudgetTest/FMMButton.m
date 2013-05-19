//
//  FMMButton.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 5/18/13.
//
//

#import "FMMButton.h"
#import "FXLabel.h"
#import <QuartzCore/QuartzCore.h>


@interface FMMButton ()
@property (nonatomic, strong) UIButton *button;
@end




@implementation FMMButton


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization codes
        self.backgroundColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.45];
        self.layer.borderColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:1.0].CGColor;
        self.layer.borderWidth = 2.0;
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        
        
        self.titleLabel = [[FXLabel alloc] init];
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        
        self.titleLabel.frame = self.frame;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor redColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.text = @"Foo";
        
        
        self.button.frame = self.frame;
        self.button.backgroundColor = [UIColor yellowColor];
        [self.button setTitle:@"jhg" forState:UIControlStateNormal];

        
        [self addSubview:self.titleLabel];
        [self addSubview:self.button];
    }
    
    
    return self;
}


- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.button addTarget:target action:action forControlEvents:controlEvents];
}
@end
