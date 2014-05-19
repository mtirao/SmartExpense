//
//  SMMergeListController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 5/16/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMMergeListController.h"
#import "List.h"
#import "Items.h"

@implementation SMMergeListController

@synthesize dataSource;
@synthesize mergePanel;
@synthesize delegate;
@synthesize mergeData;


- (void)arrangeObjects {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"List" inManagedObjectContext:self.delegate.delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray* list = [dataSource selectedObjects];
    if(list != nil && list.count > 0) {
        List* currentList = [list objectAtIndex:0];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name != %@)", currentList.name];
        [fetchRequest setPredicate:predicate];
        
        NSError *error;
        
        mergeData = [self.delegate.delegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    }

}

#pragma mark ***** Action Methods *****

-(BOOL) validateMenuItem:(NSMenuItem *)menuItem {
    return delegate.mainWindow.isKeyWindow;
}

-(IBAction)showMergePanel:(id)sender {
    [self arrangeObjects];
    [mergePanel makeKeyAndOrderFront:sender];
    [self.tableView reloadData];
}

-(IBAction)okMergePanel:(id)sender {
    
    NSArray *source = [dataSource selectedObjects];
    
    NSInteger selection = [self.tableView selectedRow];
    
    if(source != nil && source.count > 0) {
        List *currentList = [source objectAtIndex:0];
        List *l = [mergeData objectAtIndex:selection];
        
        for(Items *itm in l.items){
            Items *item = (Items*)[NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:self.delegate.delegate.managedObjectContext];
     
            item.category = [NSString stringWithString:itm.category];
            item.date = [itm.date copy];
            item.name = [NSString stringWithString:itm.name];
            item.price = [NSNumber numberWithFloat:itm.price.floatValue];
            item.quantity = [NSNumber numberWithFloat:itm.quantity.floatValue];
            item.weight = [NSNumber numberWithBool:itm.weight.boolValue];
            item.list = currentList;
            [currentList addItemsObject:item];
        }
    }
 
    
    [mergePanel orderOut:sender];
}

-(IBAction)cancelMergePanel:(id)sender {
    [mergePanel orderOut:sender];
}

#pragma mark ***** Table View DataSoruce Protocol Methods *****

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return mergeData != nil? mergeData.count : 0;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    
    List* name = [mergeData objectAtIndex:rowIndex];
    
    return name.name;
}


#pragma mark ***** Aux Method *****

-(void)showAlertWithInformativeMessage:(NSString*)info message:(NSString*)msg {
    NSAlert *alert = [[NSAlert alloc]init];
    [alert setInformativeText:info];
    [alert setMessageText:msg];
    [alert addButtonWithTitle:@"Ok"];
    void(^returnCode)(NSModalResponse) = ^(NSModalResponse code){};
    [alert beginSheetModalForWindow:delegate.mainWindow completionHandler:returnCode];
    
}


@end
