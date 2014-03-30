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
		
		CGFloat buttonWidth = 320;
		CGFloat buttonHeight = 75;
		CGFloat margin = 50;
        
        NSUInteger numButtons = cameraAvailable ? 3 : 2;
		
		CGFloat originX = (frame.size.width - buttonWidth) / 2.0;
		CGFloat contentHeight = (buttonHeight * numButtons) + (margin * (numButtons-1));
		CGFloat originY = (CGRectGetHeight(frame) - contentHeight) / 2.0;
		
        UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeSystem];
		if(cameraAvailable){
			[cameraButton setTitle:@"Take a Photo" forState:UIControlStateNormal];
			[cameraButton addTarget:nil action:@selector(presentCamera) forControlEvents:UIControlEventTouchUpInside];
			cameraButton.frame = CGRectMake(originX, originY, buttonWidth, buttonHeight);
			[self addSubview:cameraButton];
			
			originY = CGRectGetMaxY(cameraButton.frame) + margin;
		}
		
		UIButton *albumButton = [UIButton buttonWithType:UIButtonTypeSystem];
		[albumButton setTitle:@"Browse your Photo Album" forState:UIControlStateNormal];
		[albumButton addTarget:nil action:@selector(presentPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
		albumButton.frame = CGRectMake(originX, originY, buttonWidth, buttonHeight);
		[self addSubview:albumButton];
	
		UIButton *historyButton = [UIButton buttonWithType:UIButtonTypeSystem];
		[historyButton setTitle:@"Browse Color History" forState:UIControlStateNormal];
		[historyButton addTarget:nil action:@selector(presentHistory) forControlEvents:UIControlEventTouchUpInside];
		historyButton.frame = CGRectMake(originX, CGRectGetMaxY(albumButton.frame) + margin, buttonWidth, buttonHeight);
		[self addSubview:historyButton];
        
        for(UIButton *button in @[cameraButton, albumButton, historyButton]){
            button.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        }
	}
    return self;
}


@end
