//
//  SMCalendarView.h
//  SmartExpense
//
//  Created by Marcos Tirao on 6/2/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SMCalendarController.h"

@interface SMCalendarView : NSView

@property (retain, nonatomic, readonly) SMCalendarController *calendar;


-(IBAction)nextMonth:(id)sender;
-(IBAction)prevMonth:(id)sender;

@end
