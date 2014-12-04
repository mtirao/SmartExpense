//
//  CustomizedTableView.m
//  EasyPlanner
//
//  Created by Marcos Tirao on 7/11/14.
//  Copyright (c) 2014 ArgSoft Solutions, inc. All rights reserved.
//

#import "CustomizedTableView.h"
#import "Utils.h"

@implementation CustomizedTableView

- (void)drawRow:(NSInteger)row clipRect:(NSRect)clipRect
{
    NSColor* bgColor = Nil;
    
    if ([[self window] isKeyWindow]) {
        bgColor = [Utils controlColor]; // [NSColor colorWithCalibratedRed:0.058 green:0.831 blue:0.752 alpha:1.000];
    }
    else {
        bgColor = [Utils controlColor:0.3]; //[NSColor colorWithCalibratedRed:0.058 green:0.831 blue:0.752 alpha:0.3];
    }
    
    NSIndexSet* selectedRowIndexes = [self selectedRowIndexes];
    if ([selectedRowIndexes containsIndex:row])
    {
        NSBezierPath *path = [NSBezierPath bezierPathWithRect:[self rectOfRow:row]];
        [bgColor set];
        [path setLineWidth:2.0];
        [path fill];
    }
    [super drawRow:row clipRect:clipRect];
}

-(NSFocusRingType)focusRingType {
    return NSFocusRingTypeNone;
}

@end
