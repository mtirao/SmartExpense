//
//  SMTileController.h
//  SmartExpense
//
//  Created by Marcos Tirao on 6/2/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMTile.h"
#import "SMAppDelegate.h"

@interface SMCalendarController : NSObject {
@private
    NSMutableArray* calendar;
    NSArray *nameOfMonth;
    NSInteger month;
    NSInteger year;
    
    double secondsPerDay;
}

@property (readonly) NSRect frame;
@property (copy, nonatomic) NSDate* date;

@property (nonatomic, weak) SMAppDelegate *appDelegate;
@property (nonatomic, weak) NSTextFieldCell* yearLabel;
@property (nonatomic, weak) NSTextFieldCell* monthLabel;


-(SMCalendarController*) initWithRect:(NSRect)r;
-(void)drawCalendar;
-(SMTile*)tileFromPoint:(NSPoint)point;
-(void)gotoDateFromTile:(SMTile*)tile;

-(void)nextMonth;
-(void)prevMonth;
-(void)today;

@end
