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
	
	[self.titleLabel sizeToFit];
	
	CGRect rect = self.imageView.frame;
	rect.origin.y = CGRectGetMaxY(self.titleLabel.frame) + 10;
	self.imageView.frame = rect;
	
	[self.descriptionLabel sizeToFit];
	rect = self.descriptionLabel.frame;
	rect.origin.y = CGRectGetMaxY(self.imageView.frame) + 10;
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
