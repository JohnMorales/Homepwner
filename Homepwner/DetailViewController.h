//
//  DetailViewController.h
//  Homepwner
//
//  Created by John Morales on 3/8/13.
//  Copyright (c) 2013 John Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController
{
  __weak IBOutlet UILabel *dateLabel;
  __weak IBOutlet UITextField *valueField;
  __weak IBOutlet UITextField *serialField;
  __weak IBOutlet UITextField *nameField;
}
@property (nonatomic, strong) BNRItem *item;
@end
