//
//  SMPriceCellValueTransformer.m
//  SmartExpense
//
//  Created by Marcos Tirao on 4/17/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMPriceCellValueTransformer.h"

@implementation SMPriceCellValueTransformer

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {
	
	NSNumberFormatter *inputFormatter = [[NSNumberFormatter alloc] init];
    [inputFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *price = [inputFormatter stringFromNumber:value];
	return price;
}


@end
