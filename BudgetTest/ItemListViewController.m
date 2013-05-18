//
//  ItemListViewController.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ItemListViewController.h"
#import "Dates.h"
#import "AddedItemViewController.h"

@implementation ItemListViewController

@synthesize managedObjectContext;
@synthesize itemList, periodDates, dates, itemListByDatesInPeriod;
@synthesize addItemViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1.00/255.00 green:131.00/255.00 blue:37.00/255.00 alpha:0.5];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:1.00/255.00 green:131.00/255.00 blue:37.00/255.00 alpha:0.5];

    
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
    self.view.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:242.0/255.0 blue:233.0/255.0 alpha:1.0];
    
    // Get all the 'BudgetItems'
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BudgetItems"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
    }
    
    // Store the fetched 'BudgetItems'
    self.itemList = [[NSMutableArray alloc] initWithArray:fetchedObjects];
    
    // Get our 'Dates' helper object
    self.dates = [[Dates alloc] init];
    self.periodDates = [self.dates datesInPeriod];
    
    self.itemListByDatesInPeriod = [[NSMutableArray alloc] init];
    
    
    
    
    double totalForDay = 0;
    //double previousTotal = 0;
    //NSString *titleOfZeroSection;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat: @"M/d/Y"];
    
    // Set-up each section
    for (int i = 0; i < self.periodDates.count; i++) {
        NSMutableArray *itemsForDay = [[NSMutableArray alloc] init];
        NSDictionary *dateItems = [[NSMutableDictionary alloc] init];
        //NSDictionary *dateItemsZeroResults = [[NSMutableDictionary alloc] init];
        
        
        for (int j = 0; j < self.itemList.count; j++) {
            if ( [self.dates isSameDay:[[self.itemList objectAtIndex:j] valueForKey:@"date"] asDay:[self.periodDates objectAtIndex:i]] ) {
                totalForDay += [[[self.itemList objectAtIndex:j] valueForKey:@"amount"] doubleValue];
                [itemsForDay addObject:[self.itemList objectAtIndex:j]];
            }            
        }
        
        
        if ( itemsForDay.count != 0) {
            [dateItems setValue:[NSNumber numberWithDouble:totalForDay] forKey:@"total"];
            [dateItems setValue:[self.periodDates objectAtIndex:i] forKey:@"date"];
            [dateItems setValue:itemsForDay forKey:@"items"];
            
            [self.itemListByDatesInPeriod addObject:dateItems];
        }
        
        itemsForDay = nil;
        dateItems = nil;
        totalForDay = 0;
    }
    
    self.periodDates = [NSMutableArray arrayWithArray:[[self.periodDates reverseObjectEnumerator] allObjects]];
    self.itemListByDatesInPeriod = [ NSMutableArray arrayWithArray:[[self.itemListByDatesInPeriod reverseObjectEnumerator] allObjects]];
    [self.tableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.itemListByDatesInPeriod.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat: @"M/d/Y"];
    
    NSString *sectionDate;
    
    if ([[[self.itemListByDatesInPeriod objectAtIndex:section] valueForKey:@"date"] isKindOfClass:[NSString class]]) {
        sectionDate = [[self.itemListByDatesInPeriod  objectAtIndex:section] valueForKey:@"date"];
    } else {
        sectionDate = [dateFormatter stringFromDate:[[self.itemListByDatesInPeriod  objectAtIndex:section] valueForKey:@"date"]];
    }
    
    
    return [NSString stringWithFormat:@"%@  -  $%0.2f", sectionDate, [[[self.itemListByDatesInPeriod objectAtIndex:section] valueForKey:@"total"] floatValue]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
  
    
    return [[[self.itemListByDatesInPeriod objectAtIndex:section] valueForKey:@"items"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *thisItem = [[[self.itemListByDatesInPeriod objectAtIndex:indexPath.section] valueForKey:@"items"] objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"$%0.2f  -  %@", [[thisItem valueForKey:@"amount"] floatValue], [thisItem valueForKey:@"item"]];
    
    cell.textLabel.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:242.0/255.0 blue:233.0/255.0 alpha:1.0];
    cell.contentView.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:242.0/255.0 blue:233.0/255.0 alpha:1.0];
    
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *budgetItemToDelete = [[[self.itemListByDatesInPeriod objectAtIndex:indexPath.section] valueForKey:@"items"] objectAtIndex:indexPath.row];
        
        [self.managedObjectContext deleteObject:budgetItemToDelete];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            // Handle the error.
        }
        
        // Update the array and table view.
        [[[self.itemListByDatesInPeriod objectAtIndex:indexPath.section] valueForKey:@"items"] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    self.addItemViewController = [[AddedItemViewController alloc] initWithBudgetItem:[[[self.itemListByDatesInPeriod objectAtIndex:indexPath.section] valueForKey:@"items"] objectAtIndex:indexPath.row]];
    self.addItemViewController.managedObjectContext = self.managedObjectContext;
    [self presentModalViewController:self.addItemViewController animated:YES];
}

@end
