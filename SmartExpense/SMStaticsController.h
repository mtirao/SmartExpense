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



-(IBAction)itemPrice:(id)sender;
-(IBAction)totalItem:(id)sender;
-(IBAction)totalExpense:(id)sender;
-(IBAction)futureTotalExpense:(id)sender;
-(IBAction)fuelConsumption:(id)sender;

@end
