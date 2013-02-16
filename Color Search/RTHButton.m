//
//  RTHButton.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation RTHButton

+(id)newRTHButton{
	CGFloat onePixel = 1 / [UIScreen mainScreen].scale;
	RTHButton *searchButton = [self buttonWithType:UIButtonTypeCustom];
	searchButton.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
	searchButton.layer.borderColor = [UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1].CGColor;
	searchButton.layer.borderWidth = onePixel;
	searchButton.layer.cornerRadius = 5;
	searchButton.layer.shadowColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1].CGColor;
	searchButton.layer.shadowOffset = CGSizeMake(0, 1);
	searchButton.layer.shadowOpacity = 0.5;
	searchButton.layer.shadowRadius = 1;
	searchButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
	searchButton.titleLabel.numberOfLines = 2;
	//	searchButton.titleLabel.shadowOffset = CGSizeMake(onePixel, onePixel);
	//	searchButton.titleLabel.shadowColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
	searchButton.titleLabel.textAlignment = UITextAlignmentCenter;
	return searchButton;
}

@end
