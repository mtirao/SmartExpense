//
//  Transfer.h
//  SmartExpense
//
//  Created by Marcos Tirao on 4/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Expenses;

@interface Transfer : NSManagedObject

@property (nonatomic, retain) NSString * bank;
@property (nonatomic, retain) NSString * owername;
@property (nonatomic, retain) NSString * ownerid;
@property (nonatomic, retain) NSString * ownermail;
@property (nonatomic, retain) NSString * ownerphone;
@property (nonatomic, retain) NSString * rountingnumber;
@property (nonatomic, retain) Expenses *expenses;

@end
