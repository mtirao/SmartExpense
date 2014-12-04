//
//  SMItemsArrayController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/16/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMItemsArrayController.h"
#import "Items.h"


@implementation SMItemsArrayController


//Return an array with no item duplicate

-(NSArray*)arrangeObjects:(NSArray *)objects {
    
    NSMutableDictionary * obj = [[NSMutableDictionary alloc]init];
    
    for (Items* itm in objects){
        Items* i = [obj objectForKey:itm.name];
        if (i == nil && itm.price.floatValue != 0) {
            [obj setObject:itm forKey:itm.name];
        }
    }
    
    return [obj allValues];
}

@end
