//
//  List.m
//  SmartExpense
//
//  Created by Marcos Tirao on 4/26/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "List.h"
#import "Items.h"
#import "Store.h"


@implementation List

@dynamic created;
@dynamic estimated;
@dynamic isdefault;
@dynamic name;
@dynamic purchased;
@dynamic total;
@dynamic items;
@dynamic store;

- (void) awakeFromInsert
{
    [super awakeFromInsert];
    [self setCreated:[NSDate date]];
    [self setPurchased:[NSDate date]];
}

@end
