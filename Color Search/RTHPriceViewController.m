//
//  RTHPriceViewController.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHPriceViewController.h"

@interface RTHPriceViewController ()

@end

@implementation RTHPriceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(clear)];
		
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStyleDone target:self action:@selector(updatePrice)];
    }
    return self;
}
-(void)clear{
	[self.delegate priceViewControllerDidClearPrice:self];
	[self dismissSelf];
}
-(void)dismissSelf{
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)updatePrice{
	[self.delegate priceViewControllerDidUpdatePrice:self];
	[self dismissSelf];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor whiteColor];
	
	label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 80)];
	label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
	label.text = @"$$";
	label.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:label];
	
	
	UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 60, 50)];
	minLabel.text = @"Minimum";
	minLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
	[self.view addSubview:minLabel];
	
	minimumSlider = [[UISlider alloc] initWithFrame:CGRectMake(70, 150, 200, 50)];
	minimumSlider.minimumValue = 0;
	minimumSlider.maximumValue = 1000;
	[minimumSlider addTarget:self action:@selector(updateRangeLabel) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:minimumSlider];
	
	UILabel *maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, 60, 50)];
	maxLabel.text = @"Maximum";
	maxLabel.font = minLabel.font;
	[self.view addSubview:maxLabel];
	
	maximumSlider = [[UISlider alloc] initWithFrame:CGRectMake(70, 230, 200, 50)];
	maximumSlider.minimumValue = 0;
	maximumSlider.maximumValue = 1000;
	[maximumSlider addTarget:self action:@selector(updateRangeLabel) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:maximumSlider];

}

-(void)updateRangeLabel{
	label.text = [NSString stringWithFormat:@"$%d-%d", self.minimumPrice, self.maximumPrice];
}

-(void)setMinimumPrice:(NSInteger)minimumPrice{
	minimumSlider.value = minimumPrice;
	[self updateRangeLabel];
}
-(void)setMaximumPrice:(NSInteger)maximumPrice{
	if(maximumPrice){
		maximumSlider.value = maximumPrice;
		[self updateRangeLabel];
	}
}
-(NSInteger)minimumPrice{
	return round(minimumSlider.value);
}
-(NSInteger)maximumPrice{
	return round(maximumSlider.value);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
