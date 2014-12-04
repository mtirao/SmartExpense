//
//  DispersionChart.h
//  SmartExpense
//
//  Created by Marcos Tirao on 5/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "Statics.h"

@interface DispersionChart : Statics {
@private
    float total;
}

@property (nonatomic, strong) NSArray* auxData;


-(DispersionChart*)initDispersionChartWithDictionary:(NSDictionary*)data dispertionBand:(NSArray*)bands;


@end
