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

@class RTHCategory;

@interface RTHSearchViewController : UITableViewController <RTHCategoryViewControllerDelegate, UIAlertViewDelegate, RTHPriceViewControllerDelegate> {
	NSArray *_listings;
	RTHCategory *_category;
	NSString *_keyword;
	NSInteger _minimumPrice;
	NSInteger _maximumPrice;
	
	UIButton *categoryButton;
	UIButton *keywordButton;
	UIButton *priceButton;
//	UIButton *updateButton;
	
	NSNumberFormatter *numberFormatter;
}

@property (nonatomic, copy) NSString *hexString;

-(id)initWithColorHex:(NSString *)hexString;


@end
