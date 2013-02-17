//
//  RTHSearchHeaderView.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHSearchHeaderView.h"
#import "RTHButton.h"

@implementation RTHSearchHeaderView

- (id)initWithFrame:(CGRect)frame textFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate{
    if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.9];
		
		categoryButton = [RTHButton newRTHButton];
		categoryButton.frame = CGRectMake(10, 5, frame.size.width / 2.0 - 20, 35);
		[categoryButton addTarget:nil action:@selector(presentCategories) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:categoryButton];
		
		priceButton = [RTHButton newRTHButton];
		priceButton.frame = CGRectMake(CGRectGetMaxX(categoryButton.frame) + 20, CGRectGetMinY(categoryButton.frame),
									   CGRectGetWidth(categoryButton.frame), CGRectGetHeight(categoryButton.frame));
		[priceButton addTarget:nil action:@selector(presentPriceOptions) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:priceButton];

		keywordField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(categoryButton.frame) + 10, frame.size.width - 20, 40)];
		keywordField.placeholder = @"Keyword";
		keywordField.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
		keywordField.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
		keywordField.delegate = textFieldDelegate;
		keywordField.borderStyle = UITextBorderStyleBezel;
		keywordField.clearButtonMode = UITextFieldViewModeAlways;
		keywordField.backgroundColor = [UIColor whiteColor];
		keywordField.returnKeyType = UIReturnKeySearch;
		[self addSubview:keywordField];
		
    }
    return self;
}

-(void)setCategoryName:(NSString *)categoryName{
	[categoryButton setTitle:categoryName forState:UIControlStateNormal];
}

-(void)setPrice:(NSString *)price{
	[priceButton setTitle:price forState:UIControlStateNormal];
}
//-(void)expandKeywordField{
//	[UIView animateWithDuration:0.3 animations:^{
//		categoryButton.alpha = 0;
//		priceButton.alpha = 0;
//		keywordField.frame = CGRectMake(0, keywordField.frame.origin.y, self.frame.size.width, keywordField.frame.size.height);
//	}];
//}
//-(void)restoreTheBalance{
//	[UIView animateWithDuration:0.3 animations:^{
//		categoryButton.alpha = 1;
//		priceButton.alpha = 1;
//		keywordField.frame = CGRectMake(107, keywordField.frame.origin.y, 106, keywordField.frame.size.height);
//	}];
//}

@end
