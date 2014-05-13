//
//  SMStaticsController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/7/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMStaticsController.h"

@implementation SMStaticsController

@synthesize moneyDelegate, listDelegate, fuelDelegate;
@synthesize staticsView, staticsWindow;
@synthesize itemPanel;
@synthesize withIntervalRadio, allItemRadio;

-(BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    
    if(moneyDelegate.mainWindow.isVisible) {
        return YES;
    }
    
    return NO;
}


#pragma mark ****** Action Method *******

-(IBAction)itemPrice:(id)sender {
    [itemPanel makeKeyAndOrderFront:sender];
}

-(IBAction)totalItem:(id)sender {
    
}

-(IBAction)totalExpense:(id)sender {
    
}

-(IBAction)futureTotalExpense:(id)sender {
    
}

-(IBAction)fuelConsumption:(id)sender {
    
}

-(IBAction)graphItem:(id)sender {
    
}

-(IBAction)radioSelected:(id)sender {
    
    [withIntervalRadio setState:NSOffState];
    [allItemRadio setState:NSOffState];
    
    NSButton *radio = (NSButton*)sender;
    [radio setState:NSOnState];
    
}



@end
