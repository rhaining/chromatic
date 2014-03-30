//
//  RTHListingCell.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHListingCell.h"
#import "UIImageView+AFNetworking.h"

#define TITLE_FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:14]
#define DESCRIPTION_FONT [UIFont fontWithName:@"HelveticaNeue" size:12]
#define MARGIN 10
#define IMG_SIZE CGSizeMake(170,135)
#define PRICE_WIDTH 60

@implementation RTHListingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.textLabel.numberOfLines = 0;
		self.textLabel.font = TITLE_FONT;
		
		self.detailTextLabel.font = DESCRIPTION_FONT;
		
		self.selectionStyle = UITableViewCellSelectionStyleGray;
		
		self.listingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IMG_SIZE.width, IMG_SIZE.height)];
		self.listingImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.listingImageView.backgroundColor = [UIColor colorWithWhite:230/255.0 alpha:1];
		[self.contentView addSubview:self.listingImageView];
    }
    return self;
}

-(void)setImageURL:(NSURL *)imageURL{
	if(![self.imageURL isEqual:imageURL]){
		_imageURL = imageURL;
		if(imageURL){
			self.listingImageView.image = nil;
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.listingImageView setImageWithURL:imageURL];
			});
		}else{
			self.listingImageView.image = nil;
		}
	}
}


- (void)layoutSubviews {
    [super layoutSubviews];

	self.listingImageView.frame = CGRectMake(0, 0, IMG_SIZE.width, IMG_SIZE.height);

	CGRect rect = CGRectZero;
	rect.origin.x = CGRectGetMaxX(self.listingImageView.frame) + MARGIN;
	rect.origin.y = MARGIN;
	rect.size.width = self.contentView.frame.size.width - rect.origin.x - MARGIN;
	rect.size.height = [self.textLabel sizeThatFits:CGSizeMake(rect.size.width, 1000)].height;
	rect.size.height = MIN(rect.size.height, IMG_SIZE.height - [self.detailTextLabel.font lineHeight] - MARGIN * 2);
	self.textLabel.frame = rect;
	
	rect = CGRectZero;
	rect.origin.x = self.textLabel.frame.origin.x;
	rect.origin.y = CGRectGetMaxY(self.textLabel.frame);
	rect.size.width = self.textLabel.frame.size.width;
	rect.size.height = [self.detailTextLabel.font lineHeight];
	self.detailTextLabel.frame = rect;
	
}

+(CGFloat)heightForText:(NSString *)text{
	CGFloat imgHeight = IMG_SIZE.height;
    return imgHeight;
}

@end





