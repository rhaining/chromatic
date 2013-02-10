//
//  RTHImageUtil.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/10/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTHImageUtil : NSObject

+ (UIImage *)fixOrientationForImage:(UIImage *)image;

+(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)maxSize;

@end
