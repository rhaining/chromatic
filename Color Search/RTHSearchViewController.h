//
//  RTHSearchViewController.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTHCategoryViewController.h"
#import "RTHPriceViewController.h"

@class RTHCategory, RTHCategoryViewController, RTHSearchHeaderView, RTHButton;

@interface RTHSearchViewController : UIViewController <RTHCategoryViewControllerDelegate, UIAlertViewDelegate, RTHPriceViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
	NSArray *_listings;
	RTHCategory *_category;
	NSString *_keyword;
	NSInteger _minimumPrice;
	NSInteger _maximumPrice;
	
	RTHSearchHeaderView *searchHeaderView;
	
	NSNumberFormatter *numberFormatter;
	
	RTHCategoryViewController *categoryViewController;
	
	NSInteger _nextSearchOffset;
	
	RTHButton *loadMoreButton;
	
	UIActivityIndicatorView *activityIndicator;
	
	UIView *overlay;
	UITapGestureRecognizer *tapRecog;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *hexString;

-(id)initWithColorHex:(NSString *)hexString;


@end
