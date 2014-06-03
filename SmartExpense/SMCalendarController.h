//
//  SMTileController.h
//  SmartExpense
//
//  Created by Marcos Tirao on 6/2/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMTile.h"

@interface SMCalendarController : NSObject {
@private
    NSMutableArray* calendar;
    NSArray *nameOfMonth;
    NSInteger month;
    NSInteger year;
}

@property (readonly) NSRect frame;
@property (copy, nonatomic) NSDate* date;

-(SMCalendarController*) initWithRect:(NSRect)r;
-(void)drawCalendar;
-(void)unselectAll;
-(NSDate*)dateFromPoint:(NSPoint)point;

-(void)nextMonth;
-(void)prevMonth;

@end
