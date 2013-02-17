//
//  RTHListingView.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHListingView.h"
#import "RTHButton.h"

@implementation RTHListingView

#define kNMSidePadding 10

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
		self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
		
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kNMSidePadding, kNMSidePadding, frame.size.width - kNMSidePadding*2, 50)];
		self.titleLabel.backgroundColor = self.backgroundColor;
		self.titleLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:20];
		self.titleLabel.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
		self.titleLabel.numberOfLines = 0;
		[self addSubview:self.titleLabel];
		
		_priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kNMSidePadding, kNMSidePadding, frame.size.width - kNMSidePadding*2, 20)];
		self.priceLabel.backgroundColor = self.backgroundColor;
		self.priceLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:15];
		self.priceLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
		[self addSubview:self.priceLabel];
		
		_bylineLabel = [[UILabel alloc] initWithFrame:CGRectMake(kNMSidePadding, 0, frame.size.width - kNMSidePadding * 2, 30)];
		self.bylineLabel.backgroundColor = self.backgroundColor;
		self.bylineLabel.font = [UIFont fontWithName:@"Georgia" size:14];
		self.bylineLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
		self.bylineLabel.numberOfLines = 0;
		[self addSubview:self.bylineLabel];
		
		_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kNMSidePadding, 0, frame.size.width - kNMSidePadding*2, 300)];
		self.imageView.backgroundColor = self.backgroundColor;
		self.imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:self.imageView];
		
		_descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kNMSidePadding, 0, frame.size.width - kNMSidePadding*2, 50)];
		self.descriptionLabel.backgroundColor = self.backgroundColor;
		self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
		self.descriptionLabel.textColor = [UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1];
		self.descriptionLabel.numberOfLines = 0;
		[self addSubview:self.descriptionLabel];
		
    }
    return self;
}

-(void)layoutSubviews{
	[super layoutSubviews];
	
	[self.priceLabel sizeToFit];
	CGRect rect = self.priceLabel.frame;
	rect.origin.x = self.frame.size.width - kNMSidePadding - rect.size.width;
	self.priceLabel.frame = rect;
	
	rect = self.titleLabel.frame;
	rect.size.width = CGRectGetMinX(self.priceLabel.frame) - kNMSidePadding * 2;
	rect.size.height = [self.titleLabel sizeThatFits:CGSizeMake(rect.size.width, 1000)].height;
	self.titleLabel.frame = rect;
	
	[self.bylineLabel sizeToFit];
	rect = self.bylineLabel.frame;
	rect.origin.y = CGRectGetMaxY(self.titleLabel.frame) + 5;
	self.bylineLabel.frame = rect;
	
	rect = self.imageView.frame;
	rect.origin.y = CGRectGetMaxY(self.bylineLabel.frame) + 5;
	self.imageView.frame = rect;
	
	[self.descriptionLabel sizeToFit];
	rect = self.descriptionLabel.frame;
	rect.origin.y = CGRectGetMaxY(self.imageView.frame) + 5;
	self.descriptionLabel.frame = rect;
	
	self.contentSize = CGSizeMake(self.frame.size.width, CGRectGetMaxY(self.descriptionLabel.frame) + 75);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
