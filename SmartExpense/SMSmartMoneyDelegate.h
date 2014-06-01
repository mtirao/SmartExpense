//
//  SMSmartMoneyDelegate.h
//  SmartExpense
//
//  Created by Marcos Tirao on 3/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMAppDelegate.h"

@interface SMSmartMoneyDelegate : NSObject<NSTabViewDelegate>


@property (weak, nonatomic) IBOutlet NSWindow* mainWindow;
@property (weak, nonatomic) IBOutlet NSPanel* listPanel;
@property (weak, nonatomic) IBOutlet NSPanel* fuelPanel;
@property (weak, nonatomic) IBOutlet NSPopUpButton* expenseType;
@property (weak, nonatomic) IBOutlet NSTabView *mainTabs;

@property (assign) IBOutlet NSArrayController *listEntity;
@property (assign) IBOutlet NSArrayController *modelEntity;
@property (assign) IBOutlet NSArrayController *selectedExpense;
@property (assign) IBOutlet NSArrayController *selectedAccount;
@property (assign) IBOutlet SMAppDelegate *delegate;

- (IBAction)showWindow:(id)sender;
- (IBAction)showListInfo:(id)sender;
- (IBAction)okListInfo:(id)sender;
- (IBAction)cancelListInfo:(id)sender;

@end
