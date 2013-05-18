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
    
    Dates *dates = [[Dates alloc] init];
    
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
    
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
    }
    
    self.categories = [[NSMutableArray alloc] initWithArray:fetchedObjects];
    self.categoryTotals = [[NSMutableArray alloc] init];
    
    NSFetchRequest *newFetchRequest;
    NSEntityDescription *newEntity;
    NSPredicate *newPredicate;
    NSArray *newFetchedObject;
    double total = 0;
    double grandTotal = 0;
    
    for (int i = 0; i < self.categories.count; i++) {
        newFetchRequest = [[NSFetchRequest alloc] init];
        newEntity = [NSEntityDescription entityForName:@"BudgetItems"
                                inManagedObjectContext:self.managedObjectContext];
        [newFetchRequest setEntity:newEntity];
        
        newPredicate = [NSPredicate predicateWithFormat:@"(ANY category.name = %@) AND (date >= %@) AND (date < %@) AND amount > 0", [[self.categories objectAtIndex:i] valueForKey:@"name"],
                        [dates periodStartDate], [dates periodEndDate]];
        [newFetchRequest setPredicate:newPredicate];
        
        
        newFetchedObject = [self.managedObjectContext executeFetchRequest:newFetchRequest error:&error];
        if (newFetchedObject == nil) {
            // Handle the error
        }
        
        total = 0;
        
        for (int j = 0; j < [newFetchedObject count]; j++) {
            total += [[[newFetchedObject objectAtIndex:j] valueForKey:@"amount"] doubleValue];
        }
        
        [self.categoryTotals addObject:[NSNumber numberWithDouble:total]];
        grandTotal += total;
    }    
//    NSMutableDictionary *grandTotalName = [[NSMutableDictionary alloc] init];
//    [grandTotalName  setValue:@"Grand Total" forKey:@"name"];
//    [self.categories insertObject:grandTotalName atIndex:0];
    self.title = [NSString stringWithFormat:@"%@  -  $%0.2f", @"Grand Total", grandTotal];
//    [self.categoryTotals insertObject:[NSNumber numberWithDouble:grandTotal] atIndex:0];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.categoryTotals objectAtIndex:indexPath.row] valueForKey:@"amount"]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@  -  $%0.2f", [[self.categories objectAtIndex:indexPath.row] valueForKey:@"name"], [[self.categoryTotals objectAtIndex:indexPath.row] doubleValue]];

//    if (indexPath.row == 0)
//    {
//        cell.textLabel.backgroundColor = [UIColor clearColor];
//        //        cell.contentView.backgroundColor = [UIColor colorWithRed:230.00/255.00 green:239.00/255.00 blue:194.00/255.00 alpha:1.0];
//   //     cell.contentView.backgroundColor = [UIColor colorWithRed:0.00/255.00 green:225.00/255.00 blue:71.00/255.00 alpha:0.7];
//        cell.contentView.backgroundColor = [UIColor colorWithRed:1.00/255.00 green:131.00/255.00 blue:37.00/255.00 alpha:0.5];
//        
////        1	131	37
//    }
    
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
}

@end
