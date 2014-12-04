//
//  DispersionChart.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "DispersionChart.h"

@implementation DispersionChart

@synthesize auxData;

-(Statics*)initDispersionChartWithDictionary:(NSDictionary*)data dispertionBand:(NSArray*)bands{
    
    NSArray * values = data.allValues;
    
    self.max = 0;
    self.min = LONG_MAX;
    
    for (NSNumber* value in values){
        self.max = (self.max >= value.floatValue)?self.max : value.floatValue;
        self.min = (self.min <= value.floatValue)?self.min : value.floatValue;
    }
    
    for (NSNumber* value in bands){
        self.max = (self.max >= value.floatValue)?self.max : value.floatValue;
        self.min = (self.min <= value.floatValue)?self.min : value.floatValue;
    }
    
    self.staticsData = data;
    self.auxData = bands;
    
    return self;
}

-(void)dispChart:(CGRect)rect {
    
    float margin = 20;
    
    NSFont* referenceFont = [NSFont boldSystemFontOfSize:11.0];
    
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
    
    float coefY = frame.size.height / (ceil(self.max) + 1);
    
    //Draw axis legends
    for (int j = 0; j<=self.max; j++) {
        
        [[NSColor blackColor]set];
        NSString *formattedOutput = [NSString stringWithFormat:@"%d", j];
        CGSize textSize = [formattedOutput sizeWithAttributes:fontAttrs];
        
        float y = frame.origin.y + (coefY * j) - (textSize.height / 2);
        [formattedOutput drawInRect:CGRectMake(rect.origin.x, y, textSize.width, 12) withAttributes:fontAttrs];
        
        NSBezierPath * line = [NSBezierPath bezierPath];
        [[NSColor lightGrayColor]set];
        [line moveToPoint:CGPointMake(frame.origin.x-5, y + (textSize.height / 2))];
        [line lineToPoint:CGPointMake(frame.size.width, y + (textSize.height / 2))];
        [line stroke];
        
    }
    
    
    
    //Draw auxiliary lines
    NSBezierPath * line = [NSBezierPath bezierPath];
    [[NSColor redColor]set];
    for(NSNumber * value in self.auxData) {
        float y = frame.origin.y + (coefY * value.floatValue);
        [line moveToPoint:CGPointMake(frame.origin.x-5, y)];
        [line lineToPoint:CGPointMake(frame.size.width, y)];
        [line stroke];
    }
    [line stroke];
    
   [[NSColor blackColor]set];
    float coefX = frame.size.width / ([[self.staticsData allKeys]count]+1);
    
    
    //Draw statics data, with X axis legends
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    int i = 1;
    for (NSDate * key in [self.staticsData allKeys]){
        NSString *formattedOutput = [dateFormatter stringFromDate:key];
        
        int textWidth = [formattedOutput sizeWithAttributes:fontAttrs].width;
        
        [formattedOutput drawAtPoint:CGPointMake(coefX*i - textWidth / 2, frame.origin.y - margin) withAttributes:fontAttrs];
        
        NSNumber * value = [self.staticsData objectForKey:key];
        NSBezierPath * box = [NSBezierPath bezierPathWithOvalInRect:CGRectMake(i*coefX, frame.origin.x + value.floatValue * coefY, 5, 5)];
        [box fill];
        
        i++;
    }
    
    //Draw axis text
    [[NSColor blackColor]set];
    
    if(self.axisText != nil) {
        
        NSString * axisYText = [self.axisText objectForKey:@"Y_AXIS_TEXT"];
        if (axisYText != nil) {
            [axisYText drawAtPoint:CGPointMake(rect.origin.x +2, rect.size.height - margin) withAttributes:fontAttrs];
        }
    
        NSString * axisXText = [self.axisText objectForKey:@"X_AXIS_TEXT"];
        if (axisXText != nil) {
            int textWidth = [axisXText sizeWithAttributes:fontAttrs].width;
            [axisXText drawAtPoint:CGPointMake(rect.size.width - textWidth - 2, rect.origin.y) withAttributes:fontAttrs];
        }
        
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
    
    [self dispChart:rect];
}

@end
