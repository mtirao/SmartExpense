//
//  SMTile.h
//  SmartExpense
//
//  Created by Marcos Tirao on 6/2/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMTile : NSObject

@property (readonly) NSRect frame;
@property (copy, nonatomic) NSArray* data;
@property (copy, nonatomic) NSString* text;
@property (copy, nonatomic) NSString* header;
@property  BOOL isSelected;
@property BOOL isCurrent;

-(SMTile*)initWithRect:(NSRect)r;
-(void)drawTile;

@end
