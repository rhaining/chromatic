//
//  MagnifierView.h
//  SimplerMaskTest
//
// adapted from http://coffeeshopped.com/2010/03/a-simpler-magnifying-glass-loupe-view-for-the-iphone
//

#import <UIKit/UIKit.h>

@interface MagnifierView : UIView {
	UIView *viewToMagnify;
	CGPoint touchPoint;
}

@property (nonatomic, strong) UIView *viewToMagnify;
@property (nonatomic) CGPoint touchPoint;

@end
