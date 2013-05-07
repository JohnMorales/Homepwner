//
//  ItemsViewController.h
//  Homepwner
//
//  Created by John Morales on 3/6/13.
//  Copyright (c) 2013 John Morales. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewController.h"
#import "HomepwnerItemCell.h"

@interface ItemsViewController : UITableViewController <UIPopoverControllerDelegate>
{
 UIPopoverController *imagePopover;
}
-(IBAction)addNewItem:(id)sender;

@end
