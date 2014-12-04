//
//  DotLine.h
//  SmartExpense
//
//  Created by Marcos Tirao on 5/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "Statics.h"

@interface DotLine : Statics {
}


@property (readonly) float count;

-(Statics*)initDotLineCharWithDictionary:(NSDictionary*)data;

@end
