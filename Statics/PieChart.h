//
//  PieChart.h
//  SmartExpense
//
//  Created by Marcos Tirao on 5/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "Statics.h"

@interface PieChart : Statics {
@private
    float total;
    
    NSUInteger referenceSize;
}

-(Statics*)initPieChartWithDictionary:(NSDictionary*)data;


@end
