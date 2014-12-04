//
//  Model.h
//  SmartExpense
//
//  Created by Marcos Tirao on 4/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fuel;

@interface Model : NSManagedObject

@property (nonatomic, retain) NSNumber * city;
@property (nonatomic, retain) NSNumber * highway;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *fuel;
@end

@interface Model (CoreDataGeneratedAccessors)

- (void)addFuelObject:(Fuel *)value;
- (void)removeFuelObject:(Fuel *)value;
- (void)addFuel:(NSSet *)values;
- (void)removeFuel:(NSSet *)values;

@end
