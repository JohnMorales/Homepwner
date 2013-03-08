//
//  ItemsViewController.h
//  Homepwner
//
//  Created by John Morales on 3/6/13.
//  Copyright (c) 2013 John Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemsViewController : UITableViewController
{
 IBOutlet UIView *headerView;
}
-(UIView *)headerView;
-(IBAction)addNewItem:(id)sender;
-(IBAction)toggleEditingMode:(id)sender;

@end
