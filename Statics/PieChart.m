//
//  PieChart.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "PieChart.h"

@implementation PieChart

-(Statics*)initPieChartWithDictionary:(NSDictionary*)data {
    
    self = [super initChartWithDictionary:data];
    
    NSArray * values = data.allValues;
    
    self->total = 0;
    
    for (NSNumber* value in values){
        self -> total += value.floatValue;
    }
    
    NSArray *keys = data.allKeys;
    
    self -> referenceSize = 0;
    for(NSString *key in keys) {
        self -> referenceSize = (self -> referenceSize) >= key.length?self->referenceSize:key.length;
    }
    
    return self;
}

-(void)pieChart:(CGRect)rect {
    NSFont* referenceFont = [NSFont boldSystemFontOfSize:15.0];
    
    
    NSDictionary* fontAttrs = @{NSForegroundColorAttributeName: [NSColor blackColor],
                                NSFontAttributeName: referenceFont};

    NSSize reference = [@"O" sizeWithAttributes:fontAttrs];
    
    int referenceWidth = reference.width * self -> referenceSize;
    
    CGRect frame = CGRectMake(referenceWidth, 0, rect.size.width - referenceWidth, rect.size.height);
    
    int halfWidth = frame.size.width / 2;
    int halfHeight = frame.size.height / 2;
    
    int xcenter = referenceWidth + halfWidth;
    int ycenter = halfHeight;
    
    int radius = halfHeight <= halfWidth ? halfHeight : halfWidth;
    
    float startAngle = 0;
    float endAngle = 0;
    float count = 1;
    
    CGPoint endAnglePoint = CGPointMake(xcenter + radius, ycenter);
    
    int colorIndex = 0;
    
    float referenceY = 5;
    float referenceX = 5;
    
    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    
    
    for( NSString *category in self.staticsData.allKeys) {
        
        NSNumber * value = [self.staticsData objectForKey:category];
        
        float coef = value.floatValue / total;
        
        NSColor* arcColor = [self.colors objectAtIndex:colorIndex];
        [arcColor set];
        CGPoint categoryPoint = CGPointMake(referenceX, referenceY);
        
        NSString * percentage = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:coef]];
        NSString * reference = [NSString stringWithFormat:@"%@: %@",
                                category, percentage ];
        
        
        fontAttrs = @{NSForegroundColorAttributeName: arcColor,
                                    NSFontAttributeName: referenceFont};
        
        [reference drawAtPoint:categoryPoint withAttributes:fontAttrs];
        
        referenceY += 15;
        
        
        CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
        
        CGContextSetFillColorWithColor(context, arcColor.CGColor);
        
        // Draw them with a 2.0 stroke width so they are a bit more visible.
        CGContextSetLineWidth(context, 2.0);
        
        CGContextMoveToPoint(context, xcenter, ycenter); //start at this point
        
        CGContextAddLineToPoint(context, endAnglePoint.x , endAnglePoint.y); //draw to this point
        
        endAngle = 2*M_PI * coef + startAngle;
        
        CGContextAddArc(context, xcenter, ycenter, radius, startAngle, endAngle, 0);
        
        endAnglePoint = CGContextGetPathCurrentPoint(context);
        
        CGContextAddLineToPoint(context, xcenter, ycenter);
        
        startAngle = endAngle;
        
        CGContextFillPath(context);
        
        count += 10;
        colorIndex++;
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

    [self pieChart:rect];
    
}


@end
