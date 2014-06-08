//
//  SMExpenseSchedController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/4/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMExpenseSchedController.h"
#import "Accounts.h"
#import "Expenses.h"

@implementation SMExpenseSchedController

@synthesize accounts;
@synthesize appDelegate;
@synthesize mainWindow;
@synthesize expensesType, selectedAccount, frequency;
@synthesize from, to;
@synthesize every, total, storename;


- (IBAction)okAction:(id)sender {
    
    [NSApp endSheet:mainWindow];
    [mainWindow orderOut:sender];
    
    NSArray *acc = [accounts arrangedObjects];
    NSInteger item = [selectedAccount indexOfSelectedItem];
    
    if( acc != nil && acc.count > item) {
        Accounts *account = [acc objectAtIndex:item];
        
        NSArray *dates = [self expensesDate];
        
        for(NSDate *d in dates) {
            Expenses* expense = [NSEntityDescription insertNewObjectForEntityForName:@"Expenses" inManagedObjectContext:appDelegate.delegate.managedObjectContext];
            
            expense.due = d;
            expense.type = expensesType.selectedItem.title;
            expense.account = account;
            expense.storename = storename.stringValue;
            NSNumberFormatter *nf = [[NSNumberFormatter alloc]init];
            [nf setNumberStyle:NSNumberFormatterDecimalStyle];
            expense.total = [nf numberFromString:total.stringValue];
            
            [account addExpensesObject:expense];
            
        }
        
    }else {
        [self showAlertWithMessage:@"No Account Selected. Please, choose an acount first."];
    }

}



- (IBAction)cancelAction:(id)sender {
    [NSApp endSheet:mainWindow];
    [mainWindow orderOut:sender];
}

- (IBAction)showAction:(id)sender {
    
    NSDate *today = [NSDate date];
    
    [from setDateValue:today];
    [to setDateValue:today];
    
    //[NSApp beginSheet:mainWindow modalForWindow:appDelegate.mainWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    
    if(appDelegate.expenseWindow.isKeyWindow) {
        return YES;
    }
    
    return NO;
}

//This calculates the expenses to add with the given conditions
-(NSArray*)expensesDate {
    
    NSDate *fromDate = [from dateValue];
    NSDate *toDate = [to dateValue];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSString *freq = [frequency selectedItem].title;
    
    NSInteger begin;
    NSInteger end;
    
    NSNumberFormatter *nf = [[NSNumberFormatter alloc]init];
    [nf setNumberStyle:NSNumberFormatterDecimalStyle];
    
    int step = [nf numberFromString:every.stringValue].intValue;
    if (step <= 0) {
        step = 1;
    }
    
    if([freq compare:@"Monthly"] == NSOrderedSame) {
        begin = [calendar component:NSMonthCalendarUnit fromDate:fromDate];
        end = [calendar component:NSMonthCalendarUnit fromDate:toDate];
    }else {
        begin = [calendar component:NSYearCalendarUnit fromDate:fromDate];
        end = [calendar component:NSYearCalendarUnit fromDate:toDate];
    }
    
    NSArray * result = nil;
    
    if([fromDate compare:toDate] ==  NSOrderedAscending) {
        NSMutableArray *aux = [[NSMutableArray alloc]init];
        [aux addObject:fromDate];
        
        NSInteger day = [calendar component:NSDayCalendarUnit fromDate:fromDate];
        NSInteger month = [calendar component:NSMonthCalendarUnit fromDate:fromDate];
        NSInteger year = [calendar component:NSYearCalendarUnit fromDate:fromDate];
        
        NSDateComponents *comps = [[NSDateComponents alloc]init];
        [comps setDay:day];
        
        for (NSInteger j = (begin + 1); j<=end; j+=step) {
            if([freq compare:@"Monthly"] == NSOrderedSame) {
                [comps setMonth:j];
                [comps setYear:year];
            }else {
                [comps setMonth:month];
                [comps setYear:j];
            }
            [aux addObject:[calendar dateFromComponents:comps]];
        }
        result = [NSArray arrayWithArray:aux];
    }
    
    return result;
}


#pragma mark ***** Aux Method *****

-(void)showAlertWithMessage:(NSString*)message {
    NSAlert *alert = [[NSAlert alloc]init];
    [alert setInformativeText:message];
    [alert addButtonWithTitle:@"Ok"];
    void(^returnCode)(NSModalResponse) = ^(NSModalResponse code){};
   [alert beginSheetModalForWindow:appDelegate.expenseWindow completionHandler:returnCode];
}

@end
