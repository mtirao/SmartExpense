//
//  Utils.m
//  EasyPlanner
//
//  Created by Marcos Tirao on 12/1/14.
//  Copyright (c) 2014 ArgSoft Solutions, inc. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(NSColor*)foregroundColor {
    return [NSColor colorWithCalibratedRed:0.145 green:0.662 blue:0.513 alpha:1.0];
}


+(NSColor*)foregroundColor:(float)alpha {
    return [NSColor colorWithCalibratedRed:0.145 green:0.662 blue:0.513 alpha:alpha];
}


+(NSColor*)foregroundColor2 {
    return [NSColor colorWithCalibratedRed:0.611 green:0.803 blue:0.231 alpha:1.0];
}

+(NSColor*)foregroundColor2:(float)alpha {
    return [NSColor colorWithCalibratedRed:0.611 green:0.803 blue:0.231 alpha:alpha];
}

+(NSColor*)controlColor {
    return [NSColor colorWithCalibratedRed:0.796 green:0.058 blue:0.192 alpha:1.0];
}

+(NSColor*)controlColor:(float)alpha {
    return [NSColor colorWithCalibratedRed:0.796 green:0.058 blue:0.192 alpha:alpha];
}



@end
