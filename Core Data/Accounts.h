//
//  Accounts.h
//  SmartExpense
//
//  Created by Marcos Tirao on 5/30/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Banks, Expenses;

@interface Accounts : NSManagedObject

@property (nonatomic, retain) NSNumber * balance;
@property (nonatomic, retain) NSString * currencyname;
@property (nonatomic, retain) NSString * currencysymbol;
@property (nonatomic, retain) NSNumber * exchangeratio;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * routing;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) Banks *bank;
@property (nonatomic, retain) NSSet *expenses;
@end

@interface Accounts (CoreDataGeneratedAccessors)

- (void)addExpensesObject:(Expenses *)value;
- (void)removeExpensesObject:(Expenses *)value;
- (void)addExpenses:(NSSet *)values;
- (void)removeExpenses:(NSSet *)values;

@end
