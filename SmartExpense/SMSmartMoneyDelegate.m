//
//  SMSmartMoneyDelegate.m
//  SmartExpense
//
//  Created by Marcos Tirao on 3/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMSmartMoneyDelegate.h"
#import "List.h"
#import "Store.h"
#import "Expenses.h"
#import "Model.h"
#import "Fuel.h"
#import "Items.h"

@implementation SMSmartMoneyDelegate


@synthesize mainWindow;
@synthesize listPanel;
@synthesize fuelPanel;
@synthesize expenseType;
@synthesize mainTabs;
@synthesize listEntity, modelEntity, selectedExpense;
@synthesize delegate;



-(IBAction)showWindow:(id)sender {
    [mainWindow makeKeyAndOrderFront:sender];
}

- (IBAction)showListInfo:(id)sender {
    
    NSString * value = expenseType.titleOfSelectedItem;
    
    if([value isEqualToString:@"Fuel"]) {
        [NSApp beginSheet:fuelPanel modalForWindow:mainWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
    }else {
    
        [NSApp beginSheet:listPanel modalForWindow:mainWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
    }
    
}


- (IBAction)okListInfo:(id)sender {
    
    NSString * value = expenseType.titleOfSelectedItem;
    NSArray* destination = [selectedExpense selectedObjects];
    
    if([value isEqualToString:@"Fuel"]) {
        NSArray* source = [modelEntity selectedObjects];
        
        if(source != nil && [source count] > 0 && destination !=nil && [destination count] > 0) {
            Model *model = [source objectAtIndex:0];
            
            float total = 0;
            for(Fuel *f in model.fuel) {
                if(!f.consolidated.boolValue) {
                    total += f.amount.floatValue * f.price.floatValue;
                    f.consolidated = [NSNumber numberWithBool:YES];
                }
            }
            
            Expenses *expense = [destination objectAtIndex:0];
            expense.type = @"Fuel";
            expense.storename = model.name;
            expense.total = [NSNumber numberWithFloat:total];
            
        }
        
        [NSApp endSheet:fuelPanel];
        [fuelPanel orderOut:sender];
    }else {
        NSArray* source = [listEntity selectedObjects];
    
        if(source != nil && [source count] > 0 && destination !=nil && [destination count] > 0) {
            List *list = [source objectAtIndex:0];
            NSString *storeName = [NSString stringWithFormat:@"%@ - %@", list.name, list.store.name];
        
            Expenses *expense = [destination objectAtIndex:0];
        
            expense.storename = storeName;
            
            float amt = 0;
            
            for (Items * i in list.items) {
                amt += (i.price.floatValue * i.quantity.floatValue);
            }
            
            expense.total = [NSNumber numberWithFloat:amt];
        }
    
        [NSApp endSheet:listPanel];
        [listPanel orderOut:sender];
    }
    
}

- (IBAction)cancelListInfo:(id)sender {
    NSString * value = expenseType.titleOfSelectedItem;
    
    if([value isEqualToString:@"Fuel"]) {
        [NSApp endSheet:fuelPanel];
        [fuelPanel orderOut:sender];
    }else {
        [NSApp endSheet:listPanel];
        [listPanel orderOut:sender];
    }
}

@end
