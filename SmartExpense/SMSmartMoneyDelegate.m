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
#import "Accounts.h"

@implementation SMSmartMoneyDelegate

@synthesize bankWindow, accountWindow, expenseWindow;

@synthesize listPanel;
@synthesize fuelPanel;
@synthesize expenseType;
@synthesize listEntity, modelEntity, selectedExpense, selectedAccount;
@synthesize delegate;


#pragma mark ***** Delegate Methods *****

-(void)awakeFromNib {
    bankWindow.backgroundColor = [NSColor whiteColor];
    accountWindow.backgroundColor = [NSColor whiteColor];
    expenseWindow.backgroundColor = [NSColor whiteColor];
    listPanel.backgroundColor = [NSColor whiteColor];
    fuelPanel.backgroundColor = [NSColor whiteColor];
}

-(BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    
    if (menuItem.tag == 3 || menuItem.tag == 4 || menuItem.tag == 5) {
        return YES;
    }
    
    
    if (menuItem.tag == 20) {
        return YES;
    }
    
    return NO;
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
    [self checkTotalSign];
    return YES;
}

#pragma mark ***** Action Methods *****

-(IBAction)showBankWindow:(id)sender {
    [bankWindow makeKeyAndOrderFront:sender];
}

-(IBAction)showAccountWindow:(id)sender {
    [self calculateAccountBalance];
    [accountWindow makeKeyAndOrderFront:sender];
}

- (IBAction)showExpenseWindow:(id)sender {
    [expenseWindow makeKeyAndOrderFront:sender];
}

- (IBAction)showListInfo:(id)sender {
    
    NSString * value = expenseType.titleOfSelectedItem;
    
    if([value isEqualToString:@"Fuel"]) {
        [NSApp beginSheet:fuelPanel modalForWindow:expenseWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
    }else {
        
        [NSApp beginSheet:listPanel modalForWindow:expenseWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
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

- (IBAction)selectType:(id)sender {
    [self checkTotalSign];
}


#pragma mark ***** Tab View Delegate Methods *****


- (void)calculateAccountBalance {
    
    NSArray* accounts = selectedAccount.selectedObjects;
    
    if(accounts != nil && accounts.count > 0) {
        float balance = 0;
        Accounts *currentAccount = [accounts objectAtIndex:0];
        for(Expenses *expense in currentAccount.expenses) {
            balance += expense.total.floatValue;
        }
        
        currentAccount.balance = [NSNumber numberWithFloat:balance];
    }
}

-(void) checkTotalSign {
    NSArray *expenses = selectedExpense.selectedObjects;
    
    if (expenses != nil && expenses.count > 0) {
        Expenses *expense = [expenses objectAtIndex:0];
        if ([expense.type isEqualToString:@"Income"]) {
            float amt = expense.total.floatValue;
            if (amt < 0) {
                expense.total = [NSNumber numberWithFloat:-amt];
            }
        }else {
            float amt = expense.total.floatValue;
            if (amt > 0) {
                expense.total = [NSNumber numberWithFloat:-amt];
            }
        }
    }
    
}

@end
