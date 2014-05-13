//
//  SMAccountController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 4/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMAccountController.h"
#import "Banks.h"
#import "Accounts.h"

@implementation SMAccountController


@synthesize appDelegate;
@synthesize dataSource;
@synthesize dataDestination;


- (IBAction)addAction:(id)sender {
    
    NSArray* source = [dataSource selectedObjects];
    
    if(source != nil)  {
        NSUInteger count = source.count;
        
        if(count > 0) {
            Banks* selectedBank = [source objectAtIndex:0];
            NSManagedObjectContext *context = [appDelegate.delegate managedObjectContext];
            Accounts* account = [NSEntityDescription insertNewObjectForEntityForName:@"Accounts" inManagedObjectContext:context];
        
            [selectedBank addAccountsObject:account];
            account.bank = selectedBank;
        }else {
            NSAlert *alert = [[NSAlert alloc]init];
            [alert setInformativeText:@"You should first add a Bank"];
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
