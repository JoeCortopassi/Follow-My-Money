//
//  PieChartViewController.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 5/25/13.
//
//
#import "PieChartViewController.h"





@interface PieChartViewController ()
@property (nonatomic, strong) CPTXYGraph *pieChart;
@property (nonatomic, strong) CPTGraphHostingView *hostingView;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, strong) UILabel *labelCategoryTotal;
@end




@implementation PieChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationController.navigationBarHidden = NO;
        self.selectedIndex = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupPieChart];
    [self setupLabelCategoryTotal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setupLabelCategoryTotal
{
    int index = 0;
    
    self.labelCategoryTotal = [[UILabel alloc] init];
    self.labelCategoryTotal.frame = CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, 50.0);
    self.labelCategoryTotal.backgroundColor = [UIColor clearColor];
    self.labelCategoryTotal.font = [UIFont boldSystemFontOfSize:24.0f];
    self.labelCategoryTotal.textAlignment = NSTextAlignmentCenter;
    self.labelCategoryTotal.textColor = [UIColor blackColor];
    self.labelCategoryTotal.shadowOffset = CGSizeMake(1, 1);
    self.labelCategoryTotal.shadowColor = [UIColor whiteColor];
    self.labelCategoryTotal.text = [NSString stringWithFormat:@"%@ - $%0.2f", [self.labelsForChart objectAtIndex:index], [[self.dataForChart objectAtIndex:index] floatValue]];
    
    [self.view addSubview:self.labelCategoryTotal];
}


- (void) setupPieChart
{
    
    
    // Create pieChart from theme
    self.pieChart = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    //CPTTheme *theme = [CPTTheme themeNamed:kCPTSlateTheme];//[CPTTheme themeNamed:kCPTDarkGradientTheme];
    //  [pieChart applyTheme:theme];
    self.hostingView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.hostingView.backgroundColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.1];
    self.hostingView.hostedGraph = self.pieChart;
    
    self.pieChart.paddingLeft   = 20.0;
    self.pieChart.paddingTop    = 20.0;
    self.pieChart.paddingRight  = 20.0;
    self.pieChart.paddingBottom = 20.0;
    self.pieChart.axisSet = nil;
    
    CPTMutableTextStyle *whiteText = [CPTTextStyle textStyle];
    whiteText.color = [CPTColor whiteColor];
//    
//    self.pieChart.titleTextStyle = whiteText;
//    self.pieChart.title          = @"Graph Title";
    
    // Add pie chart
    CPTPieChart *piePlot = [[CPTPieChart alloc] init];
    piePlot.dataSource      = self;
    piePlot.pieRadius       = 115.0;
    piePlot.identifier      = @"Pie Chart 1";
    piePlot.startAngle      = M_PI_4;
    piePlot.sliceDirection  = CPTPieDirectionClockwise;
    piePlot.centerAnchor    = CGPointMake(0.5, 0.55);//CGPointMake(0.5, 0.38);
    piePlot.borderLineStyle = [CPTLineStyle lineStyle];
    piePlot.labelRotationRelativeToRadius = YES;
    piePlot.labelOffset = 900;
    piePlot.labelTextStyle = whiteText;
    piePlot.labelShadow = [CPTMutableShadow shadow];
    piePlot.delegate        = self;
    [self.pieChart addPlot:piePlot];
    
    
//    CPTLegend *theLegend = [CPTLegend legendWithGraph:self.pieChart];
//    // 3 - Configure legend
//    theLegend.numberOfColumns = 2;
//    theLegend.fill = [CPTFill fillWithColor:[CPTColor whiteColor]];
//    theLegend.borderLineStyle = [CPTLineStyle lineStyle];
//    theLegend.cornerRadius = 0;//5.0;
//    // 4 - Add legend to graph
//    self.pieChart.legend = theLegend;
//    self.pieChart.legendAnchor = CPTRectAnchorTopLeft;
//
//    self.pieChart.legendDisplacement = CGPointMake(0, 1);
    
    
    
    [self.view addSubview:self.hostingView];
}





#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self.dataForChart count];
}


-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if ( index >= [self.dataForChart count] )
    {
        return nil;
    }
    
    
    if ( fieldEnum == CPTPieChartFieldSliceWidth )
    {
        return [self.dataForChart objectAtIndex:index];
    }
    else
    {
        return [NSNumber numberWithInt:index];
    }
}


-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    CPTTextLayer *label            = [[CPTTextLayer alloc] initWithText:[self.labelsForChart objectAtIndex:index]];
    CPTMutableTextStyle *textStyle = [label.textStyle mutableCopy];
    
    textStyle.color = [CPTColor lightGrayColor];
    label.textStyle = textStyle;
    return label;
}

-(CGFloat)radialOffsetForPieChart:(CPTPieChart *)piePlot recordIndex:(NSUInteger)index
{
    CGFloat offset = 0.0;
    
    if ( index == self.selectedIndex )
    {
        offset = piePlot.pieRadius / 8.0;
    }
    
    return offset;
}

/*-(CPTFill *)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index;
 * {
 *  return nil;
 * }*/

#pragma mark -
#pragma mark Delegate Methods

-(void)pieChart:(CPTPieChart *)plot sliceWasSelectedAtRecordIndex:(NSUInteger)index
{
    self.labelCategoryTotal.text = [NSString stringWithFormat:@"%@ - $%0.2f", [self.labelsForChart objectAtIndex:index], [[self.dataForChart objectAtIndex:index] floatValue]];
    self.selectedIndex = index;
    [self.pieChart reloadData];
    self.pieChart.legend.frame = CGRectMake(0, 0, 200, 200);
}

-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    CPTPieChart *piePlot             = (CPTPieChart *)[self.pieChart plotWithIdentifier:@"Pie Chart 1"];
    CABasicAnimation *basicAnimation = (CABasicAnimation *)theAnimation;
    
    [piePlot removeAnimationForKey:basicAnimation.keyPath];
    [piePlot setValue:basicAnimation.toValue forKey:basicAnimation.keyPath];
    [piePlot repositionAllLabelAnnotations];
}


-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index
{
    return [self.labelsForChart objectAtIndex:index];
}



@end
