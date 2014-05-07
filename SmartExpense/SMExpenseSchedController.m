//
//  SMExpenseSchedController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/4/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMExpenseSchedController.h"

@implementation SMExpenseSchedController

@synthesize delegate;
@synthesize mainWindow;


- (IBAction)okAction:(id)sender {
    [NSApp endSheet:mainWindow];
    [mainWindow orderOut:sender];

}

- (IBAction)cancelAction:(id)sender {
    [NSApp endSheet:mainWindow];
    [mainWindow orderOut:sender];
}

- (IBAction)showAction:(id)sender {
    [NSApp beginSheet:mainWindow modalForWindow:delegate.mainWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    
    if(delegate.mainWindow.isVisible) {
        return YES;
    }
    
    return NO;
    
}

@end
