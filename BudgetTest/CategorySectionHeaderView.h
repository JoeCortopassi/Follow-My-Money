//
//  CategorySectionHeaderView.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 5/19/13.
//
//

#import <UIKit/UIKit.h>



@protocol SectionHeaderViewDelegate;



@interface CategorySectionHeaderView : UIView
@property (nonatomic, assign) int section;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, weak) id <SectionHeaderViewDelegate> delegate;
@property (nonatomic, strong) UILabel *labelCategory;
@property (nonatomic, strong) UILabel *labelTotal;
@end



@protocol SectionHeaderViewDelegate <NSObject>
@optional
-(void)sectionHeaderView:(CategorySectionHeaderView *)sectionHeaderView sectionOpened:(NSInteger)section;
-(void)sectionHeaderView:(CategorySectionHeaderView *)sectionHeaderView sectionClosed:(NSInteger)section;
@end