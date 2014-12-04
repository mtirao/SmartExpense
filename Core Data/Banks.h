//
//  Banks.h
//  SmartExpense
//
//  Created by Marcos Tirao on 4/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Accounts;

@interface Banks : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSSet *accounts;
@end

@interface Banks (CoreDataGeneratedAccessors)

- (void)addAccountsObject:(Accounts *)value;
- (void)removeAccountsObject:(Accounts *)value;
- (void)addAccounts:(NSSet *)values;
- (void)removeAccounts:(NSSet *)values;

@end
