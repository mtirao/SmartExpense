//
//  SMTileController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 6/2/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMCalendarController.h"
#import "Expenses.h"
#import "Accounts.h"
#import "List.h"

@implementation SMCalendarController

@synthesize frame, date;
@synthesize appDelegate;
@synthesize monthLabel, yearLabel;

-(SMCalendarController*) initWithRect:(NSRect)r {
    
    frame = r;
    
    calendar = [[NSMutableArray alloc]initWithCapacity:6];
    
    NSArray* dayOfWeek = @[@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat"];
    
    nameOfMonth = @[@"JANUARY", @"FEBRUARY", @"MARCH", @"APRIL", @"MAY", @"JUNE", @"JULY", @"AUGUST", @"SEPTEMBER", @"OCTOBER", @"NOVEMBER", @"DECEMBER"];
    
    float height = (r.size.height - 20) / 6;
    float width = (r.size.width) / 7;
    
    for (int i = 0; i < 6; i++) {
        NSMutableArray *week = [[NSMutableArray alloc]initWithCapacity:7];
        for (int j = 0; j < 7; j++) {
            NSRect tileRect = NSMakeRect(width * j, (r.size.height - 20) - ((i+1)*height),
                                                     width, height);
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
    
    NSDateComponents *comp = [currentCalendar components:(kCFCalendarUnitWeekday | kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute) fromDate:[self firstDateOfCurrentMonth]];
    
    month = [comp month];
    year = [comp year];
    
    NSInteger weekday = [comp weekday];
    
    NSString *yearS = [NSString stringWithFormat:@"%ld", [comp year]];
    self.yearLabel.stringValue = yearS;
    
    NSString *monthName = [nameOfMonth objectAtIndex:month - 1];
    self.monthLabel.stringValue = monthName;
    
    BOOL isFirstRow = YES;
    NSInteger day = 1;
    
    for (NSInteger i=0;  i< 6; i++) {
        NSInteger init = 0;
        if(isFirstRow) {
            init = weekday - 1;
            isFirstRow = NO;
        }
        for(NSInteger j=0; j < 7; j++ ) {
            [comp setDay:day];
            [comp setHour:0];
            [comp setMinute:0];
            NSDate *date1 = [currentCalendar dateFromComponents:comp];
            
            NSInteger month1 = [currentCalendar component:NSCalendarUnitMonth fromDate:date1];
            
            if (month1 == month) {
                NSMutableArray *week = [calendar objectAtIndex:i];
                SMTile *d = [week objectAtIndex:j];
                if (j >= init) {
                    d.text = [NSString stringWithFormat:@"%ld", day];
                    d.isCurrent = [self isCurrentDateForMonth:month forDay:day forYear:year];
                    d.data = [self dataForDate:date1];
                    [d drawTile];
                    day++;
                }else {
                    d.text = nil;
                    d.data = [self dataForDate:date1];
                    [d drawTile];
                }
            }
            
        }
    }
    
}

-(BOOL)isCurrentDateForMonth:(NSInteger)aMonth forDay:(NSInteger)aDay forYear:(NSInteger)aYear {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    
    return (aDay == [comp day]) && (aMonth == [comp month]) && (aYear == [comp year]);
}

-(NSDate*)firstDateOfCurrentMonth {
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [currentCalendar components:(NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    [comp setDay:1];
    
    return [currentCalendar dateFromComponents:comp];
}

-(NSDate*)dateFromPoint:(NSPoint)point {
    
    for (NSInteger i=0;  i< 6; i++) {
        NSMutableArray *week = [calendar objectAtIndex:i];
        for(NSInteger j=0; j < 7; j++ ) {
            SMTile* day = [week objectAtIndex:j];
            if(NSPointInRect(point, day.frame) && day.text != nil) {
                [self unselectAll];
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

-(SMTile*)tileFromPoint:(NSPoint)point {
    
    for (NSInteger i=0;  i< 6; i++) {
        NSMutableArray *week = [calendar objectAtIndex:i];
        for(NSInteger j=0; j < 7; j++ ) {
            SMTile* day = [week objectAtIndex:j];
            if(NSPointInRect(point, day.frame) && day.text != nil) {
                return day;
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
    
    NSDateComponents *comp = [currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    [comp setMonth:[comp month] + 1];
    
    self.date = [currentCalendar dateFromComponents:comp];
    
}

-(void)prevMonth {
    
    NSCalendar* currentCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    [comp setMonth:[comp month] - 1];
    
    self.date = [currentCalendar dateFromComponents:comp];
    
}

-(void)today {
    self.date = [NSDate date];
}

-(NSArray*) dataForDate:(NSDate*)date1 {
    
    NSArray* expenses = [self.appDelegate expensesByDate:date1];
    NSArray* lists = [self.appDelegate listsByDate:date1];
    
    NSMutableArray* mergeData = [[NSMutableArray alloc]init];

    NSNumberFormatter *amount = [[NSNumberFormatter alloc]init];
    amount.numberStyle = NSNumberFormatterCurrencyStyle;
    
    for(Expenses *expense in expenses) {
        
        if(expense.account != nil) {
            amount.currencySymbol = expense.account.currencysymbol;
        
            NSString *text;
        
            if (expense.total.doubleValue < 0) {
                text = [NSString stringWithFormat:@"%@ - (%@)", expense.type, [amount stringFromNumber:expense.total]];
            }else {
                text = [NSString stringWithFormat:@"%@ - %@", expense.type, [amount stringFromNumber:expense.total]];
            }
        
        
            [mergeData addObject:text];
        }else {
            [[self.appDelegate managedObjectContext]deleteObject:expense];
        }
    }
    
    for(List* list in lists) {
        
        if(list.store != nil) {
            [mergeData addObject:list.name];
        }else {
            [[self.appDelegate managedObjectContext]deleteObject:list];
        }
    }
    
    return [NSArray arrayWithArray:mergeData];
}

@end
