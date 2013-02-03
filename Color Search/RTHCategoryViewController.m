//
//  RTHCategoryViewController.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHCategoryViewController.h"
#import "RTHCategory.h"

@interface RTHCategoryViewController ()

@end

@implementation RTHCategoryViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		[self search];
//		self.tableView.rowHeight = 50;
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSelf)];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(clearCategory)];
    }
    return self;
}
-(void)dismissSelf{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)search{
	[RTHCategory categoriesWithBlock:^(NSArray *categories, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            _categories = categories;
            [self.tableView reloadData];
        }
        
		//        [_activityIndicatorView stopAnimating];
    }];
	
}
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
@end
