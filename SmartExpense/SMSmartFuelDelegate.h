//
//  SMSmartFuelDelegate.h
//  SmartExpense
//
//  Created by Marcos Tirao on 3/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMFuelGraphView.h"

@interface SMSmartFuelDelegate : NSObject<NSControlTextEditingDelegate>

@property (weak, nonatomic) IBOutlet NSWindow* mainWindow;
@property (weak, nonatomic) IBOutlet NSTextField* distance;
@property (weak, nonatomic) IBOutlet NSTextField* amount;
@property (weak, nonatomic) IBOutlet NSTextField* money;
@property (weak, nonatomic) IBOutlet NSArrayController* selectedModel;
@property (weak, nonatomic) IBOutlet SMFuelGraphView* graphView;


@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)saveAction:(id)sender;

- (IBAction)showWindow:(id)sender;
- (IBAction)dispersionGraph:(id)sender;
- (IBAction)modelSelection:(id)sender;

@end
