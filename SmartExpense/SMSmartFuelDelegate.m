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

@synthesize carModelWindow;
@synthesize fuelingWindow;
@synthesize selectedModel;
@synthesize delegate;

#pragma  ***** Delegate Methods *****

-(BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    return YES;
}

-(void)awakeFromNib {
    self.carModelWindow.backgroundColor = [NSColor whiteColor];
    self.fuelingWindow.backgroundColor = [NSColor whiteColor];
}

#pragma mark ***** Action Methods *****

- (IBAction)showCarModelWindow:(id)sender {
    [self.carModelWindow makeKeyAndOrderFront:sender];
    
    [self calculateInfo];
}

- (IBAction)showFuelingWindow:(id)sender {
    [self.fuelingWindow makeKeyAndOrderFront:sender];
    [self calculateInfo];
}

-(IBAction)modelSelection:(id)sender {
    [self calculateInfo];
}

#pragma mark **** Aux Methods ****


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
                distance += ABS(f.odometer.floatValue - previous.odometer.floatValue);
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


@end
