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
#import "RTHNavigationController.h"

@interface RTHHomeViewController ()
@property (nonatomic, strong) RTHHomeView *homeView;
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
	self.homeView = [[RTHHomeView alloc] initWithFrame:self.view.bounds cameraAvailable:cameraAvailable];
    [self.homeView.cameraButton addTarget:self action:@selector(presentCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.albumButton addTarget:self action:@selector(presentPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.historyButton addTarget:self action:@selector(presentHistory) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.homeView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.navigationController.navigationBar.barTintColor){
        self.homeView.backgroundColor = self.navigationController.navigationBar.barTintColor;
    }
//    self.homeView
//    self.navigationController.navigationBar.tintColor = [RTHColorUtil inverseColorFromColor:color];
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
	UINavigationController *nav = [[RTHNavigationController alloc] initWithRootViewController:vc];
	[RTHAnalytics addNavigationController:nav];
	nav.navigationBar.barStyle = self.navigationController.navigationBar.barStyle;
	nav.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
	nav.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
	[self presentViewController:nav animated:YES completion:nil];
}

-(void)selectNewImage:(UIImagePickerControllerSourceType)sourceType{
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
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
	[self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - uiimagepickercontrollerdelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
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


@end
