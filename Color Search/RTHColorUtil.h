//
//  RTHColorUtil.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTHColorUtil : NSObject

@property (nonatomic, strong) UIImage *image;

-(id)initWithImage:(UIImage *)image;
-(void)parseColors;
- (UIColor *)averageColor;

- (UIColor*) getDominantColor;

- (UIColor*) getPixelColorAtLocation:(CGPoint)point ;


+ (NSString *)getHexStringForColor:(UIColor *)color;

@end
