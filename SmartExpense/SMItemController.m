//
//  SMItemController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 4/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMItemController.h"
#import "Items.h"
#import "List.h"

@implementation SMItemController

@synthesize appDelegate;
@synthesize dataSource;
@synthesize dataDestination;

- (IBAction)addAction:(id)sender {
    
    NSArray* source = [dataSource selectedObjects];
    
    if(source != nil)  {
        NSUInteger count = source.count;
        
        if(count > 0) {
            List* selectedList = [source objectAtIndex:0];
            NSManagedObjectContext *context = [appDelegate.delegate managedObjectContext];
            Items* item = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
        
            [selectedList addItemsObject:item];
            item.list = selectedList;
        }else {
            NSAlert *alert = [[NSAlert alloc]init];
            [alert setInformativeText:@"You should first add a shopping List"];
            [alert addButtonWithTitle:@"Ok"];
            void(^returnCode)(NSModalResponse) = ^(NSModalResponse code){};
            [alert beginSheetModalForWindow:appDelegate.listWindow completionHandler:returnCode];
        }
    }
}

- (IBAction)removeAction:sender {
    NSArray* array = [dataDestination selectedObjects];
    [dataDestination removeObjects:array];
    
    NSManagedObjectContext *context = [appDelegate.delegate managedObjectContext];
    
    for (Items* itm in array) {
        [context deleteObject:itm];
    }
}


@end
