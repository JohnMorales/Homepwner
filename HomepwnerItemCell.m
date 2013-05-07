//
//  HomepwnerItemCell.m
//  Homepwner
//
//  Created by John Morales on 3/19/13.
//  Copyright (c) 2013 John Morales. All rights reserved.
//

#import "HomepwnerItemCell.h"

@implementation HomepwnerItemCell

@synthesize controller, tableView;
@synthesize thumbnailView, nameLabel, serialNumberLabel, valueLabel;

- (IBAction)showImage:(id)sender {
  NSIndexPath *indexPath = [[self tableView] indexPathForCell:self];
  
  NSString *selector = NSStringFromSelector(_cmd);
  selector = [selector stringByAppendingString:@"atIndexPath:"];
  
  SEL newSelector = NSSelectorFromString(selector);
  
  if (indexPath)
  {
    if ([[self controller] respondsToSelector:newSelector]) {
      [[self controller] performSelector:newSelector withObject:sender withObject:indexPath];
    }
  }

  
}
@end
