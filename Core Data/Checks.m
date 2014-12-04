//
//  Checks.m
//  SmartExpense
//
//  Created by Marcos Tirao on 4/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "Checks.h"
#import "Expenses.h"


@implementation Checks

@dynamic bank;
@dynamic date;
@dynamic number;
@dynamic ownername;
@dynamic expenses;

- (void) awakeFromInsert
{
    [super awakeFromInsert];
    [self setDate:[NSDate date]];
}

@end
