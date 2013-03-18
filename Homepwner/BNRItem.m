//
//  BNRItem.m
//  RandomPossessions
//
//  Created by Andrew Long on 12/27/12.
//  Copyright (c) 2012 Andrew Long. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem
@synthesize itemName, serialNumber, valueInDollars, dateCreated, containedItem, container, imageKey;

+(id)randomItem{
    // Create an array of three adjectives
    NSArray* randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffly",@"Rusty",@"Shiny",nil];
    
    // Create an array of three nouns
    NSArray* randomNounList = [NSArray arrayWithObjects:@"Bear",@"Spork",@"Mac",nil];
    
    // Get the index of a random adjective/noun from the lists
    NSInteger adjectiveIndex = rand() % [randomAdjectiveList count];
    NSInteger nounIndex = rand() % [randomNounList count];
    
    NSString* randomName = [NSString stringWithFormat:@"%@ %@",[randomAdjectiveList objectAtIndex:adjectiveIndex],[randomNounList objectAtIndex:nounIndex]];
    
    int randomValue = rand() % 100;
    
    NSString* randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10];
    
    BNRItem* newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return newItem;
}

-(id)init{
    return [self initWithItemName:@"Item"
                   valueInDollars:0
                     serialNumber:@""];
}

-(id)initWithItemName:(NSString *)name
       valueInDollars:(int)value
         serialNumber:(NSString *)sNumber{
    // Call the superclass's designated initializer
    self = [super init];
    if(self){
        // Give the instance variables initial values
        [self setItemName:name];
        [self setSerialNumber:sNumber];
        [self setValueInDollars:value];
        dateCreated = [[NSDate alloc] init];
    }
    
    return self;
}

-(void)setContainedItem:(BNRItem *)i{
    containedItem = i;
    [i setContainer:self];
}

-(NSString*)description{
    NSString* descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",itemName,serialNumber,valueInDollars,dateCreated];
    return descriptionString;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
  [aCoder encodeObject:serialNumber forKey:@"serialNumber"];
  [aCoder encodeObject:itemName forKey:@"itemName"];
  [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
  [aCoder encodeObject:imageKey forKey:@"imageKey"];
  
  [aCoder encodeInt:valueInDollars forKey:@"valueInDollars"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super init];
  if (self) {
    [self setItemName:[aDecoder decodeObjectForKey:@"itemName"]];
    [self setSerialNumber:[aDecoder decodeObjectForKey:@"serialNumber"]];
    [self setImageKey:[aDecoder decodeObjectForKey:@"imageKey"]];
    [self setValueInDollars:[aDecoder decodeIntForKey:@"valueInDollars"]];
    
    dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
  }
  return self;
}


@end