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

@implementation RTHListingViewController

-(id)initWithListing:(RTHListing *)listing{
	if(self = [super init]){
		self.listing = listing;
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Buy on Etsy" style:UIBarButtonItemStyleBordered target:self action:@selector(buyOnEtsy)];
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
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)buyOnEtsy{
	[[UIApplication sharedApplication] openURL:self.listing.url];
}


@end
