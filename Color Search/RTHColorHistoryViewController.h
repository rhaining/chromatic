//
//  RTHColorHistoryViewController.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/3/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTHColorHistoryViewControllerDelegate;

@interface RTHColorHistoryViewController : UITableViewController{
	NSArray *colors;
}
@property (nonatomic, weak) id<RTHColorHistoryViewControllerDelegate> delegate;

@end


@protocol RTHColorHistoryViewControllerDelegate <NSObject>

@required
-(void)colorHistoryViewController:(RTHColorHistoryViewController *)viewController didSelectColor:(UIColor *)color;

@end