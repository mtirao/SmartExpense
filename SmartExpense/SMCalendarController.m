//
//  SMTileController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 6/2/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMCalendarController.h"

@implementation SMCalendarController

@synthesize frame, date;

-(SMCalendarController*) initWithRect:(NSRect)r {
    
    frame = r;
    
    calendar = [[NSMutableArray alloc]initWithCapacity:6];
    
    NSArray* dayOfWeek = @[@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat"];
    
    nameOfMonth = @[@"JANUARY", @"FEBRUARY", @"MARCH", @"APRIL", @"MAY", @"JUNE", @"JULY", @"AUGUST", @"SEPTEMBER", @"OCTOBER", @"NOVEMBER", @"DECEMBER"];
    
    for (int i = 0; i < 6; i++) {
        NSMutableArray *week = [[NSMutableArray alloc]initWithCapacity:7];
        for (int j = 0; j < 7; j++) {
            NSRect tileRect = NSMakeRect(90 * j, r.size.height - ((i+1)*100), 90, 100);
            SMTile *tile = [[SMTile alloc]initWithRect:tileRect];
            if (i == 0) {
                tile.header = [dayOfWeek objectAtIndex:j];
            }
            
            [week addObject:tile];
        }
        [calendar addObject:week];
    }
    
    return self;
}

-(void)drawCalendar {
    
    [[NSColor whiteColor]set];
    NSBezierPath* clear = [NSBezierPath bezierPathWithRect:self.frame];
    [clear fill];
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [currentCalendar components:(NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[self firstDateOfCurrentMonth]];
    
    month = [comp month];
    year = [comp year];
    
    NSInteger weekday = [comp weekday];
    
    NSFont* yearFont = [NSFont systemFontOfSize:17.0];
    NSDictionary* yearFontAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSColor blackColor], NSForegroundColorAttributeName,
                                    yearFont, NSFontAttributeName, nil];
    NSString *yearS = [NSString stringWithFormat:@"%ld", [comp year]];
    NSSize size = [yearS sizeWithAttributes:yearFontAttrs];
    NSPoint yearPos = NSMakePoint(self.frame.size.width - size.width - 2 ,
                                  self.frame.size.height + 16);
    [yearS drawAtPoint:yearPos withAttributes:yearFontAttrs];
    
    NSFont* monthFont = [NSFont boldSystemFontOfSize:17.0];
    NSDictionary* monthFontAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSColor blackColor], NSForegroundColorAttributeName,
                                    monthFont, NSFontAttributeName, nil];
    NSString *monthName = [nameOfMonth objectAtIndex:month - 1];
    size = [monthName sizeWithAttributes:monthFontAttrs];
    NSPoint monthPos = NSMakePoint(yearPos.x-size.width, yearPos.y);
    [monthName drawAtPoint:monthPos withAttributes:monthFontAttrs];
    
    BOOL isFirstRow = YES;
    NSInteger day = 1;
    
    for (NSInteger i=0;  i< 6; i++) {
        NSInteger init = 0;
        if(isFirstRow) {
            init = weekday - 1;
            isFirstRow = NO;
        }
        for(NSInteger j=init; j < 7; j++ ) {
            [comp setDay:day];
            NSDate *date1 = [currentCalendar dateFromComponents:comp];
            NSInteger month1 = [currentCalendar component:NSMonthCalendarUnit fromDate:date1];
            
            if (month1 == month) {
                NSMutableArray *week = [calendar objectAtIndex:i];
                SMTile *d = [week objectAtIndex:j];
                d.text = [NSString stringWithFormat:@"%ld", day];
                d.isCurrent = [self isCurrentDateForMonth:month forDay:day forYear:year];
                [d drawTile];
            }
            
            day++;
        }
    }
    
}

-(BOOL)isCurrentDateForMonth:(NSInteger)aMonth forDay:(NSInteger)aDay forYear:(NSInteger)aYear {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [currentCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    
    return (aDay == [comp day]) && (aMonth == [comp month]) && (aYear == [comp year]);
}

-(NSDate*)firstDateOfCurrentMonth {
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [currentCalendar components:(NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.date];
    
    [comp setDay:1];
    
    return [currentCalendar dateFromComponents:comp];
}

-(NSDate*)dateFromPoint:(NSPoint)point {
    
    for (NSInteger i=0;  i< 6; i++) {
        NSMutableArray *week = [calendar objectAtIndex:i];
        for(NSInteger j=0; j < 7; j++ ) {
            SMTile* day = [week objectAtIndex:j];
            if(NSPointInRect(point, day.frame)) {
                [self unselectAll];
                day.isSelected = YES;
                NSCalendar *currentCalendar = [NSCalendar currentCalendar];
                NSDateComponents *comp = [[NSDateComponents alloc] init];
                
                NSInteger dayOfMonth = day.text.integerValue;
                
                [comp setDay:dayOfMonth];
                [comp setMonth:self->month];
                [comp setYear:self ->year];
                
                return [currentCalendar dateFromComponents:comp];
            }
        }
    }
    
    return nil;
}



-(void)unselectAll {
    for (NSInteger i=0;  i< 6; i++) {
        NSMutableArray *week = [calendar objectAtIndex:i];
        for(NSInteger j=0; j < 7; j++ ) {
             SMTile* day = [week objectAtIndex:j];
            day.isSelected = NO;
        }
    }
}

-(void)nextMonth {
    
    NSCalendar* currentCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [currentCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.date];
    
    [comp setMonth:[comp month] + 1];
    
    self.date = [currentCalendar dateFromComponents:comp];
    
}

-(void)prevMonth {
    
    NSCalendar* currentCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [currentCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.date];
    
    [comp setMonth:[comp month] - 1];
    
    self.date = [currentCalendar dateFromComponents:comp];
    
}

@end
