//
//  SMCalendarView.m
//  SmartExpense
//
//  Created by Marcos Tirao on 6/2/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMCalendarView.h"
#import "SMAppDelegate.h"
#import "Accounts.h"
#import "Expenses.h"

@implementation SMCalendarView

@synthesize calendar, popOverDatePicker, popOverView, popover, dataSource, appDelegate;
@synthesize popOverStoreName, popOverTotal, popOverType;
@synthesize yearLabel, monthLabel;

-(id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    
    NSRect r = frameRect;
    
    calendar = [[SMCalendarController alloc]initWithRect:r];
    self.calendar.date = [NSDate date];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    self.calendar.appDelegate = self.appDelegate;
    self.calendar.monthLabel = self.monthLabel;
    self.calendar.yearLabel = self.yearLabel;
    
    
    [self.calendar drawCalendar];
}

-(void)mouseDown:(NSEvent *)theEvent {
    
    NSPoint p = [theEvent locationInWindow];
    p = [self convertPoint:p fromView:nil];
    
    NSDate* selectedDate = [calendar dateFromPoint:p];
    
    if(selectedDate != nil) {
        
        NSRect tileFrame = [calendar tileFromPoint:p].frame;
        
        popOverDatePicker.dateValue = selectedDate;
    
        NSViewController *controller = [[NSViewController alloc]init];
        [controller setView:popOverView];
    
        if(popover == nil) {
            popover = [[NSPopover alloc]init];
            [popover setContentViewController:controller];
            [popover setAnimates:YES];
        }
        
        if(popover.shown) {
            [popover performClose:self];
        }
        
        [popover showRelativeToRect:tileFrame ofView:self preferredEdge: NSMaxXEdge];
    }else {
        [popover performClose:self];
    }
    
}


-(IBAction)nextMonth:(id)sender {
    [calendar nextMonth];
    [self setNeedsDisplay:YES];
}

-(IBAction)prevMonth:(id)sender {
    [calendar prevMonth];
    [self setNeedsDisplay:YES];
}

-(IBAction)today:(id)sender {
    [calendar today];
    [self setNeedsDisplay:YES];
}


-(IBAction)okPopover:(id)sender {
    NSArray* source = [dataSource selectedObjects];
    
    
    
    if(source != nil && popOverStoreName.stringValue.length > 0)  {
        NSUInteger count = source.count;
        
        if(count > 0) {
            Accounts* selectedAccount = [source objectAtIndex:0];
            NSManagedObjectContext *context = [appDelegate managedObjectContext];
            Expenses* expense = [NSEntityDescription insertNewObjectForEntityForName:@"Expenses" inManagedObjectContext:context];
            
            expense.due = popOverDatePicker.dateValue;
            expense.storename = popOverStoreName.stringValue;
            expense.type = [popOverType selectedItem].title;
            
            if([expense.type isEqualToString:@"Income"]) {
                expense.total = [NSNumber numberWithFloat:[popOverTotal floatValue]];
            }else {
                expense.total = [NSNumber numberWithFloat:-[popOverTotal floatValue]];
            }
            
            [selectedAccount addExpensesObject:expense];
            expense.account = selectedAccount;
            
            [context save:nil];
        }
    }
    
   
    [popover performClose:sender];
    
    [self setNeedsDisplay:YES];
}

-(IBAction)cancelPopover:(id)sender {
    [popover performClose:sender];
}

@end
