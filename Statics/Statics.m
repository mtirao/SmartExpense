//
//  Statics.m
//
//  Created by Marcos Tirao on 9/13/13.
//  Copyright (c) 2013 Marcos Tirao. All rights reserved.
//

#import "Statics.h"
#import <math.h>

@implementation Statics

@synthesize staticsData, colors, axisText;
@synthesize max, min;
@synthesize backgroundColor;

-(Statics*)initChartWithDictionary:(NSDictionary*)data {
    self.staticsData = data;
    
    NSColor* color1 = [NSColor colorWithRed:0.0 green: 0.30 blue:0.30 alpha:1.0];
    NSColor* color2 = [NSColor colorWithRed:0.0 green:0.30 blue:0.60 alpha:1.0];
    NSColor* color3 = [NSColor colorWithRed:0.0 green:0.30 blue:1.0 alpha:1.0];
    NSColor* color4 = [NSColor colorWithRed:0.0 green:0.60 blue:0.30 alpha:1.0];
    NSColor* color5 = [NSColor colorWithRed:0.0 green:1.0 blue:0.30 alpha:1.0];
    NSColor* color6 = [NSColor colorWithRed:0.0 green:1.0 blue:0.60 alpha:1.0];
    NSColor* color7 = [NSColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];
    NSColor* color8 = [NSColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.0];
    NSColor* color9 = [NSColor colorWithRed:0.60 green:0.30 blue:0.60 alpha:1.0];
    NSColor* color10 = [NSColor colorWithRed:0.60 green:0.30 blue:0.60 alpha:1.0];
    NSColor* color11 = [NSColor colorWithRed:0.60 green:0.60 blue:0.90 alpha:1.0];
    
    self.colors = @[color1, color2, color3, color4,
                             color5, color6, color7, color8, color9, color10, color11];
    
    return self;
}

-(void)drawChartInRect:(CGRect)rect withTitle:(NSString*)title{
 
    NSLog(@"%s", "This method must be overriden in all of subclasses");
    
}

-(void)drawEmptyDataSet:(CGRect)frame {
    
    NSFont* referenceFontTitle = [NSFont boldSystemFontOfSize:15.0];
    NSDictionary* fontAttrsTitle = @{NSForegroundColorAttributeName: [NSColor blackColor],
                                     NSFontAttributeName: referenceFontTitle};
    
    NSString *title = @"NO DATA TO DRAW";
    NSSize referenceTitle = [title sizeWithAttributes:fontAttrsTitle];
    
    int x = frame.size.width / 2 - referenceTitle.width / 2;
    int y = frame.size.height / 2 - referenceTitle.height / 2;
    
    
    [title drawAtPoint:NSMakePoint(x, y) withAttributes:fontAttrsTitle];
    
}


@end
