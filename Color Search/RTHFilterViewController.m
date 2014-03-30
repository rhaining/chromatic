//
//  RTHFilterViewController.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 9/20/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHFilterViewController.h"
#import "RTHPriceView.h"
#import "RTHCategory.h"

@interface RTHFilterViewController()
@property (nonatomic, strong) RTHCategory *category;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic) NSInteger minimumPrice, maximumPrice;
@property (nonatomic, strong) UITextField *searchField;
@end

@implementation RTHFilterViewController

-(id)initWithDelegate:(id<RTHFilterDelegate>)delegate
              keyword:(NSString *)keyword
             category:(RTHCategory *)category
         minimumPrice:(NSInteger)minimumPrice
         maximumPrice:(NSInteger)maximumPrice{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.delegate = delegate;
        self.category = category;
        self.keyword = keyword;
        self.minimumPrice = minimumPrice;
        self.maximumPrice = maximumPrice;
    }
    return self;
}

static NSString *CellID = @"kRTHFilterCell";

-(void)loadView{
	[super loadView];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
	self.navigationItem.rightBarButtonItem.enabled = NO;
	
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
	self.tableView.allowsSelection = NO;
}
-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[self searchForCategories];
}
-(void)cancel{
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)done{
    [self.delegate filterViewController:self
              didUpdateWithMinimumPrice:priceView.minimumPrice
                           maximumPrice:priceView.maximumPrice
                               category:self.category
                                keyword:self.keyword];
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dirtyForm{
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

-(void)didUpdatePrice{
    [self dirtyForm];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.section) {
		case 0:
			return UITableViewAutomaticDimension;
			break;
		case 1:
			return 110;
			break;
		case 2:
			return 150;
			break;
		default:
			break;
	}
	return UITableViewAutomaticDimension;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0:
			return @"Keyword";
			break;
		case 1:
			return @"Price";
			break;
		case 2:
			return @"Category";
			break;
		default:
			break;
	}
	return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
	switch (indexPath.section) {
		case 0:
		{
            if(!self.searchField){
                self.searchField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, CGRectGetWidth(tableView.frame) - 40, tableView.rowHeight-20)];
                self.searchField.delegate = self;
                self.searchField.placeholder = @"Term(s)";
                self.searchField.clearButtonMode = UITextFieldViewModeAlways;
                self.searchField.text = self.keyword;
            }
			cell.accessoryView = self.searchField;
		}
			break;
		case 1:
		{
            if(!priceView){
                priceView = [[RTHPriceView alloc] initWithFrame:CGRectMake(20, 10, CGRectGetWidth(tableView.frame) - 40, 90)];
                priceView.minimumPrice = self.minimumPrice;
                priceView.maximumPrice = self.maximumPrice;
                [priceView.minimumSlider addTarget:self action:@selector(didUpdatePrice) forControlEvents:UIControlEventValueChanged];
                [priceView.maximumSlider addTarget:self action:@selector(didUpdatePrice) forControlEvents:UIControlEventValueChanged];
            }
			cell.accessoryView = priceView;
		}
			break;
		case 2:
		{
			categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 10, CGRectGetWidth(tableView.frame) - 40, 130)];
			categoryPicker.delegate = self;
			categoryPicker.dataSource = self;
			categoryPicker.showsSelectionIndicator = YES;
			categoryPicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
			cell.accessoryView = categoryPicker;
		}
			break;
		default:
			break;
	}
	return cell;
}

#pragma mark - text field delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self dirtyForm];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.keyword = textField.text;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    self.keyword = nil;
    [self dirtyForm];
    return YES;
}


#pragma mark - categories
-(void)searchForCategories{
	[RTHCategory categoriesWithBlock:^(NSArray *newCategories, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            categories = newCategories;
			[categoryPicker reloadAllComponents];
            if(self.category){
                NSUInteger idx = [categories indexOfObject:self.category];
                if(idx != NSNotFound){
                    [categoryPicker selectRow:idx inComponent:0 animated:YES];
                }
            }
        }
    }];
	
}

#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(row==0){
        return @"All";
    }else{
        RTHCategory *category = categories[row-1];
        return category.displayName;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(row == 0){
        self.category = nil;
    }else{
        self.category = categories[row-1];
    }
    [self dirtyForm];
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return categories.count + 1;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.searchField.isFirstResponder){
        [self.searchField resignFirstResponder];
    }
}

@end
