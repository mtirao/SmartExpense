//
//  SMTableRowView.m
//  SmartExpense
//
//  Created by Marcos Tirao on 6/4/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMTableRowView.h"

@implementation SMTableRowView

- (void)drawSelectionInRect:(NSRect)dirtyRect {
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone) {
        NSRect selectionRect = NSInsetRect(self.bounds, 2.5, 2.5);
        
        [[NSColor colorWithRed:0.058 green:0.831 blue:0.749 alpha:1.0]setStroke];
        [[NSColor colorWithRed:0.058 green:0.831 blue:0.749 alpha:0.1]setFill];
        
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:6 yRadius:6];
        [selectionPath fill];
        [selectionPath stroke];
    }
}


@end
