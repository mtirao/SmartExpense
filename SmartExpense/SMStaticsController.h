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

@interface SMStaticsController : NSObject

@property (assign) IBOutlet SMSmartMoneyDelegate *moneyDelegate;
@property (assign) IBOutlet SMSmartListDelegate *listDelegate;
@property (assign) IBOutlet SMSmartFuelDelegate *fuelDelegate;

@property (weak, nonatomic) IBOutlet NSWindow *itemPricestaticsWindow;
@property (weak, nonatomic) IBOutlet NSArrayController* selectedItems;

@property (weak, nonatomic) IBOutlet NSPanel *itemPanel;
@property (weak, nonatomic) IBOutlet NSButton *withIntervalRadio;
@property (weak, nonatomic) IBOutlet NSButton *allItemRadio;

@property NSMutableDictionary* itemVariatonData;

-(IBAction)itemPrice:(id)sender;
-(IBAction)totalItem:(id)sender;
-(IBAction)totalExpense:(id)sender;
-(IBAction)futureTotalExpense:(id)sender;
-(IBAction)fuelConsumption:(id)sender;


-(IBAction)graphItem:(id)sender;

-(IBAction)radioSelected:(id)sender;

@end
