//
//  PieChartViewController.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 5/25/13.
//
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h" 

@interface PieChartViewController : UIViewController <CPTPieChartDataSource, CPTPieChartDelegate>
@property (nonatomic, strong) NSMutableArray *dataForChart;
@property (nonatomic, strong) NSMutableArray *labelsForChart;


@end
