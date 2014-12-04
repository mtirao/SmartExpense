//
//  List.h
//  SmartExpense
//
//  Created by Marcos Tirao on 4/26/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Items, Store;

@interface List : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * estimated;
@property (nonatomic, retain) NSNumber * isdefault;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * purchased;
@property (nonatomic, retain) NSNumber * total;
@property (nonatomic, retain) NSSet *items;
@property (nonatomic, retain) Store *store;
@end

@interface List (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Items *)value;
- (void)removeItemsObject:(Items *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
