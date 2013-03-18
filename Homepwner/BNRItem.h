//
//  BNRItem.h
//  RandomPossessions
//
//  Created by Andrew Long on 12/27/12.
//  Copyright (c) 2012 Andrew Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject <NSCoding>

@property (nonatomic,readwrite,copy) NSString* itemName;
@property (nonatomic,readwrite,copy) NSString* serialNumber;
@property (nonatomic,readwrite,assign) int valueInDollars;
@property (nonatomic,readonly,strong) NSDate* dateCreated;
@property (nonatomic,readwrite,strong) BNRItem* containedItem;
@property (nonatomic,readwrite,weak) BNRItem* container;

@property (nonatomic, copy) NSString *imageKey;

+(id)randomItem;

-(id)initWithItemName:(NSString*)name
       valueInDollars:(int)value
         serialNumber:(NSString*)sNumber;

@end