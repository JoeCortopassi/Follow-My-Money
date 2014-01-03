//
//  FMMButton.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 5/18/13.
//
//

#import <UIKit/UIKit.h>
#import "FXLabel.h"

@interface FMMButton : UIView
@property (nonatomic, strong) FXLabel *titleLabel;
- (void) addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
