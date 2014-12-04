//
//  SMCurrencyValueTransformer.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/30/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMCurrencyValueTransformer.h"
#import "Accounts.h"
#import "SMAppDelegate.h"

@implementation SMCurrencyValueTransformer

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {
	
    NSApplication *app = [NSApplication sharedApplication];
    SMAppDelegate* delegate = (SMAppDelegate*)[app delegate];
    
    NSNumberFormatter *number = [[NSNumberFormatter alloc]init];
    [number setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    Accounts* account;
    NSArray* selectedAccount = delegate.currentAccount.selectedObjects;
    
    
    if (selectedAccount != nil && selectedAccount.count > 0) {
        account = [selectedAccount objectAtIndex:0];
        NSString* symbol = [account.currencysymbol stringByAppendingString:@" "];
        number.currencySymbol = symbol;
    }
    
   
    return [number stringFromNumber:value];

}


@end
