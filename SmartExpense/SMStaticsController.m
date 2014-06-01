//
//  SMStaticsController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/7/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMCurrencyValueTransformer.h"
#import "SMStaticsController.h"
#import "SMStaticView.h"
#import "Items.h"
#import "List.h"
#import "Expenses.h"
#import "Model.h"
#import "Fuel.h"
#import "SMTuple.h"

@implementation SMStaticsController

@synthesize moneyDelegate, listDelegate, fuelDelegate;
@synthesize itemPricestaticsWindow, itemPricestaticDrawer;
@synthesize totalItemstaticsWindow, totalItemstaticDrawer;
@synthesize totalExpensestaticsWindow, totalExpensestaticDrawer;
@synthesize futureTotalExpensestaticsWindow, futureTotalExpensestaticsDrawer;
@synthesize fuelConsumptionstaticsWindow, fuelConsumptionstaticsDrawer;

@synthesize selectedItems;
@synthesize selectedModel;
@synthesize itemVariationData;
@synthesize itemVariationRate;
@synthesize totalItemData;
@synthesize totalItemTable;
@synthesize inflationRateTable;
@synthesize totalExpenseData;

enum{ITEM_VARIATION_BUTTON, TOTAL_ITEM_BUTTON, TOTAL_EXPENSE_BUTTON, FUTURE_TOTAL_EXPENSE_BUTTON, FUEL_CONSUMPTION_BUTTON};

-(BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    
    if(menuItem.tag == 6 && fuelDelegate.mainWindow.isKeyWindow) {
        return YES;
    }
    
    if( (menuItem.tag == 4 || menuItem.tag == 5) && moneyDelegate.mainWindow.isKeyWindow) {
        return YES;
    }
    
    if( (menuItem.tag == 2 || menuItem.tag == 3) && listDelegate.mainWindow.isKeyWindow) {
        return YES;
    }
    
    if(menuItem.tag == 1 && itemPricestaticsWindow.isKeyWindow) {
        menuItem.title = @"Toggle Item Price Drawer";
        return YES;
    }else if(menuItem.tag == 1) {
        menuItem.title = @"Toggle Drawer";
    }
    
    return NO;
}

- (void)awakeFromNib {
    [self.itemPricestaticDrawer setMinContentSize:NSMakeSize(252, 426)];
    [self.itemPricestaticDrawer setMaxContentSize:NSMakeSize(252, 426)];
    
    [self.totalItemstaticDrawer setMinContentSize:NSMakeSize(236, 142)];
    [self.totalItemstaticDrawer setMaxContentSize:NSMakeSize(236, 142)];
    
}

#pragma mark ***** Table View DataSoruce Protocol Methods *****

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    
    switch (aTableView.tag) {
        case 0:   //Item Variation Report Drawer Table
            if(self.itemVariationRate != nil) {
                return self.itemVariationRate.count;
            }else {
                return 0;
            }
            break;
        case 1: //Total item Report Drawer Table
            if(self.totalItemData != nil) {
                return self.totalItemData.allValues.count;
            }else {
                return 0;
            }
            break;
        case 2: //Total Expense Drawer Table
            if (self.totalExpenseData != nil) {
                return self.totalExpenseData.allValues.count;
            }else {
                return 0;
            }
            break;
        default:
            return 0;
            break;
    }
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    
    
    NSString *header = [aTableColumn.headerCell stringValue];
    
    switch (aTableView.tag) {
        case 0:   //Item Variation Report Drawer Table
            if([header isEqualToString:@"Name"]) {
                SMTuple *tuple = [self.itemVariationRate objectAtIndex:rowIndex];
                return tuple.first;
            }else {
                SMTuple *tuple = [self.itemVariationRate objectAtIndex:rowIndex];
                NSNumberFormatter *porcentual = [[NSNumberFormatter alloc]init];
                [porcentual setNumberStyle:NSNumberFormatterPercentStyle];
                return [porcentual stringFromNumber:tuple.second];
            }
            break;
        case 1: //Total item Report Drawer Table
            if([header isEqualToString:@"Name"]) {
                return [self.totalItemData.allKeys objectAtIndex:rowIndex];
            }else {
                
                SMCurrencyValueTransformer* currency = [[SMCurrencyValueTransformer alloc]init];
                
                NSNumber *amount = [self.totalItemData.allValues objectAtIndex:rowIndex];
                return [currency transformedValue:amount];
            }
        case 2: //Total Expense Report Drawer Table
            if([header isEqualToString:@"Category"]) {
                return [self.totalExpenseData.allKeys objectAtIndex:rowIndex];
            }else {
                SMCurrencyValueTransformer* currency = [[SMCurrencyValueTransformer alloc]init];
                NSNumber *amount = [self.totalExpenseData.allValues objectAtIndex:rowIndex];
                return [currency transformedValue:amount];
            }
            break;
    }
    
    return nil;
}



#pragma mark ****** Action Method *******

-(IBAction)openDrawer:(id)sender {
    if(itemPricestaticsWindow.isKeyWindow) {
        [itemPricestaticDrawer toggle:sender];
    }
}

-(IBAction)itemPrice:(id)sender {
    [self.itemPricestaticsWindow makeKeyAndOrderFront:sender];
    [self.itemPricestaticDrawer open];
}

-(IBAction)totalItem:(id)sender {
    [self.totalItemstaticsWindow makeKeyAndOrderFront:sender];
    [self.totalItemstaticDrawer open];
}

-(IBAction)totalExpense:(id)sender {
    [self.totalExpensestaticsWindow makeKeyAndOrderFront:sender];
    [self.totalExpensestaticDrawer open];
}

-(IBAction)futureTotalExpense:(id)sender {
    [self.futureTotalExpensestaticsWindow makeKeyAndOrderFront:sender];
    [self.futureTotalExpensestaticsDrawer open];
}

-(IBAction)fuelConsumption:(id)sender {
    [self.fuelConsumptionstaticsWindow makeKeyAndOrderFront:sender];
    [self.fuelConsumptionstaticsDrawer open];
}

-(IBAction)graphItem:(id)sender {
    
    NSButton* button = (NSButton*)sender;
    
    NSInteger tag = button.tag;
    switch (tag) {
        case ITEM_VARIATION_BUTTON:
            [self itemPriceVariationData];
            [self.itemPricestaticsWindow makeKeyAndOrderFront:sender];
            [self.inflationRateTable reloadData];
            break;
        case TOTAL_ITEM_BUTTON:
            [self generateTotalItemData];
            [self.totalItemstaticsWindow makeKeyAndOrderFront:sender];
            [self.totalItemTable reloadData];
            break;
        case TOTAL_EXPENSE_BUTTON:
            [self generateTotalExpenseData];
            [self.totalExpensestaticsWindow makeKeyAndOrderFront:sender];
            [self.totalExpenseTable reloadData];
            break;
        case FUTURE_TOTAL_EXPENSE_BUTTON:
            [self futureTotalExpenseData];
            [self.futureTotalExpensestaticsWindow makeKeyAndOrderFront:sender];
            break;
        case FUEL_CONSUMPTION_BUTTON:
            [self fuelConsumptionData];
            [self.fuelConsumptionstaticsWindow makeKeyAndOrderFront:sender];
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


#pragma mark ***** Aux Method *****


-(void)itemPriceVariationData {
    
    SMStaticView* view = [self.itemPricestaticsWindow contentView];
    
    NSArray* itm = [selectedItems selectedObjects];
    
    if (itm != nil && itm.count > 0) {
        
        Items* i = [itm objectAtIndex:0];
        
        NSArray* data = [self itemsByName:i.name];
        
        if (self.itemVariationData == nil) {
            self.itemVariationData = [[NSMutableDictionary alloc]init];
        }else {
            [self.itemVariationData removeAllObjects];
        }
        
        [self.itemVariationData setObject:data forKey:i.name];
        
        
        [view setItemVariationData:[NSDictionary dictionaryWithDictionary:self.itemVariationData]];
        [view setNeedsDisplay:YES];
    }
    
    if (itemVariationRate == nil) {
        itemVariationRate = [[NSMutableArray alloc]init];
    }else {
        [itemVariationRate removeAllObjects];
    }
    
    for(NSString* name in [self.itemVariationData allKeys]) {
        NSArray* array = [self.itemVariationData objectForKey:name];
        if(array.count >= 2) {
            Items *first = [array objectAtIndex:0];
            Items *second = [array objectAtIndex:array.count - 1];
            float rate = (second.price.floatValue - first.price.floatValue) / second.price.floatValue;
            [self.itemVariationRate addObject:[SMTuple tupleWithFirst:first.name second:[NSNumber numberWithFloat:rate]]];
        }
    }
    
}

-(void)futureTotalExpenseData {
    SMStaticView* view = [self.futureTotalExpensestaticsWindow contentView];
    
    NSDictionary* data = [self futureTotalExpense];
    
    if(data != nil) {
        [view setTotalExpenseData:data];
        [view setNeedsDisplay:YES];
    }
    
}

-(NSDictionary*)futureTotalExpense {
    
    NSManagedObjectContext* managedObjectContext = self.moneyDelegate.delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor* date = [[NSSortDescriptor alloc] initWithKey:@"due" ascending:YES];
    [fetchRequest setSortDescriptors:@[date]];
    
    NSError* error;
    NSArray* d = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSMutableDictionary * data;
    if(d == nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }else {
        data = [[NSMutableDictionary alloc]init];
        for(Expenses *exp in d) {
            NSNumber *value = [data objectForKey:exp.type];
            if (value != nil) {
                [data setObject:[NSNumber numberWithFloat:value.floatValue + exp.total.floatValue]
                         forKey:exp.type];
            }else {
                if(exp.total.floatValue > 0 )
                    [data setObject:[NSNumber numberWithFloat:exp.total.floatValue]
                             forKey:exp.type];
            }
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:data];
}


-(void)fuelConsumptionData {
    SMStaticView* view = [self.fuelConsumptionstaticsWindow contentView];
    
    NSArray* models = self.selectedModel.selectedObjects;
    
    
    if(models != nil && models.count > 0) {
        Model* model = [models objectAtIndex:0];
        
        NSDictionary* data = [self fuelConsumptionByModel:model];
        
        NSArray* disp = @[model.city, model.highway];
    
        if(data != nil && disp != nil) {
        
            [view setFuelConsumptionData:data bands:disp];
            [view setNeedsDisplay:YES];
        }
    }
    
}

-(NSDictionary*)fuelConsumptionByModel:(Model*)model {
    
    NSManagedObjectContext* managedObjectContext = self.moneyDelegate.delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Fuel" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(model == %@)", model];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor* date = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    [fetchRequest setSortDescriptors:@[date]];
    
    NSError* error;
    NSArray* d = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSMutableDictionary * data;
    if(d == nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }else {
        data = [[NSMutableDictionary alloc]init];
        
        BOOL isFirstData = YES;
    
        float odometer = 0;
        
        for(Fuel *fuel in d) {
            if(isFirstData) {
                odometer = fuel.odometer.floatValue;
                isFirstData = NO;
            }else {
                NSNumber *value = [data objectForKey:fuel.date];
                float consumption = abs(fuel.odometer.floatValue - odometer) / fuel.amount.floatValue;
                odometer = fuel.odometer.floatValue;
                
                if (value != nil) {
                    NSNumber *aux = [NSNumber numberWithFloat:value.floatValue + consumption];
                    [data setObject:aux forKey:fuel.date];
                }else {
                    if(fuel.amount.floatValue > 0 ) {
                        NSNumber *aux = [NSNumber numberWithFloat:consumption];
                        [data setObject:aux forKey:fuel.date];
                    }
                }
            }
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:data];
}

-(void)generateTotalExpenseData {
    SMStaticView* view = [self.totalExpensestaticsWindow contentView];
    
    self.totalExpenseData = [self totalExpense];
    
    if(self.totalExpenseData != nil) {
        [view setTotalExpenseData:self.totalExpenseData];
        [view setNeedsDisplay:YES];
    }
    
}

-(NSDictionary*)totalExpense {
    
    NSManagedObjectContext* managedObjectContext = self.moneyDelegate.delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor* date = [[NSSortDescriptor alloc] initWithKey:@"due" ascending:YES];
    [fetchRequest setSortDescriptors:@[date]];
    
    NSError* error;
    NSArray* d = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSMutableDictionary * data;
    if(d == nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }else {
        data = [[NSMutableDictionary alloc]init];
        for(Expenses *exp in d) {
            NSNumber *value = [data objectForKey:exp.type];
            if (value != nil) {
                [data setObject:[NSNumber numberWithFloat:value.floatValue + exp.total.floatValue]
                         forKey:exp.type];
            }else {
                if(exp.total.floatValue > 0 )
                    [data setObject:[NSNumber numberWithFloat:exp.total.floatValue]
                             forKey:exp.type];
            }
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:data];
}

-(void)generateTotalItemData {
    SMStaticView* view = [self.totalItemstaticsWindow contentView];
    
    self.totalItemData = [self totalItem];
    
    if(self.totalItemData != nil) {
        [view setTotalItemData:self.totalItemData];
        [view setNeedsDisplay:YES];
    }
    
}

-(NSDictionary*)totalItem {
    
    NSManagedObjectContext* managedObjectContext = self.moneyDelegate.delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor* date = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    [fetchRequest setSortDescriptors:@[date]];
    
    NSError* error;
    NSArray* d = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSMutableDictionary * data;
    if(d == nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }else {
        data = [[NSMutableDictionary alloc]init];
        for(Items *itm in d) {
            NSNumber *value = [data objectForKey:itm.name];
            if (value != nil) {
                [data setObject:[NSNumber numberWithFloat:value.floatValue + (itm.price.floatValue * itm.quantity.floatValue)]
                         forKey:itm.name];
            }else {
                if((itm.price.floatValue * itm.quantity.floatValue) > 0 )
                    [data setObject:[NSNumber numberWithFloat:itm.price.floatValue * itm.quantity.floatValue]
                         forKey:itm.name];
            }
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:data];
}

-(NSArray*)itemsByName:(NSString*)name {
    
    NSManagedObjectContext* managedObjectContext = self.moneyDelegate.delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSPredicate *predicate = nil;
    predicate = [NSPredicate predicateWithFormat:@"(name == %@)", name];
    
    
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor* date = [[NSSortDescriptor alloc] initWithKey:@"list.purchased" ascending:NO];
    [fetchRequest setSortDescriptors:@[date]];
    
    NSError* error;
    NSArray* d = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(d == nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        return d;
    }
    
    return [self filterByDate:d];
    
}

-(NSArray*)filterByDate:(NSArray*)items {
    NSMutableDictionary *filteredItems = [[NSMutableDictionary alloc]init];
    
    
    for(Items *i in items) {
        [filteredItems setObject:i forKey:i.list.purchased];
    }
    
    return [filteredItems allValues];
}

@end
