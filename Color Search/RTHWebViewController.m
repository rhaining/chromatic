//
//  RTHWebViewController.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 3/30/14.
//  Copyright (c) 2014 Robert Tolar Haining. All rights reserved.
//

#import "RTHWebViewController.h"

@interface RTHWebViewController ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *filepath;
@end

@implementation RTHWebViewController

- (id)initWithFile:(NSString *)filepath{
    self = [super init];
    if (self) {
        self.filepath = filepath;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSURL *fileURL = [NSURL fileURLWithPath:self.filepath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:fileURL]];    
}

@end
