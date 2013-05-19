//
//  AddItemViewController.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AddedItemViewController.h"
#import "FMMButton.h"
#import "BudgetItems.h"
#import "Categories.h"
#import <QuartzCore/QuartzCore.h>



@implementation UITextField(UITextFieldCatagory)
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width - 10, bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width - 10, bounds.size.height);
    return inset;
}
@end





@interface AddedItemViewController ()
@property (nonatomic, retain) FMMButton *buttonSave;
@property (nonatomic, retain) UIButton *buttonKeyboardHide;
@end





@implementation AddedItemViewController

@synthesize labelTitle,inputDate,inputItem,inputAmount,inputCategory;
@synthesize managedObjectContext, budgetItem;
@synthesize itemDateViewController,categoryComboBoxViewController;


-(void)setCategoryFromComboBox:(NSString *)string
{
    self.inputCategory.text = string;
}

-(void)setPickersDate:(NSDate *)newDate forField:(NSString *)newFieldToSet
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat: @"M/d/Y"];
    self.inputDate.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:newDate]];
}


-(void)saveBudgetItem
{
    BudgetItems *budgetItems = [NSEntityDescription insertNewObjectForEntityForName:@"BudgetItems" inManagedObjectContext:self.managedObjectContext];
    
    NSError *error = nil;
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categories"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",
                              inputCategory.text];
    [fetchRequest setPredicate:predicate];
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedObjects count] == 0) {
        Categories *categories = [NSEntityDescription insertNewObjectForEntityForName:@"Categories" inManagedObjectContext:self.managedObjectContext];
        categories.name = inputCategory.text;
        budgetItems.category = categories;
    } else {
        budgetItems.category = [fetchedObjects objectAtIndex:0];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat: @"MM/dd/yyyy"];
    
    budgetItems.date = [dateFormatter dateFromString:inputDate.text];
    budgetItems.amount = [inputAmount.text doubleValue];
    budgetItems.item = inputItem.text;
    
    if (self.budgetItem) {
        [self.managedObjectContext deleteObject:self.budgetItem];
        [self dismissModalViewControllerAnimated:YES];
    }
    
    // Commit the change.
    if (![self.managedObjectContext save:&error]) {
        // Handle the error.
    } else {
        labelTitle.text = @"Item Saved!";
        labelTitle.backgroundColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.5];
        
        [NSTimer scheduledTimerWithTimeInterval:1.3
                                         target:self
                                       selector:@selector(restoreTitleLabel)
                                       userInfo:nil
                                        repeats:NO];
    }
    
    
}


-(void)restoreTitleLabel
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat: @"M/d/Y"];
    
    self.inputDate.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    inputAmount.text = @"";
    inputItem.text = @"";
    inputCategory.text = @"";
    
    
    self.labelTitle.text = @"Add an Item";
    self.labelTitle.backgroundColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.25];
}


-(void)hideKeyboard
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
}


-(void)showDatePicker
{
    self.itemDateViewController = [[ItemDateViewController alloc] init];
    self.itemDateViewController.fieldToSet = @"Item";
    self.itemDateViewController.delegate = self;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    self.itemDateViewController.date = [dateFormat dateFromString:self.inputDate.text];
    [self presentModalViewController:self.itemDateViewController animated:YES];
}


-(void)showCategoryComboBox
{
    self.categoryComboBoxViewController = [[CategoryComboBoxController alloc] initWithCategory:self.inputCategory.text];
    self.categoryComboBoxViewController.managedObjectContext = self.managedObjectContext;
    self.categoryComboBoxViewController.delegate = self;
    [self presentModalViewController:self.categoryComboBoxViewController animated:YES];
}


- (id)initWithBudgetItem:(BudgetItems *)newBudgetItem
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.budgetItem = newBudgetItem;
    }
    return self;
}



#pragma mark - Default methods
- (id) init
{
    if (self = [super init])
    {
        //self.view.frame = [[UIScreen mainScreen] bounds];//[[UIScreen mainScreen] applicationFrame];
    }
    
    
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.1];
    
    [self setupLabelTitle];
    [self setupLabelDate];
    [self setupLabelAmount];
    [self setupLabelItem];
    [self setupLabelCategory];
    
    [self setupButtonKeyboardHide];
    
    [self setupInputDate];
    [self setupInputAmount];
    [self setupInputItem];
    [self setupInputCategory];
    
    [self setupButtonSave];
    
    
    // Do any additional setup after loading the view from its nib.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat: @"M/d/Y"];
    
    
    if ( self.budgetItem ) {
        self.inputDate.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[self.budgetItem valueForKey:@"date"]]];
        self.inputAmount.text = [NSString stringWithFormat:@"%0.2f", [[self.budgetItem valueForKey:@"amount"] doubleValue]];
        self.inputItem.text = [self.budgetItem valueForKey:@"item"];
        self.inputCategory.text = [[self.budgetItem valueForKey:@"category"] valueForKey:@"name"];
        self.labelTitle.text = @"Edit Item";
    } else {
        self.inputDate.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    }
}


- (void) setupLabelTitle
{
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.frame = CGRectMake(0, 0, 320.0, 52.0);
    self.labelTitle.backgroundColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.25];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:22.0];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.text = @"Add an Item";
    
    [self.view addSubview:self.labelTitle];
}


- (void) setupLabelDate
{
    UILabel *labelDate = [[UILabel alloc] init];
    labelDate.frame = CGRectMake(20.0, 65.0, 78.0, 21.0);
    labelDate.textAlignment = NSTextAlignmentRight;
    labelDate.text = @"Date:";
    labelDate.font = [UIFont boldSystemFontOfSize:18.0f];
    labelDate.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:labelDate];
}


- (void) setupLabelAmount
{
    UILabel *labelAmount = [[UILabel alloc] init];
    labelAmount.frame = CGRectMake(20.0, 104.0, 78.0, 21.0);
    labelAmount.textAlignment = NSTextAlignmentRight;
    labelAmount.text = @"Amount:";
    labelAmount.font = [UIFont boldSystemFontOfSize:18.0f];
    labelAmount.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:labelAmount];
}


- (void) setupLabelItem
{
    UILabel *labelItem = [[UILabel alloc] init];
    labelItem.frame = CGRectMake(20.0, 143.0, 78.0, 21.0);
    labelItem.textAlignment = NSTextAlignmentRight;
    labelItem.text = @"Item:";
    labelItem.font = [UIFont boldSystemFontOfSize:18.0f];
    labelItem.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:labelItem];
}


- (void) setupLabelCategory
{
    UILabel *labelCategory = [[UILabel alloc] init];
    labelCategory.frame = CGRectMake(20.0, 182.0, 78.0, 21.0);
    labelCategory.textAlignment = NSTextAlignmentRight;
    labelCategory.text = @"Category:";
    labelCategory.font = [UIFont boldSystemFontOfSize:16.0f];
    labelCategory.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:labelCategory];
}


- (void) setupInputDate
{
    self.inputDate = [[UITextField alloc] init];
    self.inputDate.frame = CGRectMake(106.0, 60.0, 194.0, 31.0);
    self.inputDate.borderStyle = UITextBorderStyleNone;
    self.inputDate.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    self.inputDate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.inputDate addTarget:self action:@selector(showDatePicker) forControlEvents:UIControlEventTouchDown];
    self.inputDate.layer.borderWidth = 1.0;
    self.inputDate.layer.borderColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.5].CGColor;
    
    [self.view addSubview:self.inputDate];
}


- (void) setupInputAmount
{
    self.inputAmount = [[UITextField alloc] init];
    self.inputAmount.frame = CGRectMake(106.0, 99.0, 194.0, 31.0);
    self.inputAmount.borderStyle = UITextBorderStyleNone;
    self.inputAmount.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    self.inputAmount.keyboardType = UIKeyboardTypeDecimalPad;
    self.inputAmount.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.inputAmount.layer.borderWidth = 1.0;
    self.inputAmount.layer.borderColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.5].CGColor;
    
    [self.view addSubview:self.inputAmount];
}


- (void) setupInputItem
{
    self.inputItem = [[UITextField alloc] init];
    self.inputItem.frame = CGRectMake(106.0, 138.0, 194.0, 31.0);
    self.inputItem.borderStyle = UITextBorderStyleNone;
    self.inputItem.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    self.inputItem.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.inputItem.layer.borderWidth = 1.0;
    self.inputItem.layer.borderColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.5].CGColor;
    
    [self.view addSubview:self.inputItem];
}


- (void) setupInputCategory
{
    self.inputCategory = [[UITextField alloc] init];
    self.inputCategory.frame = CGRectMake(106.0, 177.0, 194.0, 31.0);
    self.inputCategory.borderStyle = UITextBorderStyleNone;
    self.inputCategory.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    self.inputCategory.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.inputCategory addTarget:self action:@selector(showCategoryComboBox) forControlEvents:UIControlEventTouchDown];
    self.inputCategory.layer.borderWidth = 1.0;
    self.inputCategory.layer.borderColor = [UIColor colorWithRed:(1.00/255.00) green:(131.00/255.00) blue:(37.00/255.00) alpha:0.5].CGColor;
    
    [self.view addSubview:self.inputCategory];
}


- (void) setupButtonSave
{
    self.buttonSave = [[FMMButton alloc] initWithFrame:CGRectMake(106.0, 221.0, 72.0, 37.0)];
    self.buttonSave.titleLabel.text = @"Save";
    [self.buttonSave addTarget:self action:@selector(saveBudgetItem) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonSave addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.buttonSave];
}


- (void) setupButtonKeyboardHide
{
    self.buttonKeyboardHide = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonKeyboardHide.frame = self.view.frame;
    [self.buttonKeyboardHide addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.buttonKeyboardHide];
}
@end
