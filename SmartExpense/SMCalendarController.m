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
    
    secondsPerDay = 60 * 60 * 24;
    
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
    
    
    NSDate *firstDateOfCurrentMonth = [self firstDateOfCurrentMonth];
    
    NSDateComponents *comp = [currentCalendar components:(kCFCalendarUnitWeekday | kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute) fromDate:firstDateOfCurrentMonth];
    
    month = [comp month];
    year = [comp year];
    
    NSInteger weekday = [comp weekday];
    
    NSString *yearS = [NSString stringWithFormat:@"%ld", [comp year]];
    self.yearLabel.stringValue = yearS;
    
    NSString *monthName = [nameOfMonth objectAtIndex:month - 1];
    self.monthLabel.stringValue = monthName;
    
    
    NSDate *date1 = [NSDate dateWithTimeInterval: -secondsPerDay*(weekday-1) sinceDate: firstDateOfCurrentMonth];
    
    
    for (NSInteger i=0;  i< 6; i++) {
        NSMutableArray *week = [calendar objectAtIndex:i];
        for(NSInteger j=0; j < 7; j++ ){
            
            NSInteger month1 = [currentCalendar component:NSCalendarUnitMonth fromDate:date1];
            NSInteger day1 = [currentCalendar component: NSCalendarUnitDay fromDate:date1];
            
            
            SMTile *d = [week objectAtIndex:j];
            
            d.text = [NSString stringWithFormat:@"%ld", day1];
            d.date = [NSDate dateWithTimeInterval:0 sinceDate:date1];
            
            if(j == 0 || j==6) {
                d.isWeekendDay = YES;
            }else {
                d.isWeekendDay = NO;
            }
            
            if(month1 == month) {
                d.isCurrent = [self isCurrentDateForMonth:month1 forDay:day1 forYear:year];
                d.data = [self dataForDate:date1];
                d.isCurrentMonth = YES;
                
                [d drawTile];
            }else {
                d.isCurrentMonth = NO;
                [d drawTile];
            }
            
            date1 = [NSDate dateWithTimeInterval: secondsPerDay sinceDate: date1];
        }
    }
    
    /*for (NSInteger i=0;  i< 6; i++) {
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
    }*/
    
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

-(void)gotoDateFromTile:(SMTile*)tile {
    self.date = [NSDate dateWithTimeInterval:0 sinceDate:tile.date];
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

    NSNumberFormatter *amountFormatter = [[NSNumberFormatter alloc]init];
    amountFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    
    for(Expenses *expense in expenses) {
        
        if(expense.account != nil) {
            amountFormatter.currencySymbol = expense.account.currencysymbol;
        
            NSString *text;
            
            if (expense.total.doubleValue < 0) {
                
                NSString *amount = [amountFormatter stringFromNumber:expense.total];

                NSUInteger length = amount.length + expense.type.length + 5;
                
                if(length > 26) {
                    
                    NSString *type;
                    
                    if(expense.type.length > (amount.length+5)) {
                        type = [expense.type substringToIndex:expense.type.length - amount.length];
                    }else {
                        type = expense.type;
                    }
                    
                    text = [NSString stringWithFormat:@"%@ - (%@)", type, amount];
                }else {
                    text = [NSString stringWithFormat:@"%@ - (%@)", expense.type, amount];
                }
                
            }else {
                
                NSString *amount = [amountFormatter stringFromNumber:expense.total];
                
                NSUInteger length = amount.length + expense.type.length + 3;
                
                if(length > 26) {
                    
                    NSString *type;
                    
                    if(expense.type.length > (amount.length+3)) {
                        type = [expense.type substringToIndex:expense.type.length - amount.length];
                    }else {
                        type = expense.type;
                    }
                    
                    text = [NSString stringWithFormat:@"%@ - %@", type, amount];
                }else {
                    text = [NSString stringWithFormat:@"%@ - %@", expense.type, amount];
                }
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
