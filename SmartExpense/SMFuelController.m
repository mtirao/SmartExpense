//
//  SMFuelController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 4/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMFuelController.h"
#import "Fuel.h"
#import "Model.h"

@implementation SMFuelController

@synthesize appDelegate;
@synthesize dataSource;
@synthesize dataDestination;


- (IBAction)addAction:(id)sender {
    
    NSArray* source = [dataSource selectedObjects];
    
    if(source != nil)  {
        NSUInteger count = source.count;
        if (count > 0) {
            Model* selectedModel = [source objectAtIndex:0];
            NSManagedObjectContext *context = [appDelegate managedObjectContext];
            Fuel* fuel = [NSEntityDescription insertNewObjectForEntityForName:@"Fuel" inManagedObjectContext:context];
        
            [selectedModel addFuelObject:fuel];
            fuel.model = selectedModel;
        }else {
            NSAlert *alert = [[NSAlert alloc]init];
            [alert setInformativeText:@"You should first add a Car Model"];
            [alert addButtonWithTitle:@"Ok"];
            void(^returnCode)(NSModalResponse) = ^(NSModalResponse code){};
            [alert beginSheetModalForWindow:appDelegate.mainWindow completionHandler:returnCode];
        }
    }
}

- (IBAction)removeAction:sender {
    NSArray* array = [dataDestination selectedObjects];
    [dataDestination removeObjects:array];
}


@end
