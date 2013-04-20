//
//  RTHHomeViewController.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/16/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHHomeViewController.h"
#import "RTHAboutViewController.h"
#import "RTHHomeView.h"
#import "RTHColorSelectionViewController.h"
#import "RTHSearchViewController.h"
#import "RTHColorHistory.h"
#import "RTHImageUtil.h"
#import "RTHAnalytics.h"

@interface RTHHomeViewController ()

@end

@implementation RTHHomeViewController

-(id)init{
	if(self = [super init]){
		self.title = @"chromatic";
	}
	return self;
}

-(void)loadView{
	[super loadView];
	BOOL cameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
	RTHHomeView *homeView = [[RTHHomeView alloc] initWithFrame:self.view.bounds cameraAvailable:cameraAvailable];
	[self.view addSubview:homeView];
	
	self.navigationController.navigationBar.tintColor = homeView.backgroundColor;
}

- (void)viewDidLoad{
    [super viewDidLoad];

	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStyleBordered target:self action:@selector(presentAbout)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentAbout{
	RTHAboutViewController *vc = [[RTHAboutViewController alloc] init];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
	[RTHAnalytics addNavigationController:nav];
	nav.navigationBar.barStyle = self.navigationController.navigationBar.barStyle;
	nav.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
	[self presentViewController:nav animated:YES completion:nil];
}

-(void)selectNewImage:(UIImagePickerControllerSourceType)sourceType{
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//	[RTHAnalytics addNavigationController:imagePicker];
	imagePicker.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
	imagePicker.navigationBar.barStyle = self.navigationController.navigationBar.barStyle;
	imagePicker.sourceType = sourceType;
	imagePicker.delegate = self;
	[self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)presentPhotoAlbum{
	[self selectNewImage:UIImagePickerControllerSourceTypePhotoLibrary];
	[RTHAnalytics logPhotoAlbumView];
}
-(void)presentCamera{
	[self selectNewImage:UIImagePickerControllerSourceTypeCamera];
	[RTHAnalytics logCameraView];
}

-(void)presentHistory{
	RTHColorHistoryViewController *vc = [[RTHColorHistoryViewController alloc] initWithStyle:UITableViewStylePlain];
//	vc.delegate = self;
	[self.navigationController pushViewController:vc animated:YES];
//	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//	nav.navigationBar.barStyle = self.navigationController.navigationBar.barStyle;
//	nav.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
//	[self presentViewController:nav animated:YES completion:nil];
}


/*
#pragma mark color history delegate
-(void)colorHistoryViewController:(RTHColorHistoryViewController *)viewController didSelectColor:(UIColor *)color{
	[viewController dismissViewControllerAnimated:YES completion:nil];

	self.navigationController.navigationBar.tintColor = color;
	
	NSString *hex = [RTHColorUtil getHexStringForColor:color];
	RTHSearchViewController *vc = [[RTHSearchViewController alloc] initWithColorHex:hex];
	[self.navigationController pushViewController:vc animated:YES];
	
	[RTHColorHistory addColorHex:hex];

}
*/


#pragma mark - uiimagepickercontrollerdelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//	NSLog(@"info = %@", info);
	UIImage *image = info[UIImagePickerControllerOriginalImage];
	image = [RTHImageUtil fixOrientationForImage:image];
	RTHColorSelectionViewController *vc = [[RTHColorSelectionViewController alloc] initWithImage:image];
	[self dismissViewControllerAnimated:YES completion:nil];
	[self.navigationController pushViewController:vc animated:YES];
	NSString *source = nil;
	switch (picker.sourceType) {
		case UIImagePickerControllerSourceTypeCamera:
			source = @"camera";
			break;
		case UIImagePickerControllerSourceTypePhotoLibrary:
			source = @"photo library";
			break;
		case UIImagePickerControllerSourceTypeSavedPhotosAlbum:
			source = @"saved photos album";
			break;
		default:
			break;
	}
	if(source){
		[RTHAnalytics logImageSelectionFromSource:source];
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[self dismissViewControllerAnimated:YES completion:nil];
}



//-(void)presentImageOptions{
//	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//		UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Select your option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Album", nil];
//		[sheet showInView:self.view];
//	}else{
//		[self presentPhotoAlbum];
//	}
//}
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//	if(buttonIndex == actionSheet.cancelButtonIndex){
//		return;
//	}
//	switch (buttonIndex) {
//		case 0:
//			[self presentCamera];
//			break;
//		case 1:
//			[self presentPhotoAlbum];
//			break;
//		default:
//			[self presentImageOptions];
//			break;
//	}
//}

@end
