//
//  SMFinancialStatusController.m
//  SmartExpense
//
//  Created by Marcos Tirao on 6/4/14.
//  Copyright (c) 2014 Marcos Tirao. All rights reserved.
//

#import "SMFinancialStatusController.h"
#import "Banks.h"
#import "Accounts.h"
#import "Expenses.h"
#import "SMTuple.h"


@implementation SMFinancialStatusController

@synthesize mainWindow, appDelegate;
@synthesize datasource;
@synthesize outlineView;
@synthesize totals;


#define NAME_KEY                     @"Name"
#define CHILDREN_KEY                 @"Children"



-(void)awakeFromNib {
    self.mainWindow.backgroundColor = [NSColor whiteColor];
}

// The NSOutlineView uses 'nil' to indicate the root item. We return our root tree node for that case.
- (NSArray *)childrenForItem:(id)item {
    if (item == nil) {
        return [self.datasource childNodes];
    } else {
        return [item childNodes];
    }
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    // 'item' may potentially be nil for the root item.
    NSArray *children = [self childrenForItem:item];
    // This will return an NSTreeNode with our model object as the representedObject
    return [children objectAtIndex:index];

}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    // 'item' will always be non-nil. It is an NSTreeNode, since those are always the objects we give NSOutlineView. We access our model object from it.
    SMNodeData *nodeData = [item representedObject];
    // We can expand items if the model tells us it is a container
    
    return nodeData.isContainer;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    
    // 'item' may potentially be nil for the root item.
    NSArray *children = [self childrenForItem:item];
    return [children count];
    
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    
    SMNodeData *nodeData = [item representedObject];
    
    if ((tableColumn == nil) || [[tableColumn.headerCell stringValue] isEqualToString:@"Expense"]) {
        return nodeData.name;
    }else {
        return nodeData.total;
    }
}

#pragma mark **** Application Action Methods ****

-(IBAction)showWindow:(id)sender {
    
    NSManagedObjectContext* managedObjectContext = self.appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Banks" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];

    
    NSSortDescriptor* date = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[date]];
    
    NSError* error;
    
    NSArray* d = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
   
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    totals = [[NSMutableDictionary alloc]init];
    
    [data setObject:@"OVRoot" forKey:NAME_KEY];
    
    
    if (d != nil) {
        
        NSMutableArray *banks = [[NSMutableArray alloc]init];
        
        
        for(Banks *bank in d) {
            float bankAmt = 0;
            NSMutableDictionary * bankNode = [[NSMutableDictionary alloc]init];
            
            [bankNode setObject:bank.name forKey:NAME_KEY];
            
            NSMutableDictionary *accountNode = [[NSMutableDictionary alloc]init];
            
            NSMutableArray *accounts =[[NSMutableArray alloc]init];
            
            for (Accounts *account in bank.accounts) {
                NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc]init];
                [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                
                NSString *name = [NSString stringWithFormat:@"%@ - %@",
                                 [self transformedValue:account.type], account.number];
                
                [accountNode setObject:name forKey:NAME_KEY];
                
                NSMutableArray *exp = [[NSMutableArray alloc]init];
                
                float expAmt = 0;
                for (Expenses *expense in account.expenses) {
                    expAmt += expense.total.floatValue;
    
                    if (account.currencysymbol != nil) {
                        currencyFormatter.currencySymbol = account.currencysymbol;
                        [exp addObject:[SMTuple tupleWithFirst:expense.type second:[currencyFormatter stringFromNumber:expense.total]]];
                    } else {
                       [exp addObject:[SMTuple tupleWithFirst:expense.type second:[currencyFormatter stringFromNumber:expense.total]]];
                    }
                }
                
                if (account.currencysymbol != nil) {
                    currencyFormatter.currencySymbol = account.currencysymbol;
                    NSString *aux = [currencyFormatter stringFromNumber:[NSNumber numberWithFloat:expAmt]];
                    [totals setObject:aux forKey:name];
                    
                } else {
                    NSString *aux = [currencyFormatter stringFromNumber:[NSNumber numberWithFloat:expAmt]];
                    [totals setObject:aux forKey:name];
                }

                
                bankAmt += expAmt;
                
                
                [accountNode setObject:exp forKey:CHILDREN_KEY];
                
                [accounts addObject:accountNode];
            }
            
            //TODO: I have to review how to handle to account for banks
            //[totals setObject:[NSNumber numberWithFloat:bankAmt] forKey:bank.name];
        
            [bankNode setObject:accounts forKey:CHILDREN_KEY];
            
            [banks addObject: bankNode];
        }
        
        [data setObject:banks forKey:CHILDREN_KEY];
        
    }
    
    datasource = [self treeNodeFromDictionary:data];
    
    [outlineView reloadData];
    [self.mainWindow makeKeyAndOrderFront:sender];
}

#pragma mark ***** Aux Methods *****

- (NSString*)transformedValue:(id)value {
	
    NSArray *type = @[@"SA", @"CA", @"LA", @"CCA",@"IA"];
    
    return [type objectAtIndex:[value intValue]];
}

- (NSTreeNode *)treeNodeFromDictionary:(NSDictionary *)dictionary {
    // We will use the built-in NSTreeNode with a representedObject that is our model object - the SimpleNodeData object.
    // First, create our model object.
    NSString *nodeName = [dictionary objectForKey:NAME_KEY];
    NSString *amt = [totals objectForKey:nodeName];
 
    SMNodeData *nodeData = [SMNodeData nodeDataWithName:nodeName];
    if (amt != nil) {
        nodeData.total = amt;
    }

    
    // The image for the nodeData is lazily filled in, for performance.
    
    // Create a NSTreeNode to wrap our model object. It will hold a cache of things such as the children.
    NSTreeNode *result = [NSTreeNode treeNodeWithRepresentedObject:nodeData];
    
    // Walk the dictionary and create NSTreeNodes for each child.
    NSArray *children = [dictionary objectForKey:CHILDREN_KEY];
    
    for (id item in children) {
        // A particular item can be another dictionary (ie: a container for more children), or a simple string
        NSTreeNode *childTreeNode;
        if ([item isKindOfClass:[NSDictionary class]]) {
            // Recursively create the child tree node and add it as a child of this tree node
            childTreeNode = [self treeNodeFromDictionary:item];
        } else {
            // It is a regular leaf item with just the name
            
            SMTuple * leaf = item;
            
            SMNodeData *childNodeData = [[SMNodeData alloc] initWithName: leaf.first];
            childNodeData.total = leaf.second;
            childNodeData.container = NO;
            
            childTreeNode = [NSTreeNode treeNodeWithRepresentedObject:childNodeData];
        }
        // Now add the child to this parent tree node
        [[result mutableChildNodes] addObject:childTreeNode];
    }
    
    return result;
    
}


@end
