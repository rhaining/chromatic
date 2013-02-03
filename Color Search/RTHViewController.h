//
//  RTHViewController.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTHColorUtil.h"
#import <QuartzCore/QuartzCore.h>

@interface RTHViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
	BOOL hasPresented;
	UIImageView *imageView;
	RTHColorUtil *colorUtil;
	
	UIColor *currentColor;
//	CAGradientLayer *gradient;
}

@end
