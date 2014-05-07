//
//  SMExpenseController.h
//  SmartExpense
//
//  Created by Marcos Tirao on 5/1/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMSmartMoneyDelegate.h"

@interface SMExpenseController : NSObject

@property (assign) IBOutlet SMSmartMoneyDelegate *appDelegate;
@property (assign) IBOutlet NSArrayController* dataSource;
@property (assign) IBOutlet NSArrayController* dataDestination;

- (IBAction)addAction:sender;
- (IBAction)removeAction:sender;


@end
