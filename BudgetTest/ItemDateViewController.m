//
//  ItemDateViewController.m
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ItemDateViewController.h"

@implementation ItemDateViewController

@synthesize datePicker;
@synthesize date;
@synthesize delegate;
@synthesize fieldToSet;

-(IBAction)dateSelected
{
    self.date = self.datePicker.date;
    [[self delegate] setPickersDate:self.datePicker.date forField:self.fieldToSet];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    self.date = [NSDate date];
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated
{
    self.datePicker.date = self.date;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:242.0/255.0 blue:233.0/255.0 alpha:1.0];
    // Do any additional setup after loading the view from its nib. 
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
