//
//  RTHCategoryView.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHCategoryView.h"
#import "RTHButton.h"

@implementation RTHCategoryView
@synthesize pickerView=_pickerView;
-(id)initWithFrame:(CGRect)frame pickerDelegateAndDataSource:(id<UIPickerViewDelegate, UIPickerViewDataSource>)delegate{
    if (self = [super initWithFrame:frame]) {
		
		self.backgroundColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:0.7];

		_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, frame.size.height-270, frame.size.width, 216)];
		self.pickerView.delegate = delegate;
		self.pickerView.dataSource = delegate;
		self.pickerView.showsSelectionIndicator = YES;
		self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
		[self addSubview:self.pickerView];
		
		RTHButton *button = [RTHButton newRTHButton];
		[button setTitle:@"Select Category" forState:UIControlStateNormal];
		button.frame = CGRectMake(10, frame.size.height - 50, frame.size.width - 20, 44);
		button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
		[button addTarget:nil action:@selector(selectCategory) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:button];
	}
    return self;
}
-(void)reloadData{
	[self.pickerView reloadAllComponents];
}

-(void)layoutSubviews{
	[super layoutSubviews];
	
}

@end
