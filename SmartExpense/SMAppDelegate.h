//
//  SMAppDelegate.h
//  SmartExpense
//
//  Created by Marcos Tirao on 3/28/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SMSmartFuelDelegate.h"
#import "SMSmartListDelegate.h"
#import "SMSmartMoneyDelegate.h"

@interface SMAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet SMSmartFuelDelegate *smartFuelDelegate;
@property (assign) IBOutlet SMSmartListDelegate *smartListDelegate;
@property (assign) IBOutlet SMSmartMoneyDelegate *smartMoneyDelegate;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;



- (IBAction)saveAction:(id)sender;


@end
