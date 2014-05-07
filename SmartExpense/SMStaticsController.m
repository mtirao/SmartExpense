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

-(BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    
    if(moneyDelegate.mainWindow.isVisible) {
        return YES;
    }
    
    return NO;
}


#pragma mark ****** Action Method *******

-(IBAction)itemPrice:(id)sender {
    
}

-(IBAction)totalItem:(id)sender {
    
}

-(IBAction)totalExpense:(id)sender {
    
}

-(IBAction)futureTotalExpense:(id)sender {
    
}

-(IBAction)fuelConsumption:(id)sender {
    
}


@end
