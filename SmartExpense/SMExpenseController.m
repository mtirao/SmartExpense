//
//  SMExpenseController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/1/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMExpenseController.h"
#import "Expenses.h"
#import "Accounts.h"

@implementation SMExpenseController

@synthesize appDelegate;
@synthesize dataSource;
@synthesize dataDestination;


- (IBAction)addAction:(id)sender {
    
    NSArray* source = [dataSource selectedObjects];
    
    if(source != nil)  {
        NSUInteger count = source.count;
        
        if(count > 0) {
            Accounts* selectedAccount = [source objectAtIndex:0];
            NSManagedObjectContext *context = [appDelegate.delegate managedObjectContext];
            Expenses* expense = [NSEntityDescription insertNewObjectForEntityForName:@"Expenses" inManagedObjectContext:context];
        
            [selectedAccount addExpensesObject:expense];
            expense.account = selectedAccount;
        }else {
            NSAlert *alert = [[NSAlert alloc]init];
            [alert setInformativeText:@"You should first add a bank Account"];
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
