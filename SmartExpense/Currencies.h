//
//  Currencies.h
//  SmartExpense
//
//  Created by Marcos Tirao on 4/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Accounts;

@interface Currencies : NSManagedObject

@property (nonatomic, retain) NSNumber * exchangeratio;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * symbol;
@property (nonatomic, retain) Accounts *accounts;

@end
