//
//  RTHColorSelectionView.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 3/30/14.
//  Copyright (c) 2014 Robert Tolar Haining. All rights reserved.
//

#import "RTHColorSelectionView.h"
#import "RTHImageUtil.h"

@interface RTHColorSelectionView()
@end

@implementation RTHColorSelectionView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.maxSize.width, self.maxSize.height)];
        self.imageView.userInteractionEnabled = YES;
        self.imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.imageView];

        _searchSelectedColorButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.searchSelectedColorButton setTitle:@"Search Selected Color" forState:UIControlStateNormal];
        self.searchSelectedColorButton.enabled = NO;
        [self addSubview:self.searchSelectedColorButton];
        
        _searchComplementaryColorButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.searchComplementaryColorButton setTitle:@"Search Complementary Color" forState:UIControlStateNormal];
        self.searchComplementaryColorButton.enabled = NO;
        [self addSubview:self.searchComplementaryColorButton];
        
        _selectedColorSwatch = [[UIView alloc] init];
        self.selectedColorSwatch.layer.borderColor = [UIColor colorWithWhite:200/255.0 alpha:1].CGColor;
        self.selectedColorSwatch.layer.borderWidth = 1;
        [self addSubview:self.selectedColorSwatch];

        _complementaryColorSwatch = [[UIView alloc] init];
        self.complementaryColorSwatch.layer.borderColor = [UIColor colorWithWhite:200/255.0 alpha:1].CGColor;
        self.complementaryColorSwatch.layer.borderWidth = 1;
        [self addSubview:self.complementaryColorSwatch];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
	CGFloat buttonHeight = 55;
    CGFloat margin = 10;
    CGFloat contentHeight = buttonHeight * 2 + margin;
    
    CGRect rect = self.selectedColorSwatch.frame;
    rect.origin.x = margin;
    rect.origin.y =  CGRectGetMaxY(self.imageView.frame) + ( CGRectGetHeight(self.frame) - CGRectGetMaxY(self.imageView.frame) - contentHeight ) / 2.0;
    rect.size = CGSizeMake(buttonHeight, buttonHeight);
    self.selectedColorSwatch.frame = rect;

    CGFloat buttonWidth = [self.searchSelectedColorButton sizeThatFits:CGSizeMake(1000, buttonHeight)].width;
	self.searchSelectedColorButton.frame = CGRectMake(CGRectGetMaxX(self.selectedColorSwatch.frame) + margin,
												 CGRectGetMinY(self.selectedColorSwatch.frame), buttonWidth, buttonHeight);
    
    rect = self.complementaryColorSwatch.frame;
    rect.origin.x = CGRectGetMinX(self.selectedColorSwatch.frame);
    rect.origin.y = CGRectGetMaxY(self.selectedColorSwatch.frame) + margin;
    rect.size = CGSizeMake(buttonHeight, buttonHeight);
    self.complementaryColorSwatch.frame = rect;
    
    buttonWidth = [self.searchComplementaryColorButton sizeThatFits:CGSizeMake(1000, buttonHeight)].width;
	self.searchComplementaryColorButton.frame = CGRectMake(CGRectGetMaxX(self.complementaryColorSwatch.frame) + margin,
													  CGRectGetMinY(self.complementaryColorSwatch.frame), buttonWidth, buttonHeight);

}

-(void)useImage:(UIImage *)image{	
    self.imageView.image = [self scaledImage:image];

	self.searchSelectedColorButton.enabled = YES;
	self.searchComplementaryColorButton.enabled = YES;
}

-(CGSize)maxSize{
	return CGSizeMake(self.frame.size.width, 300);
}

-(UIImage *)scaledImage:(UIImage *)image{
	return [RTHImageUtil scaleImage:image toSize:[self maxSize]];
}

@end
