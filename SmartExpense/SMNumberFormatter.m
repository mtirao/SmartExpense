//
//  SMNumberFormatter.m
//  SmartExpense
//
//  Created by Marcos Tirao on 4/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMNumberFormatter.h"

@implementation SMNumberFormatter

+ (Class)transformedValueClass {
    return [NSNumber class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)transformedValue:(id)value {

    NSNumberFormatter *number = [[NSNumberFormatter alloc]init];
    [number setNumberStyle:NSNumberFormatterDecimalStyle];
    number.roundingMode = NSRoundUp;
    number.maximumFractionDigits = 2;
    
    if ([value isKindOfClass:[NSString class]]) {
        return [number numberFromString:value];
    }else if ([value isKindOfClass:[NSNumber class]]) {
        return [number stringFromNumber:value];
    }
    
    return value;
}


@end
