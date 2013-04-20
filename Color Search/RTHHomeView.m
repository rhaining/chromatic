//
//  RTHHomeView.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHHomeView.h"
#import "RTHButton.h"

@implementation RTHHomeView

- (id)initWithFrame:(CGRect)frame cameraAvailable:(BOOL)cameraAvailable{
    if (self = [super initWithFrame:frame]) {
//		self.backgroundColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
		self.backgroundColor = [UIColor colorWithRed:107/255.0 green:209/255.0 blue:196/255.0 alpha:1];
		
		CGFloat buttonWidth = 200;
		CGFloat buttonHeight = 75;
		CGFloat margin = 50;
		
		CGFloat originX = (frame.size.width - buttonWidth) / 2.0;
		CGFloat originY = 50;
		
		if(cameraAvailable){
			RTHButton *cameraButton = [RTHButton newRTHButton];
			[cameraButton setTitle:@"Take a Photo" forState:UIControlStateNormal];
			[cameraButton addTarget:nil action:@selector(presentCamera) forControlEvents:UIControlEventTouchUpInside];
			cameraButton.frame = CGRectMake(originX, originY, buttonWidth, buttonHeight);
			[cameraButton setTitleColor:[UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1] forState:UIControlStateNormal];
			[self addSubview:cameraButton];
			
			originY = CGRectGetMaxY(cameraButton.frame) + margin;
		}else{
			originY = 100;
			margin = 100;
		}
		
		RTHButton *albumButton = [RTHButton newRTHButton];
		[albumButton setTitle:@"Browse your Photo Album" forState:UIControlStateNormal];
		[albumButton addTarget:nil action:@selector(presentPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
		albumButton.frame = CGRectMake(originX, originY, buttonWidth, buttonHeight);
		[albumButton setTitleColor:[UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1] forState:UIControlStateNormal];
		[self addSubview:albumButton];
	
		RTHButton *historyButton = [RTHButton newRTHButton];
		[historyButton setTitle:@"Browse Color History" forState:UIControlStateNormal];
		[historyButton addTarget:nil action:@selector(presentHistory) forControlEvents:UIControlEventTouchUpInside];
		historyButton.frame = CGRectMake(originX, CGRectGetMaxY(albumButton.frame) + margin, buttonWidth, buttonHeight);
		[historyButton setTitleColor:[UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1] forState:UIControlStateNormal];
		[self addSubview:historyButton];
	}
    return self;
}


@end
