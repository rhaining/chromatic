//
//  RTHPriceView.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 9/20/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHPriceView.h"

@implementation RTHPriceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 15)];
		label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
		label.text = @"$0–";
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		
		
		UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 60, 25)];
		minLabel.text = @"Minimum";
		minLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
		[self addSubview:minLabel];
		
		_minimumSlider = [[UISlider alloc] initWithFrame:CGRectMake(70, 20, 200, 25)];
		self.minimumSlider.minimumValue = 0;
		self.minimumSlider.maximumValue = 1000;
		self.minimumSlider.value = 0;
		[self.minimumSlider addTarget:self action:@selector(updateRangeLabel:) forControlEvents:UIControlEventValueChanged];
		[self addSubview:self.minimumSlider];
		
		UILabel *maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 60, 25)];
		maxLabel.text = @"Maximum";
		maxLabel.font = minLabel.font;
		[self addSubview:maxLabel];
		
		_maximumSlider = [[UISlider alloc] initWithFrame:CGRectMake(70, 60, 200, 25)];
		self.maximumSlider.minimumValue = 0;
		self.maximumSlider.maximumValue = 1000;
		self.maximumSlider.value = 1000;
		[self.maximumSlider addTarget:self action:@selector(updateRangeLabel:) forControlEvents:UIControlEventValueChanged];
		[self addSubview:self.maximumSlider];
	}
    return self;
}


-(void)updateRangeLabel:(UISlider *)sender{
	if(sender == self.minimumSlider){
		if(self.minimumPrice > self.maximumPrice){
			self.maximumPrice = self.minimumPrice;
		}
	}
	if(sender == self.maximumSlider){
		if(self.maximumPrice < self.minimumPrice){
			self.minimumPrice = self.maximumPrice;
		}
	}
	if(self.maximumPrice == self.maximumSlider.maximumValue){
		label.text = [NSString stringWithFormat:@"$%ld–", (long)self.minimumPrice];
	}else{
		label.text = [NSString stringWithFormat:@"$%ld–%ld", (long)self.minimumPrice, (long)self.maximumPrice];
	}
}
-(void)setMinimumPrice:(NSInteger)minimumPrice{
	self.minimumSlider.value = minimumPrice;
	[self updateRangeLabel:nil];
}
-(void)setMaximumPrice:(NSInteger)maximumPrice{
	if(maximumPrice){
		self.maximumSlider.value = maximumPrice;
		[self updateRangeLabel:nil];
	}
}
-(NSInteger)minimumPrice{
	return round(self.minimumSlider.value);
}
-(NSInteger)maximumPrice{
	return round(self.maximumSlider.value);
}

@end
