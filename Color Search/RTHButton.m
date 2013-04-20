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

+(UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius{
	CGRect rect = CGRectMake(0, 0, 10, 10);
	CALayer *layer = [CALayer new];
	layer.backgroundColor = color.CGColor;
	layer.cornerRadius = cornerRadius;
	layer.frame = rect;
	UIGraphicsBeginImageContextWithOptions([layer frame].size, NO, 0);
	[layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return [img stretchableImageWithLeftCapWidth:5 topCapHeight:5];
}

+(id)newRTHButton{
	CGFloat onePixel = 1 / [UIScreen mainScreen].scale;
	RTHButton *searchButton = [self buttonWithType:UIButtonTypeCustom];
	[searchButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1] cornerRadius:5] forState:UIControlStateNormal];
	[searchButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] cornerRadius:5] forState:UIControlStateHighlighted];
	[searchButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] cornerRadius:5] forState:UIControlStateSelected];
	searchButton.titleLabel.shadowColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
	searchButton.titleLabel.shadowOffset = CGSizeMake(0, onePixel);

	[searchButton setTitleColor:[UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1] forState:UIControlStateDisabled];
//	searchButton.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
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
	searchButton.titleLabel.textAlignment = NSTextAlignmentCenter;
	return searchButton;
}

-(void)updateRTHTitleColor:(UIColor *)color{
	[self setTitleColor:color forState:UIControlStateNormal];
	
	CGFloat red,green,blue,alpha;
	[color getRed:&red green:&green blue:&blue alpha:&alpha];
	CGFloat offset = 0.3;
	red -= offset;
	green -= offset;
	blue -= offset;
	red = MAX(0,red);
	green = MAX(0,green);
	blue = MAX(0,blue);
	self.titleLabel.shadowColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
