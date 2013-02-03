//
//  RTHPriceViewController.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTHPriceViewControllerDelegate;

@interface RTHPriceViewController : UIViewController{
	UILabel *label;
	UISlider *minimumSlider;
	UISlider *maximumSlider;
}

@property (nonatomic) NSInteger minimumPrice;
@property (nonatomic) NSInteger maximumPrice;
@property (nonatomic, weak) id<RTHPriceViewControllerDelegate> delegate;


@end

@protocol RTHPriceViewControllerDelegate <NSObject>

@required
-(void)priceViewControllerDidUpdatePrice:(RTHPriceViewController *)viewController;
-(void)priceViewControllerDidClearPrice:(RTHPriceViewController *)viewController;

@end