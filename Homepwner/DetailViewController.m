//
//  DetailViewController.m
//  Homepwner
//
//  Created by John Morales on 3/8/13.
//  Copyright (c) 2013 John Morales. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize item;

-(void)viewDidLoad
{
  [super viewDidLoad];
  
  [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

-(void)setItem:(BNRItem *)i
{
  item = i;
  [[self navigationItem] setTitle:[item itemName]];
}
-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [nameField setText:[item itemName]];
  [serialField setText:[item serialNumber]];
  [valueField setText:[NSString stringWithFormat:@"%d", [item valueInDollars]]];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
  [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  
  [dateLabel setText:[dateFormatter stringFromDate:[item dateCreated]]];
  
  NSString *imageKey = [item imageKey];
  
  if (imageKey){
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
    
    [imageView setImage:imageToDisplay];
  } else {
    [imageView setImage:nil];
  }
}

-(void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  [[self view] endEditing:YES];
  
  [item setItemName:[nameField text]];
  [item setSerialNumber:[serialField text]];
  [item setValueInDollars:[[valueField text] intValue]];
}
- (IBAction)takePicture:(id)sender {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
  {
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
  }
  else {
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  }
  
  [imagePicker setDelegate:self];
  
  [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  
  NSString *oldKey = [item imageKey];
  
  if (oldKey){
    [[BNRImageStore sharedStore] deleteImageForKey:oldKey];
  }
  UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
  
  CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
  CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
  
  NSString *key = (__bridge NSString *)newUniqueIDString;
  [item setImageKey:key];
  
  [[BNRImageStore sharedStore] setImage:image forKey:[item imageKey]];
  
  [self dismissViewControllerAnimated:YES completion:nil];
  
  CFRelease(newUniqueIDString);
  CFRelease(newUniqueID);
}
@end
