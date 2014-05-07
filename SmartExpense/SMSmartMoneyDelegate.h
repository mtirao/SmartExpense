//
//  SMSmartMoneyDelegate.h
//  SmartExpense
//
//  Created by Marcos Tirao on 3/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMSmartMoneyDelegate : NSObject

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet NSWindow* mainWindow;
@property (weak, nonatomic) IBOutlet NSPanel* listPanel;
@property (weak, nonatomic) IBOutlet NSPanel* fuelPanel;
@property (weak, nonatomic) IBOutlet NSPopUpButton* expenseType;
@property (assign) IBOutlet NSArrayController *listEntity;
@property (assign) IBOutlet NSArrayController *modelEntity;
@property (assign) IBOutlet NSArrayController *selectedExpense;



- (void)saveAction:(id)sender;
- (IBAction)showWindow:(id)sender;
- (IBAction)showListInfo:(id)sender;
- (IBAction)okListInfo:(id)sender;
- (IBAction)cancelListInfo:(id)sender;

@end
