//
//  SMFinancialStatusController.h
//  SmartExpense
//
//  Created by Marcos Tirao on 6/4/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMAppDelegate.h"
#import "SMNodeData.h"

@interface SMFinancialStatusController : NSObject<NSOutlineViewDataSource>

@property (weak, nonatomic) IBOutlet SMAppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet NSWindow *mainWindow;
@property (weak, nonatomic) IBOutlet NSOutlineView *outlineView;

@property (strong, nonatomic) NSTreeNode *datasource;
@property (strong, nonatomic) NSMutableDictionary *totals;

-(IBAction)showWindow:(id)sender;

@end
