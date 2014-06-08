//
//  SMSmartListDelegate.h
//  SmartExpense
//
//  Created by Marcos Tirao on 3/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMAppDelegate.h"

@interface SMSmartListDelegate : NSObject

@property (assign) IBOutlet SMAppDelegate* delegate;
@property (assign) IBOutlet NSArrayController* dataSource;


@property (weak, nonatomic) IBOutlet NSWindow* storeWindow;
@property (weak, nonatomic) IBOutlet NSWindow* listWindow;
@property (weak, nonatomic) IBOutlet NSWindow* atTheStoreWindow;



-(IBAction)addDefaultList:(id)sender;

-(IBAction)showListWindow:(id)sender;
-(IBAction)showStoreWindow:(id)sender;
-(IBAction)showAtTheStoreWindow:(id)sender;

@end
