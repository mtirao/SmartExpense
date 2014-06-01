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
@synthesize dataSource;
@synthesize mainWindow;


-(void)awakeFromNib {
    
    [self populateCategoryEntity];
    
}

-(BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    
    NSArray* source = [dataSource selectedObjects];
    
    if(mainWindow.isKeyWindow && source != nil &&source.count > 0) {
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


#pragma mark ****** Application Aux Method ******

- (void)addDefaultVegetables:(List*)defaultList {
    
    NSString *category = @"Fruit & Vegetables";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Celery"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Potato"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Eggplant"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Broccoli"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Pumpkin"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Onion"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Cauliflower"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Lettuce"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Beet"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Cabbage"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Tomato"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Carrot"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Zucchini"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Banana"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Beet"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Cabbage"];
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Strawberry"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Lemon"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Tangerine"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Apple"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Cabbage"];
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Melon"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Orange"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Pear"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Grapefruit"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Watermelon"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Grape"];

    
 }


- (void) addDefaultMeat:(List*)defaultList {
    
    NSString *category = @"Meat";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Ham"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Salami"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Sausages"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Pork"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Fish"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Chicken"];
 
}


- (void) addDefaultDairy:(List*)defaultList {
    
    NSString *category = @"Dairy";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Milk"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Cream"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Butter"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Yogurt"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Cream Cheese"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Grated Cheese"];
}


- (void) addDefaultBreakast:(List*)defaultList {
    
    NSString *category = @"Breakfast";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Sugar"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Sweetener"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Cocoa"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Coffee"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Milk Powder"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Tea"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Jam"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Honey"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Cookies"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Cereals"];
 
}


- (void) addDefaultFrozen:(List*)defaultList {
    
    NSString *category = @"Frozen Foods";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Peas"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Broccholi"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Onion"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Corn"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Spinach"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Burger"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Ice Cream"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"French Fries"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Pizza"];
}

- (void) addDefaultPastaBread:(List*)defaultList {
    
    
    NSString *category = @"Pasta & Bread";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Baguette"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Sliced Bread"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Pizza"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Bread Burgers"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Ravioli"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Spaguetti"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Penne Rigatti"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Noodles"];
    

}

- (void) addDefaultSaucesSeasoning:(List*)defaultList {
    
    NSString *category = @"Sauces & Seasoning";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Corn Oil"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Olive Oil"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Salt"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Vinegar"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Ketchup"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Mayonnaise"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Mustard"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Soy Sauce"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Tomato Sauce"];
}


- (void) addDefaultCannedFood:(List*)defaultList {
    
    NSString *category = @"Canned Food";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Peas"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Tuna"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Corn"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Sardines"];

}


- (void) addDefaultMisc:(List*)defaultList {
    
    NSString *category = @"Misc";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Rice"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"FLour"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Eggs"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Soup"];
}

- (void) addDefaultBeverage:(List*)defaultList {
    
    NSString *category = @"Beverages";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Beer"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Juice"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Wine"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Soda"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Sparkling Water"];
}

- (void) addDefaultSnacks:(List*)defaultList {
    
    NSString *category = @"Snacks";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Peanut"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Potato Chips"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Pretzels"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Bagels"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Napkins"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Wiper"];
 
}

- (void) addDefaultHousehold:(List*)defaultList {
    
    NSString *category = @"Household";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Litter Bags"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Degreaser"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Air Freshener"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Sponge"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Napkins"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Wiper"];
    
}

- (void) addDefaultPersonalCare:(List*)defaultList {
    
    NSString *category = @"Personal Care";
    
    [self addDefaultItemToList:defaultList withCategory:category name:@"Cotton"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Tooth Paste"];
    [self addDefaultItemToList:defaultList withCategory:category name:@"Soap"];

}

-(void) addDefaultItemToList:(List*)defaultList withCategory:(NSString*)cat name:(NSString*)n  {
    
    Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:delegate.managedObjectContext];
    
    item.category = cat;
    item.name = n;
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
