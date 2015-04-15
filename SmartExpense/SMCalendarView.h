//
//  SMCalendarView.h
//  SmartExpense
//
//  Created by Marcos Tirao on 6/2/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SMCalendarController.h"
#import "SMSmartMoneyDelegate.h"

@interface SMCalendarView : NSView

@property (retain, nonatomic, readonly) SMCalendarController *calendar;
@property (strong, nonatomic) NSPopover *popover;
@property (nonatomic, weak) IBOutlet SMSmartMoneyDelegate *smartMoneyDelegate;

@property (nonatomic, weak) IBOutlet SMAppDelegate *appDelegate;
@property (nonatomic, weak) IBOutlet NSArrayController* dataSource;

@property (nonatomic, weak) IBOutlet id yearLabel;
@property (nonatomic, weak) IBOutlet id monthLabel;

@property (nonatomic, weak) IBOutlet NSView *popOverView;
@property (nonatomic, weak) IBOutlet NSDatePicker *popOverDatePicker;
@property (nonatomic, weak) IBOutlet NSTextField *popOverStoreName;
@property (nonatomic, weak) IBOutlet NSTextField *popOverTotal;
@property (nonatomic, weak) IBOutlet NSPopUpButton *popOverType;

-(IBAction)nextMonth:(id)sender;
-(IBAction)prevMonth:(id)sender;
-(IBAction)today:(id)sender;

-(IBAction)okPopover:(id)sender;
-(IBAction)cancelPopover:(id)sender;


@end
