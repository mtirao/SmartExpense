//
//  SMSmartListDelegate.m
//  SmartExpense
//
//  Created by Marcos Tirao on 3/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMSmartListDelegate.h"
#import "Categories.h"

@implementation SMSmartListDelegate

@synthesize mainWindow;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;


-(void)awakeFromNib {
    
    [self populateCategoryEntity];
    
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
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SmartList" withExtension:@"momd"];
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
    NSURL *iCloud = [fileManager URLForUbiquityContainerIdentifier:@"E5YV4NK229.ar.com.argsoftsolutions.SmartListPro"];
    
    if (iCloud != nil) {
        
        NSString *iCloudDataDirectoryName = @"Data.nosync";
        
        NSURL *localStoreURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SmartList.sqlite"];
        
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
                                stringByAppendingPathComponent:@"SmartList.sqlite"];
        
        
        NSDictionary *options = @{NSPersistentStoreUbiquitousContentNameKey: @"iCloudStore",
                                  NSPersistentStoreUbiquitousContentURLKey: [iCloud URLByAppendingPathComponent:@"iCloudData"],
                                  NSMigratePersistentStoresAutomaticallyOption:@YES,
                                  NSInferMappingModelAutomaticallyOption:@YES};
        
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:@"CloudConfig"
                                                            URL:[NSURL fileURLWithPath:iCloudData]
                                                        options: options error:&error];
        //NSDictionary *localOptions = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
        //                               NSInferMappingModelAutomaticallyOption:@YES};
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:@"LocalConfig"
                                                            URL:localStoreURL
                                                        options:nil error:&error];
        
        if(error != nil) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        
    } else {
        
        NSDictionary *localOptions = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                                       NSInferMappingModelAutomaticallyOption:@YES};
        
        NSURL *localStoreURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SmartList.sqlite"];
        
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

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"ar.com.argsoftsolutions.SmartExpense"];
    //return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Application's Action

- (void)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}


-(IBAction)showWindow:(id)sender {
    [mainWindow makeKeyAndOrderFront:sender];
}


#pragma mark - Application's helper method

//Once persitent store is active we can populate the Category entity
-(void) populateCategoryEntity {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categories" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    NSError * error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(array.count <= 0) {
        Categories *category = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category.name = @"Beverages";
        
        Categories *category1 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category1.name = @"Breakfast";
        
        Categories *category2 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category2.name = @"Canned Food";
        
        Categories *category3 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category3.name = @"Dairy";
        
        Categories *category4 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category4.name = @"Frozen";
        
        Categories *category5 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category5.name = @"Fruit & Vegetables";
        
        Categories *category6 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category6.name = @"Household";
        
        Categories *category7 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category7.name = @"Meat";
        
        Categories *category8 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category8.name = @"Misc";
        
        Categories *category9 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category9.name = @"Pasta & Bread";
        
        Categories *category10 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category10.name = @"Personal Care";
        
        Categories *category11 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category11.name = @"Sauces & Seasoning";
        
        Categories *category12 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
        category12.name = @"Snacks";
        
        
    }
    
}


@end
