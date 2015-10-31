//
//  SMNodeData.h
//  SmartExpense
//
//  Created by Marcos Tirao on 6/4/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMNodeData : NSObject

@property (readwrite, copy) NSString *name;
@property (readwrite, copy) NSNumber *total;
@property (readwrite, retain) NSMutableArray *child;

-(id)init;
-(void)addChild:(SMNodeData*)child;



@end
