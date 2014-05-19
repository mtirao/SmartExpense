//
//  SMStaticView.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/7/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMStaticView.h"


@implementation SMStaticView

@synthesize itemVariation;


-(void)drawRect:(NSRect)dirtyRect {
    
    [itemVariation drawChartInRect:dirtyRect withTitle:nil];
    
}

-(void)setItemVariationData:(NSDictionary*)data {
    
    if(itemVariation == nil) {
        itemVariation = [[DotLine alloc]initDotLineCharWithDictionary:data];
    }else {
        itemVariation.staticsData = data;
    }
    
    
    
}

@end
