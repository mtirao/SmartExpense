//
//  SMStaticView.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/7/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMStaticView.h"


@implementation SMStaticView

@synthesize itemVariation, totalItem, totalExpense, futureTotalExpense;
@synthesize type;

-(void)drawRect:(NSRect)dirtyRect {
    
    switch (self.type) {
        case 0:
            [self.itemVariation drawChartInRect:dirtyRect withTitle:nil];
            break;
        case 1:
            [self.totalItem drawChartInRect:dirtyRect withTitle:nil];
            break;
        case 2:
            [self.totalExpense drawChartInRect:dirtyRect withTitle:nil];
            break;
        case 3:
            [self.futureTotalExpense drawChartInRect:dirtyRect withTitle:nil];
            break;
        case 4:
            [self.fuelConsumption drawChartInRect:dirtyRect withTitle:nil];
            break;
        default:
            break;
    }
    
}

-(void)setItemVariationData:(NSDictionary*)data {
    
    self.type = 0;
    self.itemVariation = [[DotLine alloc]initDotLineCharWithDictionary:data];
    self.itemVariation.backgroundColor = [NSColor whiteColor];
}

-(void)setTotalItemData:(NSDictionary*)data {
    
    self.type = 1;
    self.totalItem = [[PieChart alloc]initPieChartWithDictionary:data];
    self.totalItem.backgroundColor = [NSColor whiteColor];
}

-(void)setTotalExpenseData:(NSDictionary*)data {
    self.type = 2;
    self.totalExpense= [[PieChart alloc]initPieChartWithDictionary:data];
    self.totalExpense.backgroundColor = [NSColor whiteColor];
}

-(void)setFutureTotalExpenseData:(NSDictionary*)data {
    self.type = 3;
    self.futureTotalExpense = [[PieChart alloc]initPieChartWithDictionary:data];
    self.futureTotalExpense.backgroundColor = [NSColor whiteColor];
}

-(void)setFuelConsumptionData:(NSDictionary*)data bands:(NSArray*)disp {
    self.type = 4;
    self.fuelConsumption = [[DispersionChart alloc]initDispersionChartWithDictionary:data dispertionBand:disp];
    self.fuelConsumption.backgroundColor = [NSColor whiteColor];
}

@end
