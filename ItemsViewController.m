//
//  ItemsViewController.m
//  Homepwner
//
//  Created by John Morales on 3/6/13.
//  Copyright (c) 2013 John Morales. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation ItemsViewController

-(id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
      UINavigationItem *n = [self navigationItem];
      [n setTitle:@"Homepwner"];
      
      UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
      [[self navigationItem] setRightBarButtonItem:bbi];
      
      [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    }
    return self;
}

-(id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    BNRItem *p = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[p description]];
    
    return cell;
    
}

-(IBAction)addNewItem:(id)sender
{
  BNRItem *item = [[BNRItemStore sharedStore] createItem];
  
  int lastRow = [[[BNRItemStore sharedStore] allItems]indexOfObject:item];
  
  NSIndexPath *path = [NSIndexPath indexPathForRow:lastRow inSection:0];
  
  [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationTop];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
      BNRItemStore *ps = [BNRItemStore sharedStore];
      NSArray *items = [ps allItems];
      BNRItem *p = [items objectAtIndex:[indexPath row]];
      [ps removeItem:p];
      
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
  [[BNRItemStore sharedStore] moveItemAtIndex:[sourceIndexPath row] toindex:[destinationIndexPath row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  DetailViewController *detailViewController = [[DetailViewController alloc] init];
  
  NSArray *items = [[BNRItemStore sharedStore] allItems];
  BNRItem *selectedItem = [items objectAtIndex:[indexPath row]];
  
  [detailViewController setItem:selectedItem];
  [[self navigationController] pushViewController:detailViewController animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [[self tableView] reloadData];
}
-(BOOL)shouldAutorotate
{
  return YES;
}
-(NSUInteger)supportedInterfaceOrientations
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    return UIInterfaceOrientationMaskAll;
  }
  return UIInterfaceOrientationMaskPortrait;
}
@end
