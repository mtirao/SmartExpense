//
//  SMTuple.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMTuple.h"

@implementation SMTuple

@synthesize first, second;

+(SMTuple*)tupleWithFirst:(id)f second:(id)s {
    SMTuple* tuple = [[SMTuple alloc] init];
    
    tuple.first = [f copy];
    tuple.second = [s copy];
    
    return tuple;
}

@end
