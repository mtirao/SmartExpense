//
//  SMSmartListDelegate.m
//  SmartExpense
//
//  Created by Marcos Tirao on 3/29/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMSmartListDelegate.h"
#import "Categories.h"
#import "List.h"
#import "Items.h"

@implementation SMSmartListDelegate

@synthesize delegate;
@synthesize dataSource, mergeSelectedList;
@synthesize mainWindow, mergePanel;


-(void)awakeFromNib {
    
    [self populateCategoryEntity];
    
}

-(BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    
    NSArray* source = [dataSource selectedObjects];
    
    if(mainWindow.isVisible && source != nil &&source.count > 0) {
        return YES;
    }
    
    return NO;
}


#pragma mark - Application's helper method

//Once persitent store is active we can populate the Category entity
-(void) populateCategoryEntity {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categories" inManagedObjectContext:delegate.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    NSError * error;
    NSArray *array = [delegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(array.count <= 0) {
        Categories *category = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category.name = @"Beverages";
        
        Categories *category1 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category1.name = @"Breakfast";
        
        Categories *category2 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category2.name = @"Canned Food";
        
        Categories *category3 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category3.name = @"Dairy";
        
        Categories *category4 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category4.name = @"Frozen";
        
        Categories *category5 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category5.name = @"Fruit & Vegetables";
        
        Categories *category6 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category6.name = @"Household";
        
        Categories *category7 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category7.name = @"Meat";
        
        Categories *category8 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category8.name = @"Misc";
        
        Categories *category9 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category9.name = @"Pasta & Bread";
        
        Categories *category10 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category10.name = @"Personal Care";
        
        Categories *category11 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category11.name = @"Sauces & Seasoning";
        
        Categories *category12 = (Categories*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
        category12.name = @"Snacks";
    }
    
}

#pragma mark ****** Application Action Method ******

-(IBAction)showWindow:(id)sender {
    [mainWindow makeKeyAndOrderFront:sender];
}

-(IBAction)addDefaultList:(id)sender {
    
    NSArray *source = [dataSource selectedObjects];
    
    if(source != nil && source.count > 0) {
        List* currentList = [source objectAtIndex:0];
        [self addDefaultVegetables:currentList];
        [self addDefaultMeat:currentList];
        [self addDefaultDairy:currentList];
        [self addDefaultBreakast:currentList];
        [self addDefaultFrozen:currentList];
        [self addDefaultPastaBread:currentList];
        [self addDefaultSaucesSeasoning:currentList];
        [self addDefaultCannedFood:currentList];
        [self addDefaultMisc:currentList];
        [self addDefaultBeverage:currentList];
        [self addDefaultSnacks:currentList];
        [self addDefaultHousehold:currentList];
        [self addDefaultPersonalCare:currentList];
    }
    
}

-(IBAction)showMergePanel:(id)sender {
    [mergePanel makeKeyAndOrderFront:sender];
}

-(IBAction)okMergePanel:(id)sender {
    
    NSArray *source = [dataSource selectedObjects];
    NSArray *mergeLists = [mergeSelectedList selectedObjects];
    
    NSInteger count = 0;
    if(source != nil && source.count > 0) {
        if(mergeLists != nil && mergeLists.count > 0) {
            List *currentList = [source objectAtIndex:0];
            for(List *l in mergeLists) {
                if(![l.name isEqualToString:currentList.name]) {
                    for(Items *itm in l.items){
                        Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
                    
                        item.category = [NSString stringWithString:itm.category];
                        item.date = [itm copy];
                        item.name = [NSString stringWithString:itm.name];
                        item.price = [NSNumber numberWithFloat:itm.price.floatValue];
                        item.quantity = [NSNumber numberWithFloat:itm.quantity.floatValue];
                        item.weight = [NSNumber numberWithBool:itm.weight.boolValue];
                        item.list = currentList;
                        [currentList addItemsObject:item];
                    }
                    count++;
                }
            }
            if (count == 0) {
                [self showAlertWithInformativeMessage:@"None of the selected list were merged" message:@"Maybe the selected list is the same as the current list."];
            }else {
                NSString *msg = [NSString stringWithFormat:@"%ld of %ld list were merge.", count, mergeLists.count];
                [self showAlertWithInformativeMessage:@"Selected List were merged succesfully" message:msg];
            }
        }else {
            [self showAlertWithInformativeMessage:@"Merge selection list empty" message:@""];
        }
    }
    
    
    [mergePanel orderOut:sender];
}

-(IBAction)cancelMergePanel:(id)sender {
    [mergePanel orderOut:sender];
}

#pragma mark ****** Application Aux Method ******

- (void)addDefaultVegetables:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Celery";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Potato";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Eggplant";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Broccoli";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Pumpkin";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Onion";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Cauliflower";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Spinach";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Lettuce";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Beet";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Cabbage";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Tomato";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Carrot";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Zucchini";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Banana";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Strawberry";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Lemon";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Tangerine";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Apple";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Melon";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Orange";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Pear";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Grapefruit";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Watermelon";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Fruit & Vegetables";
    item.date = [NSDate date];
    item.name = @"Grape";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
 }


- (void) addDefaultMeat:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    //Vegetables
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Meats";
    item.date = [NSDate date];
    item.name = @"Ham";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Meats";
    item.date = [NSDate date];
    item.name = @"Salami";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Meats";
    item.date = [NSDate date];
    item.name = @"Sausages";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Meats";
    item.date = [NSDate date];
    item.name = @"Pork";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Meats";
    item.date = [NSDate date];
    item.name = @"Fish";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Meats";
    item.date = [NSDate date];
    item.name = @"Chicken";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
 
}


- (void) addDefaultDairy:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    //Vegetables
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Dairy";
    item.date = [NSDate date];
    item.name = @"Milk";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Dairy";
    item.date = [NSDate date];
    item.name = @"Cream";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Dairy";
    item.date = [NSDate date];
    item.name = @"Butter";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Dairy";
    item.date = [NSDate date];
    item.name = @"Yogurt";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Dairy";
    item.date = [NSDate date];
    item.name = @"Cream Cheese";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Dairy";
    item.date = [NSDate date];
    item.name = @"Grated Cheese";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
 
}


- (void) addDefaultBreakast:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    //Vegetables
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Breakast";
    item.date = [NSDate date];
    item.name = @"Sugar";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Breakast";
    item.date = [NSDate date];
    item.name = @"Sweetener";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Breakast";
    item.date = [NSDate date];
    item.name = @"Cocoa";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Breakast";
    item.date = [NSDate date];
    item.name = @"Coffee";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Breakast";
    item.date = [NSDate date];
    item.name = @"Milk Powder";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Breakast";
    item.name = @"Tea";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Breakast";
    item.date = [NSDate date];
    item.name = @"Jam";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Breakast";
    item.date = [NSDate date];
    item.name = @"Honey";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Breakast";
    item.date = [NSDate date];
    item.name = @"Cookies";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Breakast";
    item.date = [NSDate date];
    item.name = @"Cereals";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];

}


- (void) addDefaultFrozen:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    //Vegetables
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Frozen Foods";
    item.date = [NSDate date];
    item.name = @"Peas";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Frozen Foods";
    item.date = [NSDate date];
    item.name = @"Broccholi";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Frozen Foods";
    item.date = [NSDate date];
    item.name = @"Onion";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Frozen Foods";
    item.date = [NSDate date];
    item.name = @"Corn";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Frozen Foods";
    item.date = [NSDate date];
    item.name = @"Spinach";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Frozen Foods";
    item.date = [NSDate date];
    item.name = @"Burger";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Frozen Foods";
    item.date = [NSDate date];
    item.name = @"Ice Cream";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Frozen Foods";
    item.date = [NSDate date];
    item.name = @"French Fries";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Breakast";
    item.date = [NSDate date];
    item.name = @"Cookies";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Frozen Foods";
    item.date = [NSDate date];
    item.name = @"Pizza";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];

}

- (void) addDefaultPastaBread:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    //Vegetables
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Pasta & Bread";
    item.date = [NSDate date];
    item.name = @"Baguette";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Pasta & Bread";
    item.date = [NSDate date];
    item.name = @"Sliced Bread";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Pasta & Bread";
    item.date = [NSDate date];
    item.name = @"Pizza";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Pasta & Bread";
    item.date = [NSDate date];
    item.name = @"Bread Burgers";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Pasta & Bread";
    item.date = [NSDate date];
    item.name = @"Ravioli";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Pasta & Bread";
    item.date = [NSDate date];
    item.name = @"Spaguetti";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Pasta & Bread";
    item.date = [NSDate date];
    item.name = @"Penne Rigatti";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Pasta & Bread";
    item.date = [NSDate date];
    item.name = @"Noodles";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];

}

- (void) addDefaultSaucesSeasoning:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    //Vegetables
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Sauces & Seasoning";
    item.date = [NSDate date];
    item.name = @"Corn Oil";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Sauces & Seasoning";
    item.date = [NSDate date];
    item.name = @"Olive Oil";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Sauces & Seasoning";
    item.date = [NSDate date];
    item.name = @"Pepper";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Sauces & Seasoning";
    item.date = [NSDate date];
    item.name = @"Salt";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Sauces & Seasoning";
    item.date = [NSDate date];
    item.name = @"Vinegar";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Sauces & Seasoning";
    item.date = [NSDate date];
    item.name = @"Ketchup";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Sauces & Seasoning";
    item.date = [NSDate date];
    item.name = @"Mayonnaise";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Sauces & Seasoning";
    item.date = [NSDate date];
    item.name = @"Mustard";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Sauces & Seasoning";
    item.date = [NSDate date];
    item.name = @"Soy Sauce";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Sauces & Seasoning";
    item.date = [NSDate date];
    item.name = @"Tomtato Sauce";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
}


- (void) addDefaultCannedFood:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    //Vegetables
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Canned Food";
    item.date = [NSDate date];
    item.name = @"Peas";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Canned Food";
    item.date = [NSDate date];
    item.name = @"Tuna";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Canned Food";
    item.date = [NSDate date];
    item.name = @"Corn";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Canned Food";
    item.date = [NSDate date];
    item.name = @"Peach";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Canned Food";
    item.date = [NSDate date];
    item.name = @"Sardines";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
}


- (void) addDefaultMisc:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    //Vegetables
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Misc";
    item.date = [NSDate date];
    item.name = @"Rice";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Misc";
    item.date = [NSDate date];
    item.name = @"Flour";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Misc";
    item.date = [NSDate date];
    item.name = @"Eggs";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Misc";
    item.date = [NSDate date];
    item.name = @"Soup";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
}

- (void) addDefaultBeverage:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Beverages";
    item.date = [NSDate date];
    item.name = @"Beer";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Beverages";
    item.date = [NSDate date];
    item.name = @"Juice";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Beverages";
    item.date = [NSDate date];
    item.name = @"Wine";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Beverages";
    item.date = [NSDate date];
    item.name = @"Soda";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Beverages";
    item.date = [NSDate date];
    item.name = @"Sparkling Water";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];

}

- (void) addDefaultSnacks:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    //Vegetables
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Snacks";
    item.date = [NSDate date];
    item.name = @"Peanut";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Snacks";
    item.date = [NSDate date];
    item.name = @"Potato Chips";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Snacks";
    item.date = [NSDate date];
    item.name = @"Pretzels";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Snacks";
    item.date = [NSDate date];
    item.name = @"Bagels";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];

}

- (void) addDefaultHousehold:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    //Vegetables
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Household";
    item.date = [NSDate date];
    item.name = @"Litter Bags";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Household";
    item.date = [NSDate date];
    item.name = @"Degreaser";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Household";
    item.date = [NSDate date];
    item.name = @"Air Freshener";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Household";
    item.date = [NSDate date];
    item.name = @"Sponge";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Household";
    item.date = [NSDate date];
    item.name = @"Napkins";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Household";
    item.date = [NSDate date];
    item.name = @"Wiper";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];

}

- (void) addDefaultPersonalCare:(List*)defaultList {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    //Vegetables
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Personal Care";
    item.date = [NSDate date];
    item.name = @"Cotton";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Personal Care";
    item.date = [NSDate date];
    item.name = @"Tooth Paste";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
    
    item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:delegate.managedObjectContext];
    item.category = @"Personal Care";
    item.date = [NSDate date];
    item.name = @"Soap";
    item.price = [NSNumber numberWithFloat:0.0];
    item.quantity = [NSNumber numberWithInt:0];
    item.weight = [NSNumber numberWithFloat:0.0];
    item.list = defaultList;
    [defaultList addItemsObject:item];
}

-(void)showAlertWithInformativeMessage:(NSString*)info message:(NSString*)msg {
    NSAlert *alert = [[NSAlert alloc]init];
    [alert setInformativeText:info];
    [alert setMessageText:msg];
    [alert addButtonWithTitle:@"Ok"];
    void(^returnCode)(NSModalResponse) = ^(NSModalResponse code){};
    [alert beginSheetModalForWindow:mainWindow completionHandler:returnCode];

}

@end
