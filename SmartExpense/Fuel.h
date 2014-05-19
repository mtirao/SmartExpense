//
//  Fuel.h
//  SmartExpense
//
//  Created by Marcos Tirao on 5/15/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Model;

@interface Fuel : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSNumber * autonomy;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * odometer;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * consolidated;
@property (nonatomic, retain) Model *model;

@end
