//
//  SMNodeData.m
//  SmartExpense
//
//  Created by Marcos Tirao on 6/4/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMNodeData.h"

@implementation SMNodeData

@synthesize name, child;

-(id)init {
    child = [[NSMutableArray alloc]init];
    return self;
}

-(void)addChild:(SMNodeData*)aChild {
    [self.child addObject:aChild];
}


@end
