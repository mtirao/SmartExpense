//
//  SMDateFormatter.m
//  SmartExpense
//
//  Created by Marcos Tirao on 4/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMDateFormatter.h"

@implementation SMDateFormatter

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {
	
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateStyle:NSDateFormatterShortStyle];
    NSString *date = [inputFormatter stringFromDate:value];
	return date;
}


@end
