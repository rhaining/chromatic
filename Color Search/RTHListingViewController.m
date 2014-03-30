//
//  RTHListingViewController.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHListingViewController.h"
#import "RTHListing.h"
#import "RTHListingView.h"
#import "UIImageView+AFNetworking.h"
#import "RTHLocaleHelper.h"
#import "RTHAnalytics.h"
#import "RTHCustomButton.h"

@implementation RTHListingViewController

-(id)initWithListing:(RTHListing *)listing{
	if(self = [super init]){
		self.listing = listing;
        
        RTHCustomButton *button = [RTHCustomButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"Buy on Etsy" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"external_link_icon.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buyOnEtsy) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithWhite:100/255.0 alpha:1] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 130, 45);
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
		
		[RTHAnalytics logListingView];
	}
	return self;
}

-(void)loadView{
	[super loadView];
	listingView = [[RTHListingView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:listingView];
	
	listingView.titleLabel.text = self.listing.title;
	if(self.listing.largeImageURL){
		dispatch_async(dispatch_get_main_queue(), ^{
			[listingView.imageView setImageWithURL:self.listing.imageURL];
			dispatch_async(dispatch_get_main_queue(), ^{
				[listingView.imageView setImageWithURL:self.listing.largeImageURL];
			});
		});
	}
	listingView.descriptionLabel.text = self.listing.itemDescription;

	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setLocale:[RTHLocaleHelper findLocaleByCurrencyCode:self.listing.currencyCode]];
	listingView.priceLabel.text = [numberFormatter stringFromNumber:@(self.listing.price.floatValue)];
	
	listingView.bylineLabel.text = [NSString stringWithFormat:@"%@", self.listing.shopName];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)buyOnEtsy{
	if([[UIApplication sharedApplication] canOpenURL:self.listing.etsyAppURL]){
		[RTHAnalytics logEtsyView:YES];
		[[UIApplication sharedApplication] openURL:self.listing.etsyAppURL];
	}else{
		[RTHAnalytics logEtsyView:NO];
		[[UIApplication sharedApplication] openURL:self.listing.etsyWebURL];
	}
}

@end

