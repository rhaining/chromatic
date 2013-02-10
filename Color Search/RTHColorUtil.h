//
//  RTHColorUtil.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTHColorUtil : NSObject

+ (NSString *)getHexStringForColor:(UIColor *)color;
+(UIColor *)colorAtPoint:(CGPoint)point inView:(UIView *)view;
+(UIColor *)inverseColorFromColor:(UIColor *)color;

@end
