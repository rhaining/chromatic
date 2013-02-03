//
//  RTHListingCell.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTHListingCell : UITableViewCell

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImageView *listingImageView;

+(CGFloat)heightForText:(NSString *)text;

@end
