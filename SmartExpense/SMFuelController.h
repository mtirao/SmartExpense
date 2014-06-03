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


@property (weak, nonatomic) IBOutlet SMSmartFuelDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet NSArrayController* dataSource;
@property (weak, nonatomic) IBOutlet NSArrayController* dataDestination;

- (IBAction)addAction:sender;
- (IBAction)removeAction:sender;

@end
