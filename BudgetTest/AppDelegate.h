//
//  AppDelegate.h
//  BudgetTest
//
//  Created by Joe Cortopassi on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddedItemViewController;
@class ItemListViewController;
@class CategoryTotalViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, strong) UITabBarController *tabBarController;
@property(nonatomic, strong) UINavigationController *itemListNavigationController;
@property(nonatomic, strong) UINavigationController *categoryTotalsNavigationController;
@property(nonatomic, strong) UINavigationController *settingsNavigationController;
@property(nonatomic, strong) AddedItemViewController *addItemViewController;
@property(nonatomic, strong) ItemListViewController *itemListViewController;
@property(nonatomic, strong) CategoryTotalViewController *categoryTotalViewController;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
