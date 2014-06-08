//
//  SMTile.m
//  SmartExpense
//
//  Created by Marcos Tirao on 6/2/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMTile.h"

@implementation SMTile

@synthesize frame, data, text, header, isSelected, isCurrent;

-(SMTile*)initWithRect:(NSRect)r {
    
    frame = r;
    isSelected = NO;
    
    return self;
}

-(void)drawTile {
    
    if(self.text != nil) {
        NSFont* referenceFont = [NSFont boldSystemFontOfSize:9.0];
    
        NSDictionary* fontAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSColor blackColor], NSForegroundColorAttributeName,
                               referenceFont, NSFontAttributeName, nil];
        
        NSColor *background;
        if (isCurrent) {
            background = [NSColor colorWithRed:0.058 green:0.447 blue:1.0 alpha:0.9];
        }else {
            if(isSelected) {
                background = [NSColor colorWithRed:0.058 green:0.831 blue:0.749 alpha:0.5];
            }else {
                background = [NSColor whiteColor];
            }
            
        }
        NSColor *foreground = [NSColor colorWithRed:0.058 green:0.831 blue:0.749 alpha:1.0];
        
        [background setFill];
        [foreground setStroke];
        
        NSBezierPath *tile = [NSBezierPath bezierPathWithRect:self.frame];
        [tile fill];
        [tile stroke];
        
    
        NSSize reference = [self.text sizeWithAttributes:fontAttrs];
    
        NSPoint textPos = NSMakePoint(self.frame.origin.x + (self.frame.size.width - reference.width), self.frame.origin.y + (self.frame.size.height - reference.height));
        [self.text drawAtPoint:textPos withAttributes:fontAttrs];
    }
    
    if(self.header != nil) {
        NSFont* referenceFont = [NSFont boldSystemFontOfSize:11.0];
        NSDictionary* fontAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSColor blackColor], NSForegroundColorAttributeName,
                                   referenceFont, NSFontAttributeName, nil];

        NSSize reference = [self.header sizeWithAttributes:fontAttrs];
        
        NSPoint textPos = NSMakePoint(self.frame.origin.x + (self.frame.size.width - reference.width), self.frame.origin.y + (self.frame.size.height + 1));
        
        [self.header drawAtPoint:textPos withAttributes:fontAttrs];
    }
}

@end
