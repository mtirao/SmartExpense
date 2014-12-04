//
//  SMCalendarView.m
//  SmartExpense
//
//  Created by Marcos Tirao on 6/2/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMCalendarView.h"
#import "SMAppDelegate.h"

@implementation SMCalendarView

@synthesize calendar;

-(id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    
    NSRect r = frameRect;
    
    r.size.height -=50;
    
    calendar = [[SMCalendarController alloc]initWithRect:r];
    self.calendar.date = [NSDate date];
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect {
    [self.calendar drawCalendar];
}

-(void)mouseUp:(NSEvent *)theEvent {
    
    NSPoint p = [theEvent locationInWindow];
    p = [self convertPoint:p fromView:nil];
    
    NSDate* selectedDate = [calendar dateFromPoint:p];
    
    if(selectedDate != nil) {
        NSApplication *app = [NSApplication sharedApplication];
        SMAppDelegate* delegate = (SMAppDelegate*)[app delegate];
    
        [delegate loadInfoTable:selectedDate];
    
        [self setNeedsDisplay:YES];
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

@end
