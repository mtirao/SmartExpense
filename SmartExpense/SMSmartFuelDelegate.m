//
//  SMSmartFuelDelegate.m
//  SmartExpense
//
//  Created by Marcos Tirao on 3/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMSmartFuelDelegate.h"
#import "Fuel.h"
#import "Model.h"

@implementation SMSmartFuelDelegate

@synthesize mainWindow;
@synthesize graphView;
@synthesize selectedModel;
@synthesize delegate;


#pragma mark - Application's Action


- (void)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

-(void)calculateInfo {
    NSArray* data = [selectedModel arrangedObjects];
    
    float amount = 0.0;
    float money = 0.0;
    float distance = 0.0;
    
    if(data != nil) {
        Fuel* previous = nil;
        for(Fuel* f in data) {
            amount += f.amount.floatValue;
            money += f.price.floatValue * f.amount.floatValue;
            if (previous != nil) {
                distance += abs(f.odometer.floatValue - previous.odometer.floatValue);
            }
            previous = f;
        }
    }
    
    NSNumberFormatter *inputFormatter = [[NSNumberFormatter alloc] init];
    [inputFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    self.money.stringValue = [inputFormatter stringFromNumber:[NSNumber numberWithFloat:money]];
    
    NSNumberFormatter *number = [[NSNumberFormatter alloc]init];
    [number setNumberStyle:NSNumberFormatterDecimalStyle];

    self.amount.stringValue = [number stringFromNumber:[NSNumber numberWithFloat:amount]];
    self.distance.stringValue = [number stringFromNumber:[NSNumber numberWithFloat:distance]];
    
}


-(IBAction)showWindow:(id)sender {
    [mainWindow makeKeyAndOrderFront:sender];
    
    [self calculateInfo];
}

- (IBAction)dispersionGraph:(id)sender {
    
}

-(IBAction)modelSelection:(id)sender {
    [self calculateInfo];
}

@end
