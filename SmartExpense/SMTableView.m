//
//  SMTableRowView.m
//  SmartExpense
//
//  Created by Marcos Tirao on 6/4/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMTableView.h"
#import "SMTableRowView.h"

@implementation SMTableView

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    return [[SMTableRowView alloc]init];
}


@end
