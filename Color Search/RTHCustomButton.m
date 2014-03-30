//
//  RTHCustomButton.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 3/30/14.
//  Copyright (c) 2014 Robert Tolar Haining. All rights reserved.
//

#import "RTHCustomButton.h"

@implementation RTHCustomButton

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    UIImage *image = [self imageForState:UIControlStateNormal];
    CGRect rect = contentRect;
    rect.size.width -= image.size.width;
    return rect;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    UIImage *image = [self imageForState:UIControlStateNormal];
    CGSize size = image.size;
    CGRect rect = CGRectZero;
    rect.size = size;
    rect.origin.x = CGRectGetWidth(contentRect) - CGRectGetWidth(rect);
    rect.origin.y = (CGRectGetHeight(contentRect) - CGRectGetHeight(rect)) / 2.0;
    return rect;
}

@end
