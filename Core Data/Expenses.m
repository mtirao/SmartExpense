//
//  Expenses.m
//  SmartExpense
//
//  Created by Marcos Tirao on 4/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "Expenses.h"
#import "Accounts.h"
#import "Checks.h"
#import "Transfer.h"


@implementation Expenses

@dynamic due;
@dynamic storename;
@dynamic total;
@dynamic type;
@dynamic account;
@dynamic check;
@dynamic transfer;

- (void) awakeFromInsert
{
    [super awakeFromInsert];
    [self setDue:[NSDate date]];
}

@end
