//
//  RTHCategoryViewController.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTHCategoryViewControllerDelegate;
@class RTHCategory;

@interface RTHCategoryViewController : UITableViewController {
	NSArray *_categories;
}

@property (nonatomic, strong) RTHCategory *selectedCategory;

@property (nonatomic, weak) id<RTHCategoryViewControllerDelegate> delegate;

@end


@protocol RTHCategoryViewControllerDelegate <NSObject>

@required
-(void)categoryViewController:(RTHCategoryViewController *)viewController didSelectCategory:(RTHCategory *)category;

@end