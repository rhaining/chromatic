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
#import "RTHListingViewController.h"
#import "RTHAnalytics.h"
#import "RTHButton.h"
#import "RTHFilterViewController.h"
#import "RTHNavigationController.h"

@interface RTHSearchViewController() <RTHFilterDelegate>
@property (nonatomic, strong) UIAlertView *alertView;
@end

@implementation RTHSearchViewController

-(id)initWithColorHex:(NSString *)hexString{
	if(self = [super init]){
		self.hexString = hexString;
		
		self.navigationItem.title = @"Results";
				
		numberFormatter = [[NSNumberFormatter alloc] init];
		[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		[numberFormatter setMaximumFractionDigits:0];

		[RTHAnalytics logResultsView];
	}
	return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
//	UIColor *tintColor = [RTHColorUtil inverseColorFromColor:self.navigationController.navigationBar.tintColor];
    UIColor *tintColor = self.navigationController.navigationBar.tintColor;
	[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : tintColor}];

	if(!_listings){
		[self search];
	}
}

-(void)showAlert{
    if(!self.alertView){
        self.alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"No results found" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
    }
    if(![self.alertView isVisible]){
        [self.alertView show];
    }
}

-(void)search{
	loadMoreButton.hidden = YES;
	
	_listings = nil;
	[self.tableView reloadData];

	[activityIndicator startAnimating];
	[RTHListing listingsForHexColor:self.hexString category:_category keyword:_keyword minimumPrice:_minimumPrice maximumPrice:_maximumPrice offset:0 withBlock:^(NSArray *listings, NSInteger nextSearchOffset, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            _listings = listings;
			if(!_listings || _listings.count == 0){
                [self showAlert];
			}
            [self.tableView reloadData];
			[self.tableView beginUpdates];
			[self.tableView endUpdates];
        }
		
		_nextSearchOffset = nextSearchOffset;
		loadMoreButton.hidden = (_nextSearchOffset <= 0);

        [activityIndicator stopAnimating];
    }];
}
-(void)loadMoreListings{
	loadMoreButton.hidden = YES;
	
	[activityIndicator startAnimating];
	[RTHListing listingsForHexColor:self.hexString category:_category keyword:_keyword minimumPrice:_minimumPrice maximumPrice:_maximumPrice offset:_nextSearchOffset withBlock:^(NSArray *listings, NSInteger nextSearchOffset, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
			NSMutableArray *combinedListings = [NSMutableArray arrayWithCapacity:_listings.count+listings.count];
			[combinedListings addObjectsFromArray:_listings];
			[combinedListings addObjectsFromArray:listings];
			_listings = [NSArray arrayWithArray:combinedListings];

			if(!_listings || _listings.count == 0){
                [self showAlert];
			}
            [self.tableView reloadData];
			[self.tableView beginUpdates];
			[self.tableView endUpdates];
        }
		_nextSearchOffset = nextSearchOffset;
		loadMoreButton.hidden = (_nextSearchOffset <= 0);

		[activityIndicator stopAnimating];
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
		
		UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 88)];
		loadMoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
		[loadMoreButton setTitle:@"Load More Listings" forState:UIControlStateNormal];
		[loadMoreButton addTarget:self action:@selector(loadMoreListings) forControlEvents:UIControlEventTouchUpInside];
		loadMoreButton.frame = CGRectMake(50, 22, _tableView.frame.size.width - 100, 44);
		[footer addSubview:loadMoreButton];
		loadMoreButton.hidden = YES;
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.hidesWhenStopped = YES;
        activityIndicator.center = loadMoreButton.center;
        [footer addSubview:activityIndicator];
        
		_tableView.tableFooterView = footer;
	}
	return _tableView;
}
-(void)loadView{
	[super loadView];
	[self.view addSubview:self.tableView];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterSearch)];
}

-(void)filterSearch{
	RTHFilterViewController *vc = [[RTHFilterViewController alloc] initWithDelegate:self keyword:_keyword category:_category minimumPrice:_minimumPrice maximumPrice:_maximumPrice];
	UINavigationController *nav = [[RTHNavigationController alloc] initWithRootViewController:vc];
	[self presentViewController:nav animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	RTHListing *listing = [_listings objectAtIndex:indexPath.row];
	return [RTHListingCell heightForText:listing.title];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
	cell.imageURL = listing.imageURL;
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	RTHListing *listing = [_listings objectAtIndex:indexPath.row];
	RTHListingViewController *vc = [[RTHListingViewController alloc] initWithListing:listing];
	[self.navigationController pushViewController:vc animated:YES];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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


#pragma mark - scroll delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!self.view.superview){
        return;
    }
    if(!activityIndicator.isAnimating && scrollView.contentOffset.y + CGRectGetHeight(scrollView.frame)*2 > scrollView.contentSize.height){
        [self loadMoreListings];
    }
}


#pragma mark - filter vc
-(void)filterViewController:(RTHFilterViewController *)filterViewController
  didUpdateWithMinimumPrice:(NSInteger)minimumPrice
               maximumPrice:(NSInteger)maximumPrice
                   category:(RTHCategory *)category
                    keyword:(NSString *)keyword{
    _category = category;
    _keyword = keyword;
    _minimumPrice = minimumPrice;
    _maximumPrice = maximumPrice;
    _listings = nil;
    [self.tableView reloadData];
    [self search];

}
@end
