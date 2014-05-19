//
//  SMMergeListController.h
//  SmartExpense
//
//  Created by Marcos Tirao on 5/16/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SMSmartListDelegate.h"

@interface SMMergeListController : NSObject  <NSTableViewDataSource>

@property (weak, nonatomic) IBOutlet NSArrayController* dataSource;
@property (weak, nonatomic) IBOutlet SMSmartListDelegate* delegate;
@property (weak, nonatomic) IBOutlet NSPanel* mergePanel;
@property (weak, nonatomic) IBOutlet NSTableView* tableView;

@property NSArray* mergeData;

-(IBAction)showMergePanel:(id)sender;
-(IBAction)okMergePanel:(id)sender;
-(IBAction)cancelMergePanel:(id)sender;

@end
