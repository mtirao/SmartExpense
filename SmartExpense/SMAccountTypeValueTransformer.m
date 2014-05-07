//
//  SMAccountTypeValueTransformer.m
//  SmartExpense
//
//  Created by Marcos Tirao on 4/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMAccountTypeValueTransformer.h"

@implementation SMAccountTypeValueTransformer


+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {
	
    NSArray *type = @[@"SA", @"CA", @"LA", @"CCA",@"IA"];
    
    return [type objectAtIndex:[value intValue]];
}


@end
