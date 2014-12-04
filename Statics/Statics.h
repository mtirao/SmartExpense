//
//  Statics.h
//
//  Created by Marcos Tirao on 9/13/13.
//  Copyright (c) 2013 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Statics : NSObject {
    
}

@property (nonatomic, strong) NSDictionary* staticsData;
@property (nonatomic, strong) NSDictionary* axisText;
@property (nonatomic, strong) NSColor* backgroundColor;

@property (nonatomic, strong) NSArray* colors;

@property float max;
@property float min;

-(Statics*)initChartWithDictionary:(NSDictionary*)data;

-(void)drawChartInRect:(CGRect)frame withTitle:(NSString*)title;




@end
