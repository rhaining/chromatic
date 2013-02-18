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
//		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		self.textLabel.numberOfLines = 0;
		self.textLabel.font = TITLE_FONT;
		
		self.detailTextLabel.font = DESCRIPTION_FONT;
		
		self.selectionStyle = UITableViewCellSelectionStyleGray;
		
		self.listingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IMG_SIZE.width, IMG_SIZE.height)];
		self.listingImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self.contentView addSubview:self.listingImageView];
    }
    return self;
}

-(void)setImageURL:(NSURL *)imageURL{
	if(![self.imageURL isEqual:imageURL]){
		_imageURL = imageURL;
		if(imageURL){
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.listingImageView setImageWithURL:imageURL];
			});
		}else{
			self.imageView.image = nil;
		}
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews {
    [super layoutSubviews];

	/*
	self.detailTextLabel.frame = CGRectMake(self.contentView.frame.size.width - MARGIN - PRICE_WIDTH, MARGIN, PRICE_WIDTH, 14);
    self.detailTextLabel.textAlignment = UITextAlignmentRight;
	
    self.textLabel.frame = CGRectMake(MARGIN, MARGIN, self.detailTextLabel.frame.origin.x - MARGIN * 2, 100);
	[self.textLabel sizeToFit];
	
    self.listingImageView.frame = CGRectMake(MARGIN, CGRectGetMaxY(self.textLabel.frame) + MARGIN,
									  self.contentView.frame.size.width - MARGIN*2, IMG_HEIGHT);
    */
	
	self.listingImageView.frame = CGRectMake(MARGIN, MARGIN, IMG_SIZE.width, IMG_SIZE.height);

	CGRect rect = CGRectZero;
	rect.origin.x = CGRectGetMaxX(self.listingImageView.frame) + MARGIN;
	rect.origin.y = MARGIN;
	rect.size.width = self.contentView.frame.size.width - rect.origin.x - MARGIN;
//	rect.size.height = self.contentView.frame.size.height - MARGIN * 2;
	rect.size.height = [self.textLabel sizeThatFits:CGSizeMake(rect.size.width, 1000)].height;
	rect.size.height = MIN(rect.size.height, IMG_SIZE.height - [self.detailTextLabel.font lineHeight]);
	self.textLabel.frame = rect;
	
	rect = CGRectZero;
	rect.origin.x = self.textLabel.frame.origin.x;
	rect.origin.y = CGRectGetMaxY(self.textLabel.frame);
	rect.size.width = self.textLabel.frame.size.width;
	rect.size.height = [self.detailTextLabel.font lineHeight];
	self.detailTextLabel.frame = rect;
	
//    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
//    detailTextLabelFrame.size.height = [[self class] heightForCellWithPost:_post] - 45.0f;
//    self.detailTextLabel.frame = detailTextLabelFrame;
}

+(CGFloat)heightForText:(NSString *)text{
	CGFloat imgHeight = IMG_SIZE.height;
	return imgHeight + MARGIN * 2;

	/*
	CGFloat width = [UIScreen mainScreen].applicationFrame.size.width - MARGIN * 3 - IMG_SIZE.width;
	CGFloat textHeight = [text sizeWithFont:TITLE_FONT constrainedToSize:CGSizeMake(width, 1000)].height;
	textHeight += [DESCRIPTION_FONT lineHeight];
	
	return MAX(imgHeight, textHeight) + MARGIN * 2;
	*/
	
//	CGFloat width = 320 - PRICE_WIDTH - MARGIN * 3;//20 = arrow width
//	CGFloat height = [text sizeWithFont:TEXT_LBL_FONT constrainedToSize:CGSizeMake(width, 1000)].height;
//	height += MARGIN * 4;
//	height += IMG_SIZE.height;
//	return height;
}

@end





