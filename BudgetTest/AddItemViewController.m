//
//  AddItemViewController.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AddItemViewController.h"
#import "BudgetItems.h"
#import "Categories.h"

@implementation AddItemViewController

@synthesize titleLabel,date,item,amount,category;
@synthesize managedObjectContext, budgetItem;
@synthesize itemDateViewController,categoryComboBoxViewController;


-(void)setCategoryFromComboBox:(NSString *)string
{
    self.category.text = string;
}

-(void)setPickersDate:(NSDate *)newDate forField:(NSString *)newFieldToSet
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat: @"M/d/Y"];
    self.date.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:newDate]];
}


-(IBAction)saveBudgetItem
{
    BudgetItems *budgetItems = [NSEntityDescription insertNewObjectForEntityForName:@"BudgetItems" inManagedObjectContext:self.managedObjectContext];

    NSError *error = nil;
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categories"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",
                              category.text];
    [fetchRequest setPredicate:predicate];
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedObjects count] == 0) {
        Categories *categories = [NSEntityDescription insertNewObjectForEntityForName:@"Categories" inManagedObjectContext:self.managedObjectContext];
        categories.name = category.text;
        budgetItems.category = categories;
    } else {
        budgetItems.category = [fetchedObjects objectAtIndex:0];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat: @"MM/dd/yyyy"];
    
    budgetItems.date = [dateFormatter dateFromString:date.text];
    budgetItems.amount = [amount.text doubleValue];
    budgetItems.item = item.text;
        
    if (self.budgetItem) {
        [self.managedObjectContext deleteObject:self.budgetItem];
        [self dismissModalViewControllerAnimated:YES];
    }
    
    // Commit the change.
    if (![self.managedObjectContext save:&error]) {
        // Handle the error.
    } else {
        titleLabel.text = @"Item Saved!";
        titleLabel.backgroundColor = [UIColor colorWithRed:230.00/255.00 green:239.00/255.00 blue:194.00/255.00 alpha:1.0];
        
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
    
    self.date.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    amount.text = @"";
    item.text = @"";
    category.text = @"";  
    
    date.backgroundColor = nil;
    amount.backgroundColor = nil;
    item.backgroundColor = nil;
    category.backgroundColor = nil;
    
    
    
    self.titleLabel.text = @"Add an Item";
    self.titleLabel.backgroundColor = nil;
}


-(IBAction)hideKeyboard
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
}


-(IBAction)showDatePicker
{
    self.itemDateViewController = [[ItemDateViewController alloc] init];
    self.itemDateViewController.fieldToSet = @"Item";
    self.itemDateViewController.delegate = self;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];

    self.itemDateViewController.date = [dateFormat dateFromString:self.date.text];
        [self presentModalViewController:self.itemDateViewController animated:YES];
}


-(IBAction)showCategoryComboBox
{
    self.categoryComboBoxViewController = [[CategoryComboBoxController alloc] initWithCategory:self.category.text];
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat: @"M/d/Y"];
    
    
    if ( self.budgetItem ) {
        self.date.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[self.budgetItem valueForKey:@"date"]]];
        self.amount.text = [NSString stringWithFormat:@"%0.2f", [[self.budgetItem valueForKey:@"amount"] doubleValue]];
        self.item.text = [self.budgetItem valueForKey:@"item"];
        self.category.text = [[self.budgetItem valueForKey:@"category"] valueForKey:@"name"];
        self.titleLabel.text = @"Edit Item";
    } else {
        self.date.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
