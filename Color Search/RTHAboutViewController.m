//
//  RTHAboutViewController.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/10/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHAboutViewController.h"

@interface RTHAboutViewController ()

@end

@implementation RTHAboutViewController

- (id)init{
    if (self = [super init]) {
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSelf)];
		self.title = @"About";
    }
    return self;
}

-(void)dismissSelf{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];

	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
	label.text = @"made with love in new york city\nat the fashion hackathon\n\ngabriela anastasio\nrobert tolar haining\nphillip huynh\nmara isip\nrob van wyen";
	label.textColor = [UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1.0];
	label.font = [UIFont fontWithName:@"Georgia" size:18];
	label.textAlignment = UITextAlignmentCenter;
	label.numberOfLines = 0;
	label.backgroundColor = self.view.backgroundColor;
	[self.view addSubview:label];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *buttonImage = [UIImage imageNamed:@"etsy_badge.gif"];
	[button setImage:buttonImage forState:UIControlStateNormal];
	button.frame = CGRectMake((self.view.frame.size.width - buttonImage.size.width) / 2.0, CGRectGetMaxY(label.frame) + 75,
							  buttonImage.size.width, buttonImage.size.height);
	[button addTarget:self action:@selector(openEtsy) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
}
-(void)openEtsy{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.etsy.com/developers"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
