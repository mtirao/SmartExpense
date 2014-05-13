//
//  SMListController.h
//  SmartExpense
//
//  Created by Marcos Tirao on 4/27/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMSmartListDelegate.h"

@interface SMListController : NSObject

@property (assign) IBOutlet SMAppDelegate *appDelegate;
@property (assign) IBOutlet SMSmartListDelegate *delegate;
@property (assign) IBOutlet NSArrayController* dataSource;
@property (assign) IBOutlet NSArrayController* dataDestination;

- (IBAction)addAction:sender;
- (IBAction)removeAction:sender;

@end
