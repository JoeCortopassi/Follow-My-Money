//
//  AppDelegate.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddItemViewController;
@class ItemListViewController;
@class CategoryTotalViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(retain) UITabBarController *tabBarController;
@property(retain) UINavigationController *itemListNavigationController;
@property(retain) UINavigationController *categoryTotalsNavigationController;
@property(retain) AddItemViewController *addItemViewController;
@property(retain) ItemListViewController *itemListViewController;
@property(retain) CategoryTotalViewController *categoryTotalViewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
