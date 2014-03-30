//
//  RTHFilterViewController.h
//  Chromatic
//
//  Created by Robert Tolar Haining on 9/20/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTHPriceView, RTHCategory;
@protocol RTHFilterDelegate;

@interface RTHFilterViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
	RTHPriceView *priceView;
	UIPickerView *categoryPicker;
	NSArray *categories;
}

@property (nonatomic, weak) id<RTHFilterDelegate> delegate;

-(id)initWithDelegate:(id<RTHFilterDelegate>)delegate
              keyword:(NSString *)keyword
             category:(RTHCategory *)category
         minimumPrice:(NSInteger)minimumPrice
         maximumPrice:(NSInteger)maximumPrice;

@end

@protocol RTHFilterDelegate <NSObject>

@required
-(void)filterViewController:(RTHFilterViewController *)filterViewController
  didUpdateWithMinimumPrice:(NSInteger)minimumPrice
               maximumPrice:(NSInteger)maximumPrice
                   category:(RTHCategory *)category
                    keyword:(NSString *)keyword;

@end