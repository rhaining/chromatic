//
//  RTHCategoryView.h
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTHCategoryView : UIView{
//	UIPickerView *_pickerView;
}

@property (nonatomic, readonly) UIPickerView *pickerView;

-(id)initWithFrame:(CGRect)frame pickerDelegateAndDataSource:(id<UIPickerViewDelegate, UIPickerViewDataSource>)delegate;
-(void)reloadData;

@end
