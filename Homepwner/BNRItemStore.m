//
//  BNRItemStore.m
//  Homepwner
//
//  Created by John Morales on 3/7/13.
//  Copyright (c) 2013 John Morales. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
@implementation BNRItemStore

-(id)init
{
    self = [super init];
    if (self) {
      NSString *path = [self itemArchivePath];
      

      allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
      
      if (!allItems)
        allItems = [[NSMutableArray alloc]init];
    }
    return self;
}

+(BNRItemStore *) sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}
+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}
-(NSArray *)allItems
{
    return allItems;
}
-(BNRItem *)createItem
{
    BNRItem *p = [[BNRItem alloc] init];
    
    [allItems addObject:p];
    
    return p;
}
-(void)removeItem:(BNRItem *)item
{
  NSString *key = [item imageKey];
  [[BNRImageStore sharedStore] deleteImageForKey:key];
  
  [allItems removeObjectIdenticalTo:item];
}
-(void)moveItemAtIndex:(int)from toindex:(int)to
{
  if (from == to) return;
  BNRItem *p = [allItems objectAtIndex:from];
  [allItems removeObjectAtIndex:from];
  [allItems insertObject:p atIndex:to];
}
-(BOOL)saveChanges
{
  NSString* path = [self itemArchivePath];
  return [NSKeyedArchiver archiveRootObject:allItems toFile:path];
}

-(NSString *)itemArchivePath
{
  NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  NSString *documentDirectory = [documentDirectories objectAtIndex:0];
  
  return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

@end
