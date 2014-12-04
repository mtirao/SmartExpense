//
//  DotLine.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "DotLine.h"

@implementation DotLine

@synthesize count;

-(Statics*)initDotLineCharWithDictionary:(NSDictionary*)data {
    
    self = [super initChartWithDictionary:data];
    
    self.min = (float)NSIntegerMax;
    self.max = 10;
    count = 0;
    
    
    for (NSArray* d in data.allValues) {
        count = (count >= d.count)?count:d.count;
        for (NSManagedObject* obj in d) {
            NSNumber* value = (NSNumber*)([obj valueForKey:@"price"]);
            self.max = (self.max >= value.floatValue)?self.max : value.floatValue;
            self.min = (self.min <= value.floatValue)?self.min : value.floatValue;
        }
    }
    
    return self;
}


-(void)dotLineChart:(CGRect)rect {
    
    float margin = 30;
    
    NSFont* referenceFont = [NSFont boldSystemFontOfSize:9.0];
    
    NSDictionary* fontAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSColor blackColor], NSForegroundColorAttributeName,
                               referenceFont, NSFontAttributeName, nil];
    
    
    CGRect frame = CGRectMake(rect.origin.x + margin , rect.origin.y + margin, rect.size.width - margin, rect.size.height - margin);
    
    //Draw quandrant
    [[NSColor blackColor]set];
    NSBezierPath * quandrant = [NSBezierPath bezierPath];
    [quandrant moveToPoint: CGPointMake(frame.origin.x, frame.origin.y)];
    [quandrant lineToPoint:CGPointMake(frame.origin.x, frame.size.height)];
    
    [quandrant moveToPoint: CGPointMake(frame.origin.x, frame.origin.y)];
    [quandrant lineToPoint:CGPointMake(frame.size.width, frame.origin.y)];
    [quandrant stroke];
    
    int ymax = (int)ceilf(self.max);
    
    float ycoef = frame.size.height / ymax;
    
    //Axis reference
    NSBezierPath * yAxis = [NSBezierPath bezierPath];
    float origin = frame.origin.y;
    for (int i = 0; i < (int)ymax; i++) {
        
        origin = frame.origin.y + i * ycoef;
        if (i!=0) {
            [[NSColor lightGrayColor]set];
        }
        [yAxis moveToPoint:CGPointMake(frame.origin.x - 5, origin)];
        [yAxis lineToPoint:CGPointMake(frame.size.width, origin)];
    }
    [yAxis stroke];

    [[NSColor blackColor]set];
    
    float xcoef = frame.size.width / count;
    
    NSBezierPath * xAxis = [NSBezierPath bezierPath];
    origin = frame.origin.y;
    for (int i = 0; i <= count; i++) {
        
        origin = frame.origin.y + i * xcoef;
        
        if (i!=0) {
            [[NSColor lightGrayColor]set];
        }
        [xAxis moveToPoint:CGPointMake(origin, frame.origin.y - 5)];
        [xAxis lineToPoint:CGPointMake(origin, frame.size.height)];
        
    }
    [xAxis stroke];

    //Y Axis legend
    
    [[NSColor blackColor]set];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    origin = frame.origin.y;
    for (int i = 0; i < (int)ymax; i++) {
        origin = frame.origin.y + i * ycoef;
        NSString *value = [formatter stringFromNumber:[NSNumber numberWithFloat:(float)i]];
        [value drawAtPoint:CGPointMake(frame.origin.x - margin + 5, origin) withAttributes:fontAttrs];
    }
    
    
    origin = frame.origin.y;
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterShortStyle];
    
    
    
   
    
    for (NSString *key in [self.staticsData allKeys]) {
        //X Axis Legend
        NSArray* data = [self.staticsData objectForKey:key];
        for (int i = 0; i < data.count; i++) {
            origin = frame.origin.y + i * xcoef;
            NSManagedObject *obj = [data objectAtIndex:i];
            NSDate* date = [[obj valueForKeyPath:@"list"] valueForKey:@"purchased"];
            NSString *value = [df stringFromDate:date];
            [value drawAtPoint:CGPointMake(origin - 10, frame.origin.y - 20) withAttributes:fontAttrs];
        }
    
    
        //Data Drawing
        float x = frame.origin.x;
        float y = frame.origin.y;
        NSBezierPath *line = [NSBezierPath bezierPath];
        NSColor* color = [self.colors objectAtIndex:3];
        [color set];
        
        BOOL isFirstDot = YES;
        for (int i = 0; i < data.count; i++) {
            NSManagedObject *obj = [data objectAtIndex:i];
            NSNumber *price = [obj valueForKey:@"price"];
            x = margin + (i * xcoef);
            y = margin + ((price.floatValue) * ycoef);
            NSBezierPath *dot = [NSBezierPath bezierPathWithRect:NSMakeRect(x - 2, y - 2, 4, 4)];
            [dot fill];
            if(isFirstDot) {
                [line moveToPoint:NSMakePoint(x, y)];
                isFirstDot = NO;
            }else {
                [line lineToPoint:NSMakePoint(x, y)];
            }
            
        }
        [line stroke];
    }
    
}

-(void)drawChartInRect:(CGRect)rect withTitle:(NSString*)title{
    
    if(self.backgroundColor != nil ) {
        [self.backgroundColor set];
        NSBezierPath* background = [NSBezierPath bezierPathWithRect:rect];
        [background fill];
        [[NSColor blackColor]set];
    }
    
    NSFont* titleFont = [NSFont boldSystemFontOfSize:20.0];
    
    NSDictionary* fontAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSColor blackColor], NSForegroundColorAttributeName,
                               titleFont, NSFontAttributeName, nil];
    
    if(title != nil) {
        CGSize titleSize = [title sizeWithAttributes:fontAttrs];
        float x = (rect.size.width / 2) - (titleSize.width / 2);
        CGPoint titlePoint = CGPointMake(x, 18);
        [title drawAtPoint:titlePoint withAttributes:fontAttrs];
    }
    
    [self dotLineChart:rect];

}

@end
