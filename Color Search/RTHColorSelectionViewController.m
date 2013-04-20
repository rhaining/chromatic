//
//  RTHViewController.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHColorSelectionViewController.h"
#import "RTHSearchViewController.h"
#import "RTHColorHistory.h"
#import "RTHImageUtil.h"
#import "RTHButton.h"
#import "MagnifierView.h"
#import "RTHAnalytics.h"

@implementation RTHColorSelectionViewController

-(id)initWithImage:(UIImage *)image{
	if(self = [super init]){
		initialImage = image;
		
		self.title = @"Select Color";
		
		magnifierView = [[MagnifierView alloc] init];
	}
	return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];

	searchSelectedColorButton = [RTHButton newRTHButton];
	[searchSelectedColorButton addTarget:self action:@selector(searchForSelectedColor) forControlEvents:UIControlEventTouchUpInside];
	[searchSelectedColorButton setTitle:@"Search\nSelected Color" forState:UIControlStateNormal];
	searchSelectedColorButton.enabled = NO;
	[self.view addSubview:searchSelectedColorButton];
	
	searchComplementaryColorButton = [RTHButton newRTHButton];
	[searchComplementaryColorButton addTarget:self action:@selector(searchForComplementaryColor) forControlEvents:UIControlEventTouchUpInside];
	[searchComplementaryColorButton setTitle:@"Search\nComplementary Color" forState:UIControlStateNormal];
	searchComplementaryColorButton.enabled = NO;
	[self.view addSubview:searchComplementaryColorButton];
	
	if(initialImage){
		[self useImage:initialImage];
	}
	
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	CGFloat buttonWidth = 150;
	CGFloat buttonHeight = 55;
	searchSelectedColorButton.frame = CGRectMake((self.view.frame.size.width / 2.0 - buttonWidth)/2.0,
												 self.view.frame.size.height - (buttonHeight+10), buttonWidth, buttonHeight);
	searchComplementaryColorButton.frame = CGRectMake(self.view.frame.size.width / 2.0 + (self.view.frame.size.width / 2.0 - buttonWidth)/2.0,
													  self.view.frame.size.height - (buttonHeight+10), buttonWidth, buttonHeight);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGSize)maxSize{
	return CGSizeMake(self.view.frame.size.width, 300);
}
-(UIImage *)scaledImage:(UIImage *)image{
	return [RTHImageUtil scaleImage:image toSize:[self maxSize]];
}

-(void)useImage:(UIImage *)image{
	if(imageView){ [imageView removeFromSuperview]; }
	self.view.backgroundColor = [UIColor whiteColor];
	
	image = [self scaledImage:image];
	
	imageView = [[UIImageView alloc] initWithImage:image];
//	CGSize wrapper = [self maxSize];
	imageView.frame = CGRectMake((self.view.frame.size.width - image.size.width) / 2.0,
								 (self.view.frame.size.height - image.size.height - 100) / 2.0,
								 image.size.width,
								 image.size.height);
//	imageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:imageView];
	imageView.layer.borderColor = [UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1].CGColor;
	imageView.layer.borderWidth = 2;
	imageView.layer.shadowColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1].CGColor;
	imageView.layer.shadowOffset = CGSizeMake(1, 1);
	imageView.layer.shadowRadius = 2;
	imageView.layer.shadowOpacity = 0.5;
	
	UIPanGestureRecognizer *panRecog = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
	[imageView addGestureRecognizer:panRecog];
	
	UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
	[imageView addGestureRecognizer:tapRecog];
	
	imageView.userInteractionEnabled = YES;
	
	searchSelectedColorButton.enabled = YES;
	searchComplementaryColorButton.enabled = YES;
	
	magnifierView.viewToMagnify = self.view;

}
-(void)setCurrentColor:(UIColor *)color{
	currentColor = color;
	self.view.backgroundColor = currentColor;
	self.navigationController.navigationBar.tintColor = currentColor;

	[searchSelectedColorButton updateRTHTitleColor:currentColor];
	[searchComplementaryColorButton updateRTHTitleColor:[RTHColorUtil inverseColorFromColor:currentColor]];
//	[searchSelectedColorButton setTitleColor:currentColor forState:UIControlStateNormal];
//	[searchComplementaryColorButton setTitleColor:[RTHColorUtil inverseColorFromColor:currentColor] forState:UIControlStateNormal];

}
-(void)updateWithColorAtPoint:(CGPoint)point{
	UIColor *color = [RTHColorUtil colorAtPoint:point inView:imageView];
	[self setCurrentColor:color];
/*
	if(!gradient){
		gradient = [CAGradientLayer layer];
		CGFloat y = CGRectGetMaxY(imageView.frame);
		gradient.frame = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height-y);
		gradient.locations = @[@(0), @(1)];
		gradient.startPoint = CGPointMake(0, 0.5);
		gradient.endPoint = CGPointMake(1, 0.5);
		[self.view.layer addSublayer:gradient];
	}
	gradient.colors = @[(id)[self minimumColor].CGColor, (id)[self maximumColor].CGColor];
	*/
}
-(void)didTap:(UITapGestureRecognizer *)recog{
	[self updateWithColorAtPoint:[recog locationInView:imageView]];
}
-(void)didPan:(UIPanGestureRecognizer *)recog{
	switch (recog.state) {
		case UIGestureRecognizerStateBegan:
			[self.view addSubview:magnifierView];
		case UIGestureRecognizerStateChanged:
		{
			CGPoint point = [recog locationInView:imageView];
			if(point.x < 0 || point.y < 0 || point.x > CGRectGetWidth(imageView.frame) || point.y > CGRectGetHeight(imageView.frame)){
				magnifierView.hidden = YES;
				break;
			}
		}
			magnifierView.hidden = NO;
			magnifierView.touchPoint = [recog locationInView:self.view];
			[magnifierView setNeedsDisplay];
			
			[self updateWithColorAtPoint:[recog locationInView:imageView]];
			break;
		case UIGestureRecognizerStateEnded:
		case UIGestureRecognizerStateCancelled:
		case UIGestureRecognizerStateFailed:
			[magnifierView removeFromSuperview];
			break;
		default:
			break;
	}
}
/*
-(UIColor *)colorWithOffsetPositive:(BOOL)positive{
	CGFloat red,green,blue,alpha;
	[currentColor getRed:&red green:&green blue:&blue alpha:&alpha];
	CGFloat offset=100/255.0;
	offset *= positive ? 1 : -1;
	UIColor *color = [UIColor colorWithRed:red-offset green:green-offset blue:blue-offset alpha:alpha];
	return color;
}
-(UIColor *)minimumColor{
	return [self colorWithOffsetPositive:NO];
}
-(UIColor *)maximumColor{
	return [self colorWithOffsetPositive:YES];
}
 */
-(void)searchForSelectedColor{
	[self searchForColor:currentColor];
	[RTHAnalytics logSearchSelectedColor];
}
-(void)searchForComplementaryColor{
	UIColor *inverseColor = [RTHColorUtil inverseColorFromColor:currentColor];
	self.navigationController.navigationBar.tintColor = inverseColor;
	[self searchForColor:inverseColor];
	[RTHAnalytics logSearchComplementaryColor];
}
-(void)searchForColor:(UIColor *)color{
//	UIColor *color = self.view.backgroundColor;
	/*
	UIColor *minColor = [self minimumColor];
	UIColor *maxColor = [self maximumColor];
	NSString *minHexString = [RTHColorUtil getHexStringForColor:minColor];
	NSString *maxHexString = [RTHColorUtil getHexStringForColor:maxColor];
//	NSLog(@"hex = %@", hexString);
	NSString *rangeString = [NSString stringWithFormat:@"#%@-#%@", minHexString, maxHexString];
	 */
	NSString *hex = [RTHColorUtil getHexStringForColor:color];
	RTHSearchViewController *vc = [[RTHSearchViewController alloc] initWithColorHex:hex];
	[self.navigationController pushViewController:vc animated:YES];
	
	[RTHColorHistory addColorHex:hex];
}



@end
