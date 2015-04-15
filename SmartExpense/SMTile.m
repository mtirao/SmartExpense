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
        NSFont* referenceFont = [NSFont boldSystemFontOfSize:12.0];
        NSFont* dataFont = [NSFont boldSystemFontOfSize:9.0];
        
        NSDictionary* fontAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSColor blackColor], NSForegroundColorAttributeName,
                                   referenceFont, NSFontAttributeName, nil];
       
        
        NSDictionary* dataFontAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSColor blackColor], NSForegroundColorAttributeName,
                                   dataFont, NSFontAttributeName, nil];
        
        
        NSColor *foreground = [Utils controlColor];
        NSColor *background = [NSColor whiteColor];
        
        [background setFill];
        [foreground setStroke];
        
        NSBezierPath *tile = [NSBezierPath bezierPathWithRect:self.frame];
        tile.lineWidth = 1.5;
        [tile fill];
        [tile stroke];
        
        NSSize reference = [self.text sizeWithAttributes:fontAttrs];
        
        NSPoint textPos = NSMakePoint(self.frame.origin.x + (self.frame.size.width - reference.width-2), self.frame.origin.y + (self.frame.size.height - reference.height));
        
        
        NSRect mark = NSMakeRect(textPos.x-3, textPos.y - 2,
                                 reference.width+3, reference.height);
        
        
        NSBezierPath *currentMark = [NSBezierPath bezierPathWithRect:mark];
        
        if (isCurrent) {
            
            [[Utils controlColor]set];
            [currentMark fill];
            
            fontAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSColor whiteColor], NSForegroundColorAttributeName,
                                       referenceFont, NSFontAttributeName, nil];
            [self.text drawAtPoint:textPos withAttributes:fontAttrs];
            
        }else {
            if(isSelected) {
                [[Utils foregroundColor2:0.5]set];
                [currentMark fill];

            }
            
            fontAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSColor blackColor], NSForegroundColorAttributeName,
                         referenceFont, NSFontAttributeName, nil];
            [self.text drawAtPoint:textPos withAttributes:fontAttrs];

        }
        
        if(data != nil) {
            int i = 0;
            for(NSString * info in data) {
                if(i > 10) {
                    break;
                }
                NSRect infoLine = NSMakeRect(self.frame.origin.x + 6, (self.frame.origin.y-17) - (i*9), self.frame.size.width, self.frame.size.height);
                [info drawInRect: infoLine withAttributes:dataFontAttrs];
                i++;
            }
        }
        
    }else {
        NSColor *foreground = [Utils controlColor];
        NSColor *background = [NSColor whiteColor];
        
        [background setFill];
        [foreground setStroke];
        
        NSBezierPath *tile = [NSBezierPath bezierPathWithRect:self.frame];
        tile.lineWidth = 1.5;
        [tile fill];
        [tile stroke];
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
