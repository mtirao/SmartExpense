//
//  SMSmartMoneyDelegate.h
//  SmartExpense
//
//  Created by Marcos Tirao on 3/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMAppDelegate.h"

@interface SMSmartMoneyDelegate : NSObject<NSTabViewDelegate, NSTextFieldDelegate>


@property (weak, nonatomic) IBOutlet NSWindow* bankWindow;
@property (weak, nonatomic) IBOutlet NSWindow* accountWindow;
@property (weak, nonatomic) IBOutlet NSWindow* expenseWindow;


@property (weak, nonatomic) IBOutlet NSPanel* listPanel;
@property (weak, nonatomic) IBOutlet NSPanel* fuelPanel;
@property (weak, nonatomic) IBOutlet NSPopUpButton* expenseType;

@property (assign) IBOutlet NSArrayController *listEntity;
@property (assign) IBOutlet NSArrayController *modelEntity;
@property (assign) IBOutlet NSArrayController *selectedExpense;
@property (assign) IBOutlet NSArrayController *selectedAccount;
@property (assign) IBOutlet SMAppDelegate *delegate;

- (IBAction)showBankWindow:(id)sender;
- (IBAction)showAccountWindow:(id)sender;
- (IBAction)showExpenseWindow:(id)sender;
- (IBAction)showListInfo:(id)sender;
- (IBAction)selectType:(id)sender;


@end
