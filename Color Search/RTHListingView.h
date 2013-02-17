//
//  RTHListingView.h
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTHButton;

@interface RTHListingView : UIScrollView

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *priceLabel;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UILabel *bylineLabel;
@property (nonatomic, readonly) UILabel *descriptionLabel;

@end
