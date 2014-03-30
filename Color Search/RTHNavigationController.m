//
//  RTHNavigationController.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 3/30/14.
//  Copyright (c) 2014 Robert Tolar Haining. All rights reserved.
//

#import "RTHNavigationController.h"

@interface RTHNavigationController ()

@end

@implementation RTHNavigationController

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];

    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

}

@end
