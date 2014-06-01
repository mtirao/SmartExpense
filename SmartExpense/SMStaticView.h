//
//  SMStaticView.h
//  SmartExpense
//
//  Created by Marcos Tirao on 5/7/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Statics.h"
#import "DotLine.h"
#import "PieChart.h"
#import "DispersionChart.h"

@interface SMStaticView : NSView

@property NSInteger type;
@property Statics* itemVariation;
@property Statics* totalItem;
@property Statics* totalExpense;
@property Statics* futureTotalExpense;
@property Statics* fuelConsumption;



-(void)setItemVariationData:(NSDictionary*)data;
-(void)setTotalItemData:(NSDictionary*)data;
-(void)setTotalExpenseData:(NSDictionary*)data;
-(void)setFutureTotalExpenseData:(NSDictionary*)data;
-(void)setFuelConsumptionData:(NSDictionary*)data bands:(NSArray*)disp;

@end
