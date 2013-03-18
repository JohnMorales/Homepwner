//
//  BNRItemStore.h
//  Homepwner
//
//  Created by John Morales on 3/7/13.
//  Copyright (c) 2013 John Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject
{
    NSMutableArray *allItems;
}
+(BNRItemStore *)sharedStore;
-(NSArray *)allItems;
-(BNRItem*)createItem;
-(void)removeItem:(BNRItem *)item;
-(void)moveItemAtIndex:(int)from toindex:(int)to;
-(NSString *)itemArchivePath;
-(BOOL)saveChanges;
@end
