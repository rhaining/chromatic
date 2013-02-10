//
//  RTHViewController.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHViewController.h"
#import "RTHSearchViewController.h"
#import "RTHColorHistory.h"
#import "RTHImageUtil.h"
#import "RTHAboutViewController.h"

@interface RTHViewController ()

@end

@implementation RTHViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New Image" style:UIBarButtonItemStyleBordered target:self action:@selector(presentImageOptions)];

	self.navigationItem.rightBarButtonItems = @[
											   [[UIBarButtonItem alloc] initWithTitle:@"History" style:UIBarButtonItemStyleBordered target:self action:@selector(presentHistory)],
											   [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStyleBordered target:self action:@selector(presentAbout)]]
											   ;

	searchSelectedColorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[searchSelectedColorButton addTarget:self action:@selector(searchForSelectedColor) forControlEvents:UIControlEventTouchUpInside];
	[searchSelectedColorButton setTitle:@"Search »" forState:UIControlStateNormal];
	searchSelectedColorButton.enabled = NO;
	[self.view addSubview:searchSelectedColorButton];
	
	searchComplementaryColorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[searchComplementaryColorButton addTarget:self action:@selector(searchForComplementaryColor) forControlEvents:UIControlEventTouchUpInside];
	[searchComplementaryColorButton setTitle:@"Search »" forState:UIControlStateNormal];
	searchComplementaryColorButton.enabled = NO;
	[self.view addSubview:searchComplementaryColorButton];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	searchSelectedColorButton.frame = CGRectMake((self.view.frame.size.width / 2.0 - 100)/2.0, self.view.frame.size.height - 54, 100, 44);
	searchComplementaryColorButton.frame = CGRectMake(self.view.frame.size.width / 2.0 + (self.view.frame.size.width / 2.0 - 100)/2.0, self.view.frame.size.height - 54, 100, 44);
}

-(void)selectNewImage:(UIImagePickerControllerSourceType)sourceType{
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = sourceType;
	imagePicker.delegate = self;
	[self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)presentPhotoAlbum{
	[self selectNewImage:UIImagePickerControllerSourceTypePhotoLibrary];
}
-(void)presentCamera{
	[self selectNewImage:UIImagePickerControllerSourceTypeCamera];
}
-(void)presentImageOptions{
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
		UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Select your option" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Album", nil];
		[sheet showInView:self.view];
	}else{
		[self presentPhotoAlbum];
	}
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	switch (buttonIndex) {
		case 0:
			[self presentCamera];
			break;
		case 1:
			[self presentPhotoAlbum];
			break;
		default:
			[self presentImageOptions];
			break;
	}
}
/*
-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	if(hasPresented){
		return;
	}
	hasPresented = YES;
	[self presentImageOptions];
}
*/
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
								 (self.view.frame.size.height - image.size.height - 30) / 2.0,
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
	

}
-(void)setCurrentColor:(UIColor *)color{
	currentColor = color;
	self.view.backgroundColor = currentColor;
	self.navigationController.navigationBar.tintColor = currentColor;

	[searchSelectedColorButton setTitleColor:currentColor forState:UIControlStateNormal];
	[searchComplementaryColorButton setTitleColor:[RTHColorUtil inverseColorFromColor:currentColor] forState:UIControlStateNormal];

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
-(void)searchForSelectedColor{
	[self searchForColor:currentColor];
}
-(void)searchForComplementaryColor{
	UIColor *inverseColor = [RTHColorUtil inverseColorFromColor:currentColor];
	self.navigationController.navigationBar.tintColor = inverseColor;
	[self searchForColor:inverseColor];
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

#pragma mark - uiimagepickercontrollerdelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//	NSLog(@"info = %@", info);
	UIImage *image = info[UIImagePickerControllerOriginalImage];
	image = [RTHImageUtil fixOrientationForImage:image];
	[self useImage:image];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[self dismissViewControllerAnimated:YES completion:nil];	
}


-(void)presentHistory{
	RTHColorHistoryViewController *vc = [[RTHColorHistoryViewController alloc] initWithStyle:UITableViewStylePlain];
	vc.delegate = self;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
	[self presentViewController:nav animated:YES completion:nil];
}

-(void)presentAbout{
	RTHAboutViewController *vc = [[RTHAboutViewController alloc] init];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
	[self presentViewController:nav animated:YES completion:nil];	
}

#pragma mark color history delegate
-(void)colorHistoryViewController:(RTHColorHistoryViewController *)viewController didSelectColor:(UIColor *)color{
	[imageView removeFromSuperview];
	[viewController dismissViewControllerAnimated:YES completion:nil];
	[self setCurrentColor:color];
	[self searchForColor:color];
}


@end
