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
        List* selectedList = [source objectAtIndex:0];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        Items* item = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
        
        [selectedList addItemsObject:item];
        item.list = selectedList;
    }
}

- (IBAction)removeAction:sender {
    NSArray* array = [dataDestination selectedObjects];
    [dataDestination removeObjects:array];
}


@end
