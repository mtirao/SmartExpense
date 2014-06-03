//
//  SMStaticsController.h
//  SmartExpense
//
//  Created by Marcos Tirao on 5/7/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMSmartMoneyDelegate.h"
#import "SMSmartListDelegate.h"
#import "SMSmartFuelDelegate.h"

@interface SMStaticsController : NSObject <NSTableViewDataSource>

@property (weak, nonatomic) IBOutlet SMSmartMoneyDelegate *moneyDelegate;
@property (weak, nonatomic) IBOutlet SMSmartListDelegate *listDelegate;
@property (weak, nonatomic) IBOutlet SMSmartFuelDelegate *fuelDelegate;

@property (weak, nonatomic) IBOutlet NSWindow *itemPricestaticsWindow;
@property (weak, nonatomic) IBOutlet NSDrawer *itemPricestaticDrawer;

@property (weak, nonatomic) IBOutlet NSWindow *totalItemstaticsWindow;
@property (weak, nonatomic) IBOutlet NSDrawer *totalItemstaticDrawer;

@property (weak, nonatomic) IBOutlet NSWindow *totalExpensestaticsWindow;
@property (weak, nonatomic) IBOutlet NSDrawer *totalExpensestaticDrawer;

@property (weak, nonatomic) IBOutlet NSWindow *futureTotalExpensestaticsWindow;
@property (weak, nonatomic) IBOutlet NSDrawer *futureTotalExpensestaticsDrawer;

@property (weak, nonatomic) IBOutlet NSWindow *fuelConsumptionstaticsWindow;
@property (weak, nonatomic) IBOutlet NSDrawer *fuelConsumptionstaticsDrawer;

@property (weak, nonatomic) IBOutlet NSArrayController* selectedItems;
@property (weak, nonatomic) IBOutlet NSArrayController* selectedModel;

@property (weak, nonatomic) IBOutlet NSTableView* inflationRateTable;
@property (weak, nonatomic) IBOutlet NSTableView* totalItemTable;
@property (weak, nonatomic) IBOutlet NSTableView* totalExpenseTable;

@property NSMutableDictionary* itemVariationData;
@property NSMutableArray* itemVariationRate;
@property NSDictionary* totalExpenseData;

@property NSDictionary* totalItemData;


-(IBAction)itemPrice:(id)sender;
-(IBAction)totalItem:(id)sender;
-(IBAction)totalExpense:(id)sender;
-(IBAction)futureTotalExpense:(id)sender;
-(IBAction)fuelConsumption:(id)sender;


-(IBAction)graphItem:(id)sender;


@end
