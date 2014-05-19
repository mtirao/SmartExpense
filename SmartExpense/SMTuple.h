//
//  SMTuple.h
//  SmartExpense
//
//  Created by Marcos Tirao on 5/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SMTuple : NSObject

@property id first;
@property id second;

+(SMTuple*)tupleWithFirst:(id)f second:(id)s;

@end
