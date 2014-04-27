//
//  SMFuelController.h
//  SmartExpense
//
//  Created by Marcos Tirao on 4/18/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMSmartFuelDelegate.h"

@interface SMFuelController : NSObject


@property (assign) IBOutlet SMSmartFuelDelegate *appDelegate;
@property (assign) IBOutlet NSArrayController* dataSource;
@property (assign) IBOutlet NSArrayController* dataDestination;

- (IBAction)addAction:sender;
- (IBAction)removeAction:sender;

@end
