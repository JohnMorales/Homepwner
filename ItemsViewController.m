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
#import "BNRImageStore.h"
#import "ImageViewController.h"

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
-(void)viewDidLoad
{
  [super viewDidLoad];
  
  UINib *nib = [UINib nibWithNibName:@"HomepwnerItemCell" bundle:nil];
  
  [[self tableView] registerNib:nib forCellReuseIdentifier:@"HomepwnerItemCell"];
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
  BNRItem *p = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];

  HomepwnerItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomepwnerItemCell"];

  [cell setController:self];
  [cell setTableView:tableView];
  [[cell nameLabel] setText:[p itemName]];
  [[cell serialNumberLabel] setText:[p serialNumber]];
  [[cell valueLabel] setText:[NSString stringWithFormat:@"$%d", [p valueInDollars]]];

  [[cell thumbnailView] setImage:[p thumbnail]];

  return cell;    
}

-(IBAction)addNewItem:(id)sender
{
  BNRItem *item = [[BNRItemStore sharedStore] createItem];
  
  DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:YES];
  [detailViewController setItem:item];
  [detailViewController setDismissBlock:^{
    [[self tableView] reloadData];
  }];
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
  [navController setModalPresentationStyle:UIModalPresentationFormSheet];
  [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
  [self presentViewController:navController animated:YES completion:nil];
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
  DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:NO];
  
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

-(void)showImage:(id)sender atIndexPath:(NSIndexPath *)path
{
  NSLog(@"Going to show the image for %@", path);
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    BNRItem *i = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[path row]];
    
    NSString *imageKey = [i imageKey];
    
    UIImage *image = [[BNRImageStore sharedStore] imageForKey:imageKey];
    
    if (!image) return;
    
    CGRect rect = [[self view] convertRect:[sender bounds] fromView:sender];
    
    ImageViewController *ivc = [[ImageViewController alloc] init];
    [ivc setImage:image];
    
    imagePopover = [[UIPopoverController alloc] initWithContentViewController:ivc];
    
    [imagePopover setDelegate:self];
    [imagePopover setPopoverContentSize:CGSizeMake(600, 600)];
    [imagePopover presentPopoverFromRect:rect inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
  }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
  [imagePopover dismissPopoverAnimated:YES];
  imagePopover = nil;
}
@end
