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

@interface SMStaticView : NSView

@property Statics* itemVariation;

-(void)setItemVariationData:(NSDictionary*)data;

@end
