//
//  CategoryTotalViewController.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryTotalViewController.h"
#import "BudgetItems.h"
#import "Dates.h"
#import "Categories.h"


@interface CategoryTotalViewController ()
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, assign) NSInteger previousOpenSectionIndex;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *categoryItems;
@property (nonatomic, strong) NSMutableArray *categoryTotals;
@property (nonatomic, strong) NSMutableArray *categoriesOpen;
@end



@implementation CategoryTotalViewController

@synthesize managedObjectContext, categories, categoryTotals;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1.00/255.00 green:131.00/255.00 blue:37.00/255.00 alpha:0.5];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupStyle];
    
    
    self.categoryTotals = [[NSMutableArray alloc] init];
    self.categoryItems = [[NSMutableArray alloc] init];
    self.categoriesOpen = [[NSMutableArray alloc] init];
    CGFloat grandTotal = 0;
    
        
    self.categories = [[NSMutableArray alloc] initWithArray:[self getCategoriesFromStore]];
    
    
    for (int i = 0; i < self.categories.count; i++)
    {
        NSArray *itemsForCategory = [self getItemsForCategory:[self.categories objectAtIndex:i]];
        CGFloat totalForCategory = [self getTotalForCategoryFromItems:itemsForCategory];
        
        [self.categoriesOpen addObject:[NSNumber numberWithBool:(i==2)?YES:NO]];
        [self.categoryItems addObject:itemsForCategory];
        [self.categoryTotals addObject:[NSNumber numberWithFloat:totalForCategory]];
        grandTotal += totalForCategory;
    }
    
    
    self.title = [NSString stringWithFormat:@"Total = $%0.2f", grandTotal];
    
    [self.tableView reloadData];
}


- (void) setupStyle
{
    self.view.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:242.0/255.0 blue:233.0/255.0 alpha:1.0];
}


- (void) loadSections
{
    
}


- (void) loadItemsForSections
{
    
}




- (NSArray *) getCategoriesFromStore
{
    Dates *dates = [[Dates alloc] init];
    NSError *error = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categories"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(ANY items.amount > 0.00) AND (ANY items.date >= %@) AND (ANY items.date < %@)", [dates periodStartDate], [dates periodEndDate]];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
    }

    return  fetchedObjects;
}


- (NSArray *) getItemsForCategory:(Categories *)category
{
    NSError *error = nil;
    Dates *dates = [[Dates alloc] init];
    NSFetchRequest *fetchRequestItem = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityItem = [NSEntityDescription entityForName:@"BudgetItems"
                                                  inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicateItem = [NSPredicate predicateWithFormat:@"(ANY category.name = %@) AND (date >= %@) AND (date < %@) AND amount > 0", [category valueForKey:@"name"], [dates periodStartDate], [dates periodEndDate]];
    
    
    [fetchRequestItem setEntity:entityItem];
    [fetchRequestItem setPredicate:predicateItem];
    
    
    NSArray *fetchedObjectItems = [self.managedObjectContext executeFetchRequest:fetchRequestItem error:&error];

    if (fetchedObjectItems == nil)
    {
        // Handle the error
    }
    
    
    return fetchedObjectItems;
}


- (CGFloat) getTotalForCategoryFromItems:(NSArray *)arrayOfItems
{
    CGFloat total = 0;
    
    for (int i=0; i<[arrayOfItems count]; i++)
    {
        total += [[[arrayOfItems objectAtIndex:i] valueForKey:@"amount"] floatValue];
    }
    
    return total;
}













/****************************
    Table view data source
 ****************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return ([[self.categoriesOpen objectAtIndex:section] boolValue])? [[self.categoryItems objectAtIndex:section] count]: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    BudgetItems *item = [[self.categoryItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"$%0.2f  -  %@", [[item valueForKey:@"amount"] floatValue], [item valueForKey:@"item"]];

    cell.textLabel.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:242.0/255.0 blue:233.0/255.0 alpha:1.0];
    cell.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:242.0/255.0 blue:233.0/255.0 alpha:1.0];
    
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CategorySectionHeaderView *headerView = [[CategorySectionHeaderView alloc] init];
    headerView.delegate = self;
    headerView.section = section;
    headerView.labelCategory.text = [NSString stringWithFormat:@"%@", [[self.categories objectAtIndex:section] valueForKey:@"name"]];
    headerView.labelTotal.text = [NSString stringWithFormat:@"$%0.2f", [[self.categoryTotals objectAtIndex:section] doubleValue]];
    
    
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}




/***************************
     Table view delegate
 ***************************/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



/**********************************
    Section Header View Delegate
 **********************************/
-(void)sectionHeaderView:(CategorySectionHeaderView *)sectionHeaderView sectionOpened:(NSInteger)sectionOpened
{
    
    /*
     Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section.
     */
    NSInteger countOfRowsToInsert = [[self.categoryItems objectAtIndex:sectionOpened] count];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++)
    {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    
    /*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    self.previousOpenSectionIndex = self.openSectionIndex;
    if (self.previousOpenSectionIndex != NSNotFound)
    {
        [self.categoriesOpen setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:self.previousOpenSectionIndex];
        NSInteger countOfRowsToDelete = [[self.categoryItems objectAtIndex:self.previousOpenSectionIndex] count];
        
        for (NSInteger i = 0; i < countOfRowsToDelete; i++)
        {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:self.previousOpenSectionIndex]];
        }
    }
    
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (self.previousOpenSectionIndex == NSNotFound || sectionOpened < self.previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    // Apply the updates.
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tableView endUpdates];
    
    self.openSectionIndex = sectionOpened;
}



 -(void)sectionHeaderView:(CategorySectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed
{
    NSInteger countOfRowsToDelete = [[self.categoryItems objectAtIndex:sectionClosed] count];

    if (countOfRowsToDelete > 0 && [[self.categoriesOpen objectAtIndex:sectionClosed] boolValue])
    {
        [self.categoriesOpen setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:sectionClosed];
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
        for (NSInteger i = 0; i<countOfRowsToDelete; i++)
        {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        
        [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
    sectionHeaderView.selected = NO;
}

@end
