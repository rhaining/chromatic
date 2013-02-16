//
//  RTHListingViewController.h
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTHListing, RTHListingView;

@interface RTHListingViewController : UIViewController{
	RTHListingView *listingView;
}

@property (nonatomic, strong) RTHListing *listing;

-(id)initWithListing:(RTHListing *)listing;

@end
