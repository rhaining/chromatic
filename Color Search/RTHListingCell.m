//
//  RTHListingCell.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHListingCell.h"
#import "UIImageView+AFNetworking.h"

#define TEXT_LBL_FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:14]
#define MARGIN 10
#define IMG_HEIGHT 135
#define PRICE_WIDTH 60

@implementation RTHListingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		self.textLabel.numberOfLines = 0;
		self.textLabel.font = TEXT_LBL_FONT;
		
		self.selectionStyle = UITableViewCellSelectionStyleGray;
		
		self.listingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 170, IMG_HEIGHT)];
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
	
	self.detailTextLabel.frame = CGRectMake(self.contentView.frame.size.width - MARGIN - PRICE_WIDTH, MARGIN, PRICE_WIDTH, 14);
    self.detailTextLabel.textAlignment = UITextAlignmentRight;
	
    self.textLabel.frame = CGRectMake(MARGIN, MARGIN, self.detailTextLabel.frame.origin.x - MARGIN * 2, 100);
	[self.textLabel sizeToFit];
	
    self.listingImageView.frame = CGRectMake(MARGIN, CGRectGetMaxY(self.textLabel.frame) + MARGIN,
									  self.contentView.frame.size.width - MARGIN*2, IMG_HEIGHT);
    
//    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
//    detailTextLabelFrame.size.height = [[self class] heightForCellWithPost:_post] - 45.0f;
//    self.detailTextLabel.frame = detailTextLabelFrame;
}

+(CGFloat)heightForText:(NSString *)text{
	CGFloat width = 320 - PRICE_WIDTH - MARGIN * 3;//20 = arrow width
	CGFloat height = [text sizeWithFont:TEXT_LBL_FONT constrainedToSize:CGSizeMake(width, 1000)].height;
	height += MARGIN * 4;
	height += IMG_HEIGHT;
	return height;
}
@end
