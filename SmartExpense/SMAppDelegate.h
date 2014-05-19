//
//  SMAppDelegate.h
//  SmartExpense
//
//  Created by Marcos Tirao on 3/28/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SMAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource>

@property (weak, nonatomic) IBOutlet NSDatePicker * datePicker;
@property (weak, nonatomic) IBOutlet NSTableView * infoTable;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property NSArray* dataByDate;

- (IBAction)saveAction:(id)sender;
- (IBAction)datePicker:(id)sender;

@end
