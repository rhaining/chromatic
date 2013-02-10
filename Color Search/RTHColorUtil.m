//
//  RTHColorUtil.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHColorUtil.h"
#import <QuartzCore/QuartzCore.h>

@implementation RTHColorUtil

+ (NSString *)getHexStringForColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
	
    return [NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
}


//https://github.com/ivanzoid/ikit/tree/master/UIView+ColorOfPoint
+(UIColor *)colorAtPoint:(CGPoint)point inView:(UIView *)view{
	unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
	
    CGContextTranslateCTM(context, -point.x, -point.y);
	
    [view.layer renderInContext:context];
	
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
	
    //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
	
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
	
    return color;

}


//adapted from http://stackoverflow.com/questions/5893261/how-to-get-inverse-color-from-uicolor
+(UIColor *)inverseColorFromColor:(UIColor *)color{
	if(!color){
		return nil;
	}
	// oldColor is the UIColor to invert
	const CGFloat *componentColors = CGColorGetComponents(color.CGColor);
	
	UIColor *newColor = [[UIColor alloc] initWithRed:(1 - componentColors[0])
											   green:(1 - componentColors[1])
												blue:(1 - componentColors[2])
											   alpha:componentColors[3]];
	return newColor;
	
}
@end
