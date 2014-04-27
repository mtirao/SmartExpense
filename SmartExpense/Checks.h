//
//  Checks.h
//  SmartExpense
//
//  Created by Marcos Tirao on 4/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Expenses;

@interface Checks : NSManagedObject

@property (nonatomic, retain) NSString * bank;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * ownername;
@property (nonatomic, retain) Expenses *expenses;

@end
