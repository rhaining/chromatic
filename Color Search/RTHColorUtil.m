//
//  RTHColorUtil.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHColorUtil.h"
#import <CoreImage/CoreImage.h>

@implementation RTHColorUtil

-(id)initWithImage:(UIImage *)image{
	if(self = [super init]){
		self.image = image;
		/*
		CIImage *rawImage = [CIImage imageWithCGImage:image.CGImage];
		CGRect rect = CGRectZero;
		rect.size = CGSizeMake(100, 100);
		rect.origin.x = (image.size.width - rect.size.width) / 2.0;
		rect.origin.y = (image.size.height - rect.size.height) / 2.0;
		CIImage *croppedImage = [rawImage imageByCroppingToRect:rect];
//		self.image = [UIImage imageWithCIImage:croppedImage];

		CIContext *context = [CIContext contextWithOptions:nil];
		CGImageRef cgImage = [context createCGImage:croppedImage fromRect:[croppedImage extent]];
		self.image = [UIImage imageWithCGImage:cgImage];

		CGImageRelease(cgImage);
		 */
	}
	return self;
}


//http://www.bobbygeorgescu.com/2011/08/finding-average-color-of-uiimage/
- (UIColor *)averageColor {
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.image.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
	
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

-(void)parseColors{
	for(int y=0; y < self.image.size.height; y++){
		for(int x=0; x < self.image.size.width; x++){
			CGPoint point = CGPointMake(x, y);
			UIColor *color = [self getPixelColorAtLocation:point];
			NSLog(@"color = %@", color);
		}
	}
}

- (UIColor*) getPixelColorAtLocation:(CGPoint)point {
	UIColor* color = nil;
	CGImageRef inImage = self.image.CGImage;
	// Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
	CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
	if (cgctx == NULL) { return nil; /* error */ }
	
    size_t w = CGImageGetWidth(inImage);
	size_t h = CGImageGetHeight(inImage);
	CGRect rect = {{0,0},{w,h}};
	
	// Draw the image to the bitmap context. Once we draw, the memory
	// allocated for the context for rendering will then contain the
	// raw image data in the specified color space.
	CGContextDrawImage(cgctx, rect, inImage);
	
	// Now we can get a pointer to the image data associated with the bitmap
	// context.
	unsigned char* data = CGBitmapContextGetData (cgctx);
	if (data != NULL) {
		//offset locates the pixel in the data from x,y.
		//4 for 4 bytes of data per pixel, w is width of one row of data.
		int offset = 4*((w*round(point.y))+round(point.x));
		int alpha =  data[offset];
		int red = data[offset+1];
		int green = data[offset+2];
		int blue = data[offset+3];
//		NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
		color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
	}
	
	// When finished, release the context
	CGContextRelease(cgctx);
	// Free image data memory for the context
	if (data) { free(data); }
	
	return color;
}

- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
	
	CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	void *          bitmapData;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	// Get image width, height. We'll use the entire image.
	size_t pixelsWide = CGImageGetWidth(inImage);
	size_t pixelsHigh = CGImageGetHeight(inImage);
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow   = (pixelsWide * 4);
	bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
	
	// Use the generic RGB color space.
	colorSpace = CGColorSpaceCreateDeviceRGB();
	if (colorSpace == NULL)
	{
		fprintf(stderr, "Error allocating color space\n");
		return NULL;
	}
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	bitmapData = malloc( bitmapByteCount );
	if (bitmapData == NULL)
	{
		fprintf (stderr, "Memory not allocated!");
		CGColorSpaceRelease( colorSpace );
		return NULL;
	}
	
	// Create the bitmap context. We want pre-multiplied ARGB, 8-bits
	// per component. Regardless of what the source image format is
	// (CMYK, Grayscale, and so on) it will be converted over to the format
	// specified here by CGBitmapContextCreate.
	context = CGBitmapContextCreate (bitmapData,
									 pixelsWide,
									 pixelsHigh,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaPremultipliedFirst);
	if (context == NULL)
	{
		free (bitmapData);
		fprintf (stderr, "Context not created!");
	}
	
	// Make sure and release colorspace before returning
	CGColorSpaceRelease( colorSpace );
	
	return context;
}





//http://stackoverflow.com/questions/5562095/average-color-value-of-uiimage-in-objective-c

struct pixel {
    unsigned char r, g, b, a;
};

- (UIColor*) getDominantColor{
    NSUInteger red = 0;
    NSUInteger green = 0;
    NSUInteger blue = 0;
	
	UIImage *image = self.image;
	
	
    // Allocate a buffer big enough to hold all the pixels
	
    struct pixel* pixels = (struct pixel*) calloc(1, image.size.width * image.size.height * sizeof(struct pixel));
    if (pixels != nil)
    {
		
        CGContextRef context = CGBitmapContextCreate(
													 (void*) pixels,
													 image.size.width,
													 image.size.height,
													 8,
													 image.size.width * 4,
													 CGImageGetColorSpace(image.CGImage),
													 kCGImageAlphaPremultipliedLast
													 );
		
        if (context != NULL)
        {
            // Draw the image in the bitmap
			
            CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), image.CGImage);
			
            // Now that we have the image drawn in our own buffer, we can loop over the pixels to
            // process it. This simple case simply counts all pixels that have a pure red component.
			
            // There are probably more efficient and interesting ways to do this. But the important
            // part is that the pixels buffer can be read directly.
			
            NSUInteger numberOfPixels = image.size.width * image.size.height;
            for (int i=0; i<numberOfPixels; i++) {
                red += pixels[i].r;
                green += pixels[i].g;
                blue += pixels[i].b;
            }
			
			
            red /= numberOfPixels;
            green /= numberOfPixels;
            blue/= numberOfPixels;
			
			
            CGContextRelease(context);
        }
		
        free(pixels);
    }
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
}

+ (NSString *)getHexStringForColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
	
    return [NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
}
@end
