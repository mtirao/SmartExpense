//
//  SMExpenseSchedController.h
//  SmartExpense
//
//  Created by Marcos Tirao on 5/4/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMSmartMoneyDelegate.h"

@interface SMExpenseSchedController : NSObject

@property (weak, nonatomic) IBOutlet NSPanel * mainWindow;
@property (assign) IBOutlet SMSmartMoneyDelegate *delegate;


- (BOOL)validateMenuItem:(NSMenuItem *)menuItem;

- (IBAction)okAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)showAction:(id)sender;
@end
