//
//  ImageViewController.h
//  Homepwner
//
//  Created by John Morales on 5/7/13.
//  Copyright (c) 2013 John Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController 
{
  __weak IBOutlet UIScrollView *scrollView;
  __weak IBOutlet UIImageView *imageView;

}
@property (nonatomic, strong) UIImage *image;
@end
