//
//  RTHColorSelectionView.h
//  Chromatic
//
//  Created by Robert Tolar Haining on 3/30/14.
//  Copyright (c) 2014 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTHColorSelectionView : UIView

@property (nonatomic, readonly) UIImageView *imageView;

@property (nonatomic, readonly) UIButton *searchSelectedColorButton;
@property (nonatomic, readonly) UIButton *searchComplementaryColorButton;

@property (nonatomic, strong) UIView *selectedColorSwatch;
@property (nonatomic, strong) UIView *complementaryColorSwatch;

-(void)useImage:(UIImage *)image;

@end
