//
//  MagnifierView.m
//  SimplerMaskTest
//
// adapted from http://coffeeshopped.com/2010/03/a-simpler-magnifying-glass-loupe-view-for-the-iphone
//

#import "MagnifierView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MagnifierView
@synthesize viewToMagnify, touchPoint;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:CGRectMake(0, 0, 50, 50)]) {
		// make the circle-shape outline with a nice border.
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 2;
		self.layer.cornerRadius = 25;
		self.layer.masksToBounds = YES;
	}
	return self;
}

- (void)setTouchPoint:(CGPoint)pt {
	touchPoint = pt;
	// whenever touchPoint is set,
	// update the position of the magnifier (to just above what's being magnified)
//	self.center = CGPointMake(pt.x, pt.y-60);
	self.center = touchPoint;
}

- (void)drawRect:(CGRect)rect {
	// here we're just doing some transforms on the view we're magnifying,
	// and rendering that view directly into this view,
	// rather than the previous method of copying an image.
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context,1*(self.frame.size.width*0.5),1*(self.frame.size.height*0.5));
	CGContextScaleCTM(context, 1.5, 1.5);
	CGContextTranslateCTM(context,-1*(touchPoint.x),-1*(touchPoint.y));
	[self.viewToMagnify.layer renderInContext:context];
}


@end
