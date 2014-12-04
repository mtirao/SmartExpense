//
//  SMTile.m
//  SmartExpense
//
//  Created by Marcos Tirao on 6/2/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMTile.h"
#import "Utils.h"

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
        
        NSColor *foreground = [Utils controlColor];
        NSColor *background = [NSColor whiteColor];
        
        [background setFill];
        [foreground setStroke];
        
        NSBezierPath *tile = [NSBezierPath bezierPathWithRect:self.frame];
        tile.lineWidth = 1.5;
        [tile fill];
        [tile stroke];
        
        NSRect mark = NSMakeRect(self.frame.origin.x, self.frame.origin.y,
                                 5, self.frame.size.height);
        NSBezierPath *currentMark = [NSBezierPath bezierPathWithRect:mark];
        
        if (isCurrent) {
            
            [[Utils foregroundColor:0.5]set];
            [currentMark fill];
        }else {
            if(isSelected) {
                [[Utils foregroundColor2:0.5]set];
                [currentMark fill];

            }
        }
        
        
    
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
