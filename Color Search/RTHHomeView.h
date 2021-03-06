//
//  RTHHomeView.h
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTHHomeView : UIView

@property (nonatomic, readonly) UIButton *cameraButton;
@property (nonatomic, readonly) UIButton *albumButton;
@property (nonatomic, readonly) UIButton *historyButton;

- (id)initWithFrame:(CGRect)frame cameraAvailable:(BOOL)cameraAvailable;

@end
