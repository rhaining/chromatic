//
//  RTHCategoryViewController.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTHCategoryViewControllerDelegate;
@class RTHCategory, RTHCategoryView;

@interface RTHCategoryViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
	NSArray *_categories;
	RTHCategoryView *categoryView;
}

@property (nonatomic, strong) RTHCategory *selectedCategory;
@property (nonatomic, weak) id<RTHCategoryViewControllerDelegate> delegate;
//@property (nonatomic, readonly) UIPickerView *pickerView;

@end


@protocol RTHCategoryViewControllerDelegate <NSObject>

@required
-(void)categoryViewController:(RTHCategoryViewController *)viewController didSelectCategory:(RTHCategory *)category;

@end