//
//  RTHCategoryViewController.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHCategoryViewController.h"
#import "RTHCategory.h"
#import "RTHCategoryView.h"

@interface RTHCategoryViewController ()

@end

@implementation RTHCategoryViewController

//@synthesize pickerView=_pickerView;

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//		[self search];
////		self.tableView.rowHeight = 50;
//		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSelf)];
//		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(clearCategory)];
//    }
//    return self;
//}
//-(void)dismissSelf{
//	[self dismissViewControllerAnimated:YES completion:nil];
//}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[self search];
}

-(void)loadView{
	[super loadView];
	self.view.backgroundColor = [UIColor clearColor];
	
	categoryView = [[RTHCategoryView alloc] initWithFrame:self.view.bounds pickerDelegateAndDataSource:self];
	categoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:categoryView];
}

//-(UIPickerView *)pickerView{
//	if(!_pickerView){
//		_pickerView = [[UIPickerView alloc] init];
//		_pickerView.delegate = self;
//		_pickerView.dataSource = self;
//		_pickerView.showsSelectionIndicator = YES;
//		
//		UIView *buttonWrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
//		buttonWrapper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//	}
//	return _pickerView;
//}

-(void)search{
	[RTHCategory categoriesWithBlock:^(NSArray *categories, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            _categories = categories;
			[categoryView reloadData];
//            [self.tableView reloadData];
        }
        
		//        [_activityIndicatorView stopAnimating];
    }];
	
}

-(void)selectCategory{
	NSInteger categoryIndex = [categoryView.pickerView selectedRowInComponent:0];
	RTHCategory *category = [_categories objectAtIndex:categoryIndex];
	[self.delegate categoryViewController:self didSelectCategory:category];
}
/*
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return _categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellId = @"CategorYCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
	if(!cell){
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
	}
	
	RTHCategory *category = [_categories objectAtIndex:indexPath.row];
	cell.textLabel.text = category.displayName;
	
	cell.accessoryType = [category.name isEqualToString:self.selectedCategory.name] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	RTHCategory *category = [_categories objectAtIndex:indexPath.row];
	[self.delegate categoryViewController:self didSelectCategory:category];
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clearCategory{
	[self.delegate categoryViewController:self didSelectCategory:nil];
	[self dismissViewControllerAnimated:YES completion:nil];
}
*/

#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	RTHCategory *category = [_categories objectAtIndex:row];
	return category.displayName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//	RTHCategory *category = [_categories objectAtIndex:row];
//	[self.delegate categoryViewController:self didSelectCategory:category];
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return _categories.count;
}


@end
