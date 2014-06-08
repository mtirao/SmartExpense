//
//  SMSmartFuelDelegate.h
//  SmartExpense
//
//  Created by Marcos Tirao on 3/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMFuelGraphView.h"
#import "SMAppDelegate.h"

@interface SMSmartFuelDelegate : NSObject<NSControlTextEditingDelegate>

@property (weak, nonatomic) IBOutlet NSWindow* carModelWindow;
@property (weak, nonatomic) IBOutlet NSWindow* fuelingWindow;

@property (weak, nonatomic) IBOutlet NSTextField* distance;
@property (weak, nonatomic) IBOutlet NSTextField* amount;
@property (weak, nonatomic) IBOutlet NSTextField* money;
@property (weak, nonatomic) IBOutlet NSArrayController* selectedModel;
@property (weak, nonatomic) IBOutlet SMAppDelegate* delegate;


- (IBAction)showCarModelWindow:(id)sender;
- (IBAction)showFuelingWindow:(id)sender;
- (IBAction)modelSelection:(id)sender;

@end
