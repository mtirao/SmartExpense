//
//  SMAppDelegate.m
//  SmartExpense
//
//  Created by Marcos Tirao on 3/28/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMAppDelegate.h"
#import "Expenses.h"
#import "List.h"
#import "Store.h"
#import "SMCurrencyValueTransformer.h"

@implementation SMAppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize dataByDate;
@synthesize currentAccount;

@synthesize mainWindow;

-(void)awakeFromNib {
    mainWindow.backgroundColor = [NSColor whiteColor];
    
    [mainWindow setAcceptsMouseMovedEvents:YES];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}


// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "ar.com.argsoftsolutions.SmartExpense" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"ar.com.argsoftsolutions.SmartExpense"];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        NSManagedObjectContext* moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [moc performBlockAndWait:^{
            [moc setPersistentStoreCoordinator: coordinator];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mergeChangesFrom_iCloud:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:coordinator];
        }];
        _managedObjectContext = moc;
    }
    
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SmartExpense" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    
    NSError *error = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *iCloud = [fileManager URLForUbiquityContainerIdentifier:nil];
    
    NSURL *localStoreURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SmartExpense.sqlite"];
    
    if([fileManager fileExistsAtPath:[localStoreURL path]] == NO) {
        
        NSError *fileSystemError;
        [fileManager createDirectoryAtURL:[self applicationDocumentsDirectory]
              withIntermediateDirectories:YES
                               attributes:nil
                                    error:&fileSystemError];
        if(fileSystemError != nil) {
            NSLog(@"Error creating database directory %@", fileSystemError);
        }
    }
    
    if (iCloud != nil) {
        
        NSString *iCloudDataDirectoryName = @"Data.nosync";
        
        
        if([fileManager fileExistsAtPath:[[iCloud path] stringByAppendingPathComponent:iCloudDataDirectoryName]] == NO) {
            NSError *fileSystemError;
            [fileManager createDirectoryAtPath:[[iCloud path] stringByAppendingPathComponent:iCloudDataDirectoryName]
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:&fileSystemError];
            if(fileSystemError != nil) {
                NSLog(@"Error creating database directory %@", fileSystemError);
            }
        }
        
        NSString *iCloudData = [[[iCloud path]
                                 stringByAppendingPathComponent:iCloudDataDirectoryName]
                                stringByAppendingPathComponent:@"SmartExpense.sqlite"];
        
        
        NSDictionary *options = @{NSPersistentStoreUbiquitousContentNameKey: @"iCloudStore",
                                  NSPersistentStoreUbiquitousContentURLKey: [iCloud URLByAppendingPathComponent:@"iCloudData"],
                                  NSMigratePersistentStoresAutomaticallyOption:@YES,
                                  NSInferMappingModelAutomaticallyOption:@YES};
        
        NSDictionary *localOptions = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                                  NSInferMappingModelAutomaticallyOption:@YES};

        
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:@"CloudConfig"
                                                            URL:[NSURL fileURLWithPath:iCloudData]
                                                        options: options error:&error];
                
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:@"LocalConfig"
                                                            URL:localStoreURL
                                                        options:localOptions error:&error];
        
        if(error != nil) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        
    } else {
        
        NSDictionary *localOptions = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                                       NSInferMappingModelAutomaticallyOption:@YES};
        
        
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:localStoreURL
                                                        options:localOptions error:&error];
        if(error != nil) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SomethingChanged" object:self userInfo:nil];
    });
    
    // });
    
    
    return _persistentStoreCoordinator;
}

- (void)mergeChangesFrom_iCloud:(NSNotification *)notification {
    
	NSLog(@"Merging in changes from iCloud...");
    
    NSManagedObjectContext* moc = [self managedObjectContext];
    
    [moc performBlock:^{
        
        [moc mergeChangesFromContextDidSaveNotification:notification];
        
        NSNotification* refreshNotification = [NSNotification notificationWithName:@"SomethingChanged"
                                                                            object:self
                                                                          userInfo:[notification userInfo]];
        
        [[NSNotificationCenter defaultCenter] postNotification:refreshNotification];
    }];
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"ar.com.argsoftsolutions.SmartExpense"];
    //return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (!_managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {

        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertFirstButtonReturn) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

#pragma mark ***** Table View DataSoruce Protocol Methods *****

- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    // check if it is a textfield cell
    if ([aCell isKindOfClass:[NSTextFieldCell class]])
    {
        NSTextFieldCell* tCell = (NSTextFieldCell*)aCell;
        // check if it is selected
        if ([[aTableView selectedRowIndexes] containsIndex:rowIndex])
        {
            tCell.textColor = [NSColor whiteColor];
        }
        else
        {
            tCell.textColor = [NSColor blackColor];
        }
    }
}

#pragma mark ***** Application Action Method *****

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
//Also performs the save action for the others application.
- (IBAction)saveAction:(id)sender
{
    
    NSString *question = @"";
    NSString *info = @"The information is saved automatically every time you quit the application, so this action is not necessary to do. However, you can choose save whenever you want.";
    NSString *okButton = @"Continue Saving";
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:question];
    [alert setInformativeText:info];
    [alert addButtonWithTitle:okButton];
    
    [alert runModal];
    
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
    
}

#pragma mark ***** Window Delegate Protocol Methods *****

- (void)windowDidBecomeKey:(NSNotification *)notification {
    [mainWindow.contentView setNeedsDisplay:YES];
}


#pragma mark ***** Aux Methods *****

-(NSArray*) expensesByDate:(NSDate*)date {
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [currentCalendar components: ( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setHour:0];
    [comp setMinute:0];
    NSDate* from = [currentCalendar dateFromComponents:comp];
    
    [comp setHour:23];
    [comp setMinute:59];
    NSDate* to = [currentCalendar dateFromComponents:comp];
    
    NSDateFormatter *f = [[NSDateFormatter alloc]init];
    [f setDateStyle:NSDateFormatterFullStyle];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(due >= %@) AND (due <= %@)", from, to];
    
    [fetchRequest setPredicate:predicate];
    
    NSError* error;
    NSArray* d = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(d == nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return d;
}

-(NSArray*) listsByDate:(NSDate*)date {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"List" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [currentCalendar components:(kCFCalendarUnitWeekday | kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute) fromDate:date];
   
    [comp setHour:0];
    [comp setMinute:0];
    NSDate* from = [currentCalendar dateFromComponents:comp];
    
    [comp setHour:23];
    [comp setMinute:59];
    NSDate* to = [currentCalendar dateFromComponents:comp];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(purchased >= %@) AND (purchased <= %@)", from, to ];
    [fetchRequest setPredicate:predicate];
    
    NSError* error;
    NSArray* d = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(d == nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return d;
}

@end
