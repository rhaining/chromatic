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
#import "RTHColorUtil.h"
#import "RTHLocaleHelper.h"
#import "RTHSearchHeaderView.h"
#import "RTHListingViewController.h"

@implementation RTHSearchViewController

-(id)initWithColorHex:(NSString *)hexString{
	if(self = [super init]){
		self.hexString = hexString;
		
		self.navigationItem.title = @"Results";
				
		numberFormatter = [[NSNumberFormatter alloc] init];
		[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		[numberFormatter setMaximumFractionDigits:0];

	}
	return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	UIColor *inverseColor = [RTHColorUtil inverseColorFromColor:self.navigationController.navigationBar.tintColor];
	[self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor : inverseColor}];

	if(!_listings){
		[self search];
	}
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
			[self.tableView beginUpdates];
			[self.tableView endUpdates];
        }
        
//        [_activityIndicatorView stopAnimating];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];

}

-(UITableView *)tableView{
	if(!_tableView){
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.dataSource = self;
		_tableView.delegate = self;
		_tableView.rowHeight = 235;
		_tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		
		searchHeaderView = [[RTHSearchHeaderView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 100) textFieldDelegate:self];
		[self updateButtonTitles];
		_tableView.tableHeaderView = searchHeaderView;
		_tableView.contentOffset = CGPointMake(0, 40);
	}
	return _tableView;
}
-(void)loadView{
	[super loadView];
	[self.view addSubview:self.tableView];
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
		cell = [[RTHListingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
	}
	
	RTHListing *listing = [_listings objectAtIndex:indexPath.row];
	
	[numberFormatter setLocale:[RTHLocaleHelper findLocaleByCurrencyCode:listing.currencyCode]];
	NSString *priceValue = [numberFormatter stringFromNumber:@(listing.price.floatValue)];
	
	cell.textLabel.text = listing.title;
	cell.detailTextLabel.text = priceValue;
//	cell.detailTextLabel.text = @"$45,502";
	
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
	RTHListingViewController *vc = [[RTHListingViewController alloc] initWithListing:listing];
	[self.navigationController pushViewController:vc animated:YES];
//	[[UIApplication sharedApplication] openURL:listing.url];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)updateButtonTitles{
	[searchHeaderView setCategoryName:_category ? _category.shortName : @"Category"];
//	[searchHeaderView setKeyword:_keyword && _keyword.length > 0 ? [NSString stringWithFormat:@"“%@”", _keyword] : @"Keyword"];
	[searchHeaderView setPrice:_maximumPrice ? [NSString stringWithFormat:@"$%d-%d", _minimumPrice, _maximumPrice] : @"Price"];
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//	if(!searchHeaderView){
//		CGFloat height = [tableView.delegate tableView:tableView heightForHeaderInSection:section];
//		searchHeaderView = [[RTHSearchHeaderView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, height) textFieldDelegate:self];
//	}
//	[self updateButtonTitles];
//	return searchHeaderView;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//	return 80;
//}

-(void)presentPriceOptions{
	RTHPriceViewController *vc = [[RTHPriceViewController alloc] init];
	vc.delegate = self;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
	nav.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
	[self presentViewController:nav animated:YES completion:nil];
	vc.maximumPrice = _maximumPrice;
	vc.minimumPrice = _minimumPrice;
}

//-(void)presentKeyword{
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Keyword" message:@"Enter a keyword" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enter", nil];
//	alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//	[alert textFieldAtIndex:0].text = _keyword;
//	[alert show];
//}

-(void)presentCategories{
	categoryViewController = [[RTHCategoryViewController alloc] init];
	categoryViewController.delegate = self;
	categoryViewController.selectedCategory = _category;
//	vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
//	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//	nav.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
//	[self presentViewController:nav animated:YES completion:nil];

	[self addChildViewController:categoryViewController];
	
	categoryViewController.view.frame = self.view.bounds;
	categoryViewController.view.transform = CGAffineTransformMakeTranslation(0, categoryViewController.view.frame.size.height);
	[self.view addSubview:categoryViewController.view];
	[UIView animateWithDuration:0.3 animations:^{
		categoryViewController.view.transform = CGAffineTransformIdentity;
	}];
}

//#pragma mark - uialertviewdelegate
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//	if(buttonIndex != alertView.cancelButtonIndex){
//		UITextField *textField = [alertView textFieldAtIndex:0];
//		_keyword = [textField hasText] ? textField.text : nil;
//		[self updateButtonTitles];
////		updateButton.enabled = YES;
//		[self search];
//	}
//}

#pragma mark - category delegate
-(void)categoryViewController:(RTHCategoryViewController *)viewController didSelectCategory:(RTHCategory *)category{
	_category = category;
	[self updateButtonTitles];
//	updateButton.enabled = YES;
	[self search];
	[UIView animateWithDuration:0.3 animations:^{
		categoryViewController.view.transform = CGAffineTransformMakeTranslation(0, categoryViewController.view.frame.size.height);
		categoryViewController.view.alpha = 0;
	} completion:^(BOOL finished) {
		[categoryViewController removeFromParentViewController];
		[categoryViewController.view removeFromSuperview];
		categoryViewController = nil;
	}];
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//	[searchHeaderView expandKeywordField];
	[self.tableView setContentOffset:CGPointZero animated:YES];
	return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	_keyword = [textField hasText] ? textField.text : nil;
//	[searchHeaderView restoreTheBalance];
	[textField resignFirstResponder];
	[self search];
	return YES;
}
@end
