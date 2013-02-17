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
#import "RTHColorHistoryViewController.h"

@class MagnifierView;

@interface RTHColorSelectionViewController : UIViewController {
	BOOL hasPresented;
	UIImageView *imageView;
	
	UIColor *currentColor;
//	CAGradientLayer *gradient;
	
	UIButton *searchSelectedColorButton;
	UIButton *searchComplementaryColorButton;

	UIImage *initialImage;
	
	MagnifierView *magnifierView;
}

-(id)initWithImage:(UIImage *)image;

@end
