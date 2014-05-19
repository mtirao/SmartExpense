//
//  SMStaticsController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/7/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMStaticsController.h"
#import "SMStaticView.h"
#import "Items.h"
#import "SMTuple.h"

@implementation SMStaticsController

@synthesize moneyDelegate, listDelegate, fuelDelegate;
@synthesize itemPricestaticsWindow;
@synthesize itemPanel;
@synthesize withIntervalRadio, allItemRadio;
@synthesize selectedItems;
@synthesize itemVariatonData;

enum{ITEM_VARIATION_BUTTON};

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
    
    NSButton* button = (NSButton*)sender;
    
    NSInteger tag = button.tag;
    switch (tag) {
        case ITEM_VARIATION_BUTTON:
            [self itemPriceVariationData];
            [self.itemPricestaticsWindow makeKeyAndOrderFront:sender];
            break;
        default:
            break;
    }
    
    
}

-(IBAction)resetGraph:(id)sender {
    
    NSButton* button = (NSButton*)sender;
    NSInteger tag = button.tag;
    switch (tag) {
        case ITEM_VARIATION_BUTTON:
            
            break;
        default:
            break;
    }

    
}


-(IBAction)radioSelected:(id)sender {
    
    [withIntervalRadio setState:NSOffState];
    [allItemRadio setState:NSOffState];
    
    NSButton *radio = (NSButton*)sender;
    [radio setState:NSOnState];
    
}

#pragma mark ***** Aux Method *****


-(void)itemPriceVariationData {
    
    SMStaticView* view = [self.itemPricestaticsWindow contentView];
    
    NSArray* itm = [selectedItems selectedObjects];
    
    if (itm != nil && itm.count > 0) {
        
        Items* i = [itm objectAtIndex:0];
        
        NSArray* data = [self itemsByName:i.name];
        
        if (itemVariatonData == nil) {
            itemVariatonData = [[NSMutableDictionary alloc]init];
        }
        
        for(Items *j in data) {
            
            NSMutableArray* points = [itemVariatonData objectForKey:j.name];
            if(points != nil) {
                [points addObject:[SMTuple tupleWithFirst:[NSNumber numberWithDouble:j.price.floatValue * j.quantity.floatValue] second:j.date]];
            }else {
                points = [[NSMutableArray alloc]init];
                [points addObject:[SMTuple tupleWithFirst:[NSNumber numberWithDouble:j.price.floatValue * j.quantity.floatValue] second:j.date]];
                [itemVariatonData setObject:points forKey:j.name];
            }
            
        }
        
        [view setItemVariationData:[NSDictionary dictionaryWithDictionary:itemVariatonData]];
        [view setNeedsDisplay:YES];
        
    }
}

-(NSArray*)itemsByName:(NSString*)name {
    
    NSManagedObjectContext* managedObjectContext = self.moneyDelegate.delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name == %@)", name];
    
    [fetchRequest setPredicate:predicate];
    
    NSError* error;
    NSArray* d = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(d == nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }

    return d;
    
}

@end
