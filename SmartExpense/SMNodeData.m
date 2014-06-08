//
//  SMNodeData.m
//  SmartExpense
//
//  Created by Marcos Tirao on 6/4/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMNodeData.h"

@implementation SMNodeData

@synthesize name, total;

-(id)init {
    self = [super init];
    self.name = @"Untitled";
    self.total = @"";
    self.container = YES;
    
    return self;
}

-(id)initWithName:(NSString*)aName {
    self = [self init];
    self.name = aName;
    return self;
}

+(SMNodeData*)nodeDataWithName: (NSString*)name {
    return [[SMNodeData alloc] initWithName:name];
}

@end
