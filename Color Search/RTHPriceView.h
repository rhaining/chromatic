//
//  RTHPriceView.h
//  Chromatic
//
//  Created by Robert Tolar Haining on 9/20/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTHPriceView : UIView {
	UILabel *label;
}

@property (nonatomic) NSInteger minimumPrice;
@property (nonatomic) NSInteger maximumPrice;

@property (nonatomic, readonly) UISlider *minimumSlider;
@property (nonatomic, readonly) UISlider *maximumSlider;

@end
