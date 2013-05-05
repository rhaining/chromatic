//
//  RTHSearchHeaderView.h
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTHButton;

@interface RTHSearchHeaderView : UIView {
	RTHButton *categoryButton;
	UITextField *keywordField;
	RTHButton *priceButton;
}

- (id)initWithFrame:(CGRect)frame textFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate;

-(void)setCategoryName:(NSString *)categoryName;
-(void)setPrice:(NSString *)price;
//-(void)expandKeywordField;
//-(void)restoreTheBalance;

-(void)dismissKeyboard;


@end
