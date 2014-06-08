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
@property (readwrite, copy) NSString *total;
@property(readwrite, getter=isContainer) BOOL container;

-(id)initWithName:(NSString*)name;
+(SMNodeData*)nodeDataWithName: (NSString*)name;


@end
