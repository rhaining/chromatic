//
//  RTHHomeView.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHHomeView.h"
#import "RTHButton.h"
#import "RTHConstants.h"

@implementation RTHHomeView

- (id)initWithFrame:(CGRect)frame cameraAvailable:(BOOL)cameraAvailable{
    if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [RTHConstants chromaticYellow];
		
		CGFloat buttonWidth = CGRectGetWidth(frame) - 40;
		CGFloat buttonHeight = 100;
		CGFloat margin = 50;
        
        NSUInteger numButtons = cameraAvailable ? 3 : 2;
		
		CGFloat originX = (frame.size.width - buttonWidth) / 2.0;
		CGFloat contentHeight = (buttonHeight * numButtons) + (margin * (numButtons-1));
		CGFloat originY = 32+ (CGRectGetHeight(frame) - contentHeight) / 2.0;
		
        _cameraButton = [UIButton buttonWithType:UIButtonTypeSystem];
		if(cameraAvailable){
			[self.cameraButton setTitle:@"Take a Photo" forState:UIControlStateNormal];
            [self.cameraButton setImage:[UIImage imageNamed:@"camera_icon.png"] forState:UIControlStateNormal];
			self.cameraButton.frame = CGRectMake(originX, originY, buttonWidth, buttonHeight);
			[self addSubview:self.cameraButton];
			
			originY = CGRectGetMaxY(self.cameraButton.frame) + margin;
		}
		
		_albumButton = [UIButton buttonWithType:UIButtonTypeSystem];
		[self.albumButton setTitle:@"Browse Photos" forState:UIControlStateNormal];
        [self.albumButton setImage:[UIImage imageNamed:@"photos_icon.png"] forState:UIControlStateNormal];
		self.albumButton.frame = CGRectMake(originX, originY, buttonWidth, buttonHeight);
		[self addSubview:self.albumButton];
	
		_historyButton = [UIButton buttonWithType:UIButtonTypeSystem];
		[self.historyButton setTitle:@" Color History" forState:UIControlStateNormal];
        [self.historyButton setImage:[UIImage imageNamed:@"colors_icon.png"] forState:UIControlStateNormal];
		self.historyButton.frame = CGRectMake(originX, CGRectGetMaxY(self.albumButton.frame) + margin, buttonWidth, buttonHeight);
		[self addSubview:self.historyButton];
        
        for(UIButton *button in @[self.cameraButton, self.albumButton, self.historyButton]){
            button.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        }
	}
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.cameraButton sizeToFit];
    [self.albumButton sizeToFit];
    [self.historyButton sizeToFit];
}


@end
