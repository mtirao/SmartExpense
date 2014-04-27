//
//  SMListController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 4/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMListController.h"
#import "List.h"
#import "Store.h"

@implementation SMListController

@synthesize appDelegate;
@synthesize dataSource;
@synthesize dataDestination;


- (IBAction)addAction:(id)sender {
    
    NSArray* source = [dataSource selectedObjects];
    
    if(source != nil)  {
        Store* selectedStore = [source objectAtIndex:0];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        List* list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:context];
        
        [selectedStore addListsObject:list];
        list.store = selectedStore;
    }
}

- (IBAction)removeAction:sender {
    NSArray* array = [dataDestination selectedObjects];
    [dataDestination removeObjects:array];
}


@end
