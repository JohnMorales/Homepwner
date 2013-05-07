//
//  BNRItem.m
//  RandomPossessions
//
//  Created by Andrew Long on 12/27/12.
//  Copyright (c) 2012 Andrew Long. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem
@synthesize itemName, serialNumber, valueInDollars, dateCreated, containedItem, container, imageKey, thumbnail, thumbnailData;

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

-(UIImage *)thumbnail
{
  if (!thumbnailData) {
    return nil;
  }
  if (!thumbnail ) {
    thumbnail = [UIImage imageWithData:thumbnailData];
  }
  return thumbnail;
}

-(void)setThumbnailDataFromImage:(UIImage *)image
{
  CGSize originalImageSize = [image size];
  
  CGRect newRect = CGRectMake(0, 0, 40, 40);
  
  float ratio = MAX(newRect.size.width / originalImageSize.width, newRect.size.height / originalImageSize.height);
  
  UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
  
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.];
  
  [path addClip];
  
  CGRect projectRect;
  projectRect.size.width = ratio * originalImageSize.width;
  projectRect.size.height = ratio * originalImageSize.height;
  projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.;
  projectRect.origin.y = (newRect.size.height - projectRect.size.height) /2.;
  
  [image drawInRect:projectRect];
  
  UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
  [self setThumbnail:smallImage];
  
  NSData *data = UIImagePNGRepresentation(smallImage);
  [self setThumbnailData:data];
  
  UIGraphicsEndImageContext();
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
  [aCoder encodeObject:thumbnailData forKey:@"thumbnailData"];
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
    
    thumbnailData = [aDecoder decodeObjectForKey:@"thumbnailData"];
  }
  return self;
}


@end