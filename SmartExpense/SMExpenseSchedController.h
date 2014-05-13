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
@property (weak, nonatomic) IBOutlet NSPopUpButton *expensesType;
@property (weak, nonatomic) IBOutlet NSPopUpButton *frequency;
@property (weak, nonatomic) IBOutlet NSPopUpButton *selectedAccount;
@property (weak, nonatomic) IBOutlet NSDatePicker *from;
@property (weak, nonatomic) IBOutlet NSDatePicker *to;
@property (weak, nonatomic) IBOutlet NSTextField *every;
@property (weak, nonatomic) IBOutlet NSTextField *total;
@property (weak, nonatomic) IBOutlet NSTextField *storename;

@property (assign) IBOutlet SMSmartMoneyDelegate *appDelegate;
@property (assign) IBOutlet NSArrayController* accounts;

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem;

- (IBAction)okAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)showAction:(id)sender;
@end
