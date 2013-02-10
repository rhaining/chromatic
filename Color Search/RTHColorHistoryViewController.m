//
//  RTHColorHistoryViewController.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/3/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHColorHistoryViewController.h"
#import "RTHColorHistory.h"
#import "RTHColorUtil.h"

@interface RTHColorHistoryViewController ()

@end

@implementation RTHColorHistoryViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		colors = [RTHColorHistory recentColors];
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    return self;
}

-(void)dismissSelf{
	[self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad{
    [super viewDidLoad];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSelf)];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return colors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ColorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	}
	NSDictionary *attributes = [colors objectAtIndex:indexPath.row];
	UIColor *color = attributes[@"color"];
	
	UIView *backgroundView = [UIView new];
	backgroundView.backgroundColor = color;
	cell.backgroundView = backgroundView;

	cell.textLabel.text = [dateFormatter stringFromDate:attributes[@"date"]];
	cell.textLabel.backgroundColor = color;
	cell.textLabel.textColor = [RTHColorUtil inverseColorFromColor:color];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSDictionary *attributes = [colors objectAtIndex:indexPath.row];
	UIColor *color = attributes[@"color"];
	
	[self.delegate colorHistoryViewController:self didSelectColor:color];
	[self dismissViewControllerAnimated:YES completion:nil];
	
}

@end
