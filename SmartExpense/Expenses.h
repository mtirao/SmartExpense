//
//  Expenses.h
//  SmartExpense
//
//  Created by Marcos Tirao on 4/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Accounts, Checks, Transfer;

@interface Expenses : NSManagedObject

@property (nonatomic, retain) NSDate * due;
@property (nonatomic, retain) NSString * storename;
@property (nonatomic, retain) NSNumber * total;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Accounts *account;
@property (nonatomic, retain) Checks *check;
@property (nonatomic, retain) Transfer *transfer;

@end
