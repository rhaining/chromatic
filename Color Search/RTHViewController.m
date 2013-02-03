//
//  RTHViewController.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHViewController.h"
#import "RTHSearchViewController.h"

@interface RTHViewController ()

@end

@implementation RTHViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New Image" style:UIBarButtonItemStyleBordered target:self action:@selector(selectNewImage)];

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(searchForColor)];

}
-(void)selectNewImage{
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	[self presentViewController:imagePicker animated:YES completion:nil];

}
-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	if(hasPresented){
		return;
	}
	hasPresented = YES;
	[self selectNewImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)useImage:(UIImage *)image{
	if(imageView){ [imageView removeFromSuperview]; }
	self.view.backgroundColor = [UIColor whiteColor];
	
	imageView = [[UIImageView alloc] initWithImage:image];
	imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:imageView];
	imageView.layer.borderColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1].CGColor;
	imageView.layer.borderWidth = 4;
	
	UIPanGestureRecognizer *panRecog = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
	[imageView addGestureRecognizer:panRecog];
	
	UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
	[imageView addGestureRecognizer:tapRecog];
	
	imageView.userInteractionEnabled = YES;
	
	colorUtil = [[RTHColorUtil alloc] initWithImage:image];
	
	/*
	RTHColorUtil *colorUtil = [[RTHColorUtil alloc] initWithImage:image];
	imageView.image = colorUtil.image;
	UIColor *color = [colorUtil getDominantColor];
	self.view.backgroundColor = color;
//	[colorUtil parseColors];
	 */
}
-(void)updateWithColorAtPoint:(CGPoint)point{
	CGFloat horizontalScale = colorUtil.image.size.width / imageView.frame.size.width;
	CGFloat verticalScale = colorUtil.image.size.height / imageView.frame.size.height;
//	NSLog(@"scale = %f, %f", horizontalScale, verticalScale);
	
	CGFloat scale = MAX(horizontalScale, verticalScale);
	point.x *= scale;
	point.y *= scale;
	currentColor = [colorUtil getPixelColorAtLocation:point];
	self.view.backgroundColor = currentColor;
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
	self.navigationController.navigationBar.tintColor = currentColor;
}
-(void)didTap:(UITapGestureRecognizer *)recog{
	[self updateWithColorAtPoint:[recog locationInView:imageView]];
}
-(void)didPan:(UIPanGestureRecognizer *)recog{
	switch (recog.state) {
		case UIGestureRecognizerStateBegan:
		case UIGestureRecognizerStateChanged:
			[self updateWithColorAtPoint:[recog locationInView:imageView]];
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
-(void)searchForColor{
//	UIColor *color = self.view.backgroundColor;
	/*
	UIColor *minColor = [self minimumColor];
	UIColor *maxColor = [self maximumColor];
	NSString *minHexString = [RTHColorUtil getHexStringForColor:minColor];
	NSString *maxHexString = [RTHColorUtil getHexStringForColor:maxColor];
//	NSLog(@"hex = %@", hexString);
	NSString *rangeString = [NSString stringWithFormat:@"#%@-#%@", minHexString, maxHexString];
	 */
	NSString *hex = [RTHColorUtil getHexStringForColor:currentColor];
	RTHSearchViewController *vc = [[RTHSearchViewController alloc] initWithColorHex:hex];
	[self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - uiimagepickercontrollerdelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//	NSLog(@"info = %@", info);
	UIImage *image = info[UIImagePickerControllerOriginalImage];
	[self useImage:image];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	
}

@end
