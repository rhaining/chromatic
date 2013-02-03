//
//  RTHSearchViewController.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHSearchViewController.h"
#import "RTHListing.h"
#import "RTHListingCell.h"
#import "RTHCategory.h"

@interface RTHSearchViewController ()

@end

@implementation RTHSearchViewController

-(id)initWithColorHex:(NSString *)hexString{
	if(self = [super init]){
		self.hexString = hexString;
		
		[self search];
		
		self.tableView.rowHeight = 235;
		
		self.navigationItem.title = @"Results";
	}
	return self;
}

-(void)search{
	_listings = nil;
	[self.tableView reloadData];
//	updateButton.enabled = NO;

	[RTHListing listingsForHexColor:self.hexString category:_category keyword:_keyword minimumPrice:_minimumPrice maximumPrice:_maximumPrice withBlock:^(NSArray *listings, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            _listings = listings;
			if(!_listings || _listings.count == 0){
				[[[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"No results found" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil] show];
			}
            [self.tableView reloadData];
        }
        
//        [_activityIndicatorView stopAnimating];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	RTHListing *listing = [_listings objectAtIndex:indexPath.row];
	return [RTHListingCell heightForText:listing.title];
}
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return _listings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellId = @"ListingCell";
	RTHListingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
	if(!cell){
		cell = [[RTHListingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
	}
	
	RTHListing *listing = [_listings objectAtIndex:indexPath.row];
	cell.textLabel.text = listing.title;
	
	cell.imageURL = listing.imageURL;
	/*
	if(listing.imageURL){
		cell.imageURL = listing.imageURL;
	}else{
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
			[listing imageWithBlock:^(NSURL *imageURL, NSError *error) {
				listing.imageURL = imageURL;
				cell.imageURL = imageURL;
			}];
		});
	}
	 */
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	RTHListing *listing = [_listings objectAtIndex:indexPath.row];
	[[UIApplication sharedApplication] openURL:listing.url];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)updateButtonTitles{
	NSString *title = _category ? _category.shortName : @"Category";
	[categoryButton setTitle:title forState:UIControlStateNormal];

	title = _keyword ? [NSString stringWithFormat:@"“%@”", _keyword] : @"Keyword";
	[keywordButton setTitle:title forState:UIControlStateNormal];

	title = _maximumPrice ? [NSString stringWithFormat:@"$%d-%d", _minimumPrice, _maximumPrice] : @"Price";
	[priceButton setTitle:title forState:UIControlStateNormal];

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
	header.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
	
	if(!categoryButton){
		categoryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		categoryButton.frame = CGRectMake(0, 3, 106, 44);
		[categoryButton addTarget:self action:@selector(presentCategories) forControlEvents:UIControlEventTouchUpInside];
	}
	[header addSubview:categoryButton];

	if(!keywordButton){
		keywordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		keywordButton.frame = CGRectMake(107, 3, 106, 44);
		[keywordButton addTarget:self action:@selector(presentKeyword) forControlEvents:UIControlEventTouchUpInside];
	}
	[header addSubview:keywordButton];
	
	if(!priceButton){
		priceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		priceButton.frame = CGRectMake(214, 3, 106, 44);
		[priceButton addTarget:self action:@selector(presentPriceOptions) forControlEvents:UIControlEventTouchUpInside];
	}
	[header addSubview:priceButton];
	
//	if(!updateButton){
//		updateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		[updateButton setTitle:@"Update" forState:UIControlStateNormal];
//		updateButton.frame = CGRectMake(260, 3, 60, 44);
//		[updateButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
//		updateButton.enabled = NO;
//	}
//	[header addSubview:updateButton];
	
	[self updateButtonTitles];
	
	return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 50;
}

-(void)presentPriceOptions{
	RTHPriceViewController *vc = [[RTHPriceViewController alloc] init];
	vc.delegate = self;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
	nav.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
	[self presentViewController:nav animated:YES completion:nil];
	vc.maximumPrice = _maximumPrice;
	vc.minimumPrice = _minimumPrice;
}

-(void)presentKeyword{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Keyword" message:@"Enter a keyword" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enter", nil];
	alert.alertViewStyle = UIAlertViewStylePlainTextInput;
	[alert textFieldAtIndex:0].text = _keyword;
	[alert show];
}

-(void)presentCategories{
	RTHCategoryViewController *vc = [[RTHCategoryViewController alloc] init];
	vc.delegate = self;
	vc.selectedCategory = _category;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
	nav.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
	[self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - uialertviewdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex != alertView.cancelButtonIndex){
		_keyword = [alertView textFieldAtIndex:0].text;
		[self updateButtonTitles];
//		updateButton.enabled = YES;
		[self search];
	}
}

#pragma mark - category delegate
-(void)categoryViewController:(RTHCategoryViewController *)viewController didSelectCategory:(RTHCategory *)category{
	_category = category;
	[self updateButtonTitles];
//	updateButton.enabled = YES;
	[self search];
}

#pragma mark - price delegate
-(void)priceViewControllerDidUpdatePrice:(RTHPriceViewController *)viewController{
	_minimumPrice = viewController.minimumPrice;
	_maximumPrice = viewController.maximumPrice;
	[self updateButtonTitles];
//	updateButton.enabled = YES;
	[self search];
}
-(void)priceViewControllerDidClearPrice:(RTHPriceViewController *)viewController{
	_minimumPrice = _maximumPrice = 0;
	[self updateButtonTitles];
	[self search];
}
@end
