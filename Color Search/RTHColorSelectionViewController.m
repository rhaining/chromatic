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
#import "RTHButton.h"
#import "MagnifierView.h"
#import "RTHAnalytics.h"
#import "RTHColorSelectionView.h"

@interface RTHColorSelectionViewController()
@property (nonatomic, strong) RTHColorSelectionView *colorSelectionView;
@end

@implementation RTHColorSelectionViewController

-(id)initWithImage:(UIImage *)image{
	if(self = [super init]){
		initialImage = image;
		self.title = @"Select Color";
	}
	return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.colorSelectionView = [[RTHColorSelectionView alloc] initWithFrame:self.view.bounds];
    self.colorSelectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.colorSelectionView.searchSelectedColorButton addTarget:self action:@selector(searchForSelectedColor) forControlEvents:UIControlEventTouchUpInside];
    [self.colorSelectionView.searchComplementaryColorButton addTarget:self action:@selector(searchForComplementaryColor) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer *panRecog = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
	[self.colorSelectionView.imageView addGestureRecognizer:panRecog];
	
	UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
	[self.colorSelectionView.imageView addGestureRecognizer:tapRecog];

    [self.view addSubview:self.colorSelectionView];

	
	if(initialImage){
		[self.colorSelectionView useImage:initialImage];
        
		magnifierView = [[MagnifierView alloc] init];
        magnifierView.viewToMagnify = self.colorSelectionView;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setCurrentColor:(UIColor *)color{
	currentColor = color;
	self.colorSelectionView.selectedColorSwatch.backgroundColor = currentColor;
	self.navigationController.navigationBar.barTintColor = currentColor;
	
	UIColor *inverseColor = [RTHColorUtil inverseColorFromColor:currentColor];

    self.navigationController.navigationBar.tintColor = inverseColor;
    self.colorSelectionView.complementaryColorSwatch.backgroundColor = inverseColor;
}
-(void)updateWithColorAtPoint:(CGPoint)point{
	UIColor *color = [RTHColorUtil colorAtPoint:point inView:self.colorSelectionView.imageView];
	[self setCurrentColor:color];
}
-(void)didTap:(UITapGestureRecognizer *)recog{
	[self updateWithColorAtPoint:[recog locationInView:self.colorSelectionView.imageView]];
}
-(void)didPan:(UIPanGestureRecognizer *)recog{
	switch (recog.state) {
		case UIGestureRecognizerStateBegan:
			[self.colorSelectionView addSubview:magnifierView];
		case UIGestureRecognizerStateChanged:
		{
			CGPoint point = [recog locationInView:self.colorSelectionView.imageView];
			if(point.x < 0 || point.y < 0 || point.x > CGRectGetWidth(self.colorSelectionView.imageView.frame) || point.y > CGRectGetHeight(self.colorSelectionView.imageView.frame)){
				magnifierView.hidden = YES;
				break;
			}
		}
			magnifierView.hidden = NO;
			magnifierView.touchPoint = [recog locationInView:self.colorSelectionView];
			[magnifierView setNeedsDisplay];
			
			[self updateWithColorAtPoint:[recog locationInView:self.colorSelectionView.imageView]];
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

-(void)searchForSelectedColor{
	if(currentColor){
		[self searchForColor:currentColor];
        UIColor *inverseColor = [RTHColorUtil inverseColorFromColor:currentColor];
        [[UIApplication sharedApplication] keyWindow].tintColor = inverseColor;
		[RTHAnalytics logSearchSelectedColor];
	}else{
		[[[UIAlertView alloc] initWithTitle:nil message:@"Please select a color." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"okay", nil] show];
	}
}
-(void)searchForComplementaryColor{
	if(currentColor){
        UIColor *inverseColor = [RTHColorUtil inverseColorFromColor:currentColor];
        self.navigationController.navigationBar.barTintColor = inverseColor;
        self.navigationController.navigationBar.tintColor = currentColor;
        [[UIApplication sharedApplication] keyWindow].tintColor = currentColor;

        [self searchForColor:inverseColor];
        [RTHAnalytics logSearchComplementaryColor];
    }else{
        [[[UIAlertView alloc] initWithTitle:nil message:@"Please select a color." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"okay", nil] show];
    }
}
-(void)searchForColor:(UIColor *)color{
	NSString *hex = [RTHColorUtil getHexStringForColor:color];
	RTHSearchViewController *vc = [[RTHSearchViewController alloc] initWithColorHex:hex];
	[self.navigationController pushViewController:vc animated:YES];
	
	[RTHColorHistory addColorHex:hex];
}



@end
