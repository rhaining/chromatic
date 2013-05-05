//
//  RTHAnalytics.m
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/18/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHAnalytics.h"
#import "Flurry.h"

@implementation RTHAnalytics

+(void)start{
	[Flurry startSession:@"XWV6927CDGHXHM9ZN86B"];
//	[Flurry setDebugLogEnabled:YES];
}
+(void)addNavigationController:(UINavigationController *)navigationController{
	[Flurry logAllPageViews:navigationController];
}
+(void)logEvent:(NSString *)event{
	[Flurry logEvent:event];
}
+(void)logEvent:(NSString *)event parameters:(NSDictionary *)parameters{
	[Flurry logEvent:event withParameters:parameters];
}
+(void)logHomeView{
	[self logEvent:@"Home"];
}
+(void)logAboutView{
	[self logEvent:@"About"];
}
+(void)logCameraView{
	[self logEvent:@"Camera"];
}
+(void)logPhotoAlbumView{
	[self logEvent:@"PhotoAlbum"];
}
+(void)logColorHistoryView{
	[self logEvent:@"ColorHistory"];
}
+(void)logImageSelectionFromSource:(NSString *)source{
	[self logEvent:@"ImageSelection" parameters:@{@"source" : source}];
}
+(void)logSearchSelectedColor{
	[self logEvent:@"SearchSelectedColor"];
}
+(void)logSearchComplementaryColor{
	[self logEvent:@"SearchComplementaryColor"];
}
+(void)logResultsView{
	[self logEvent:@"Results"];
}
+(void)logDidModifyCategory{
	[self logEvent:@"DidModifyCategory"];
}
+(void)logDidModifyPrice{
	[self logEvent:@"DidModifyPrice"];
}
+(void)logDidModifyKeyword{
	[self logEvent:@"DidModifyKeyword"];
}
+(void)logListingView{
	[self logEvent:@"Listing"];
}
+(void)logEtsyView:(BOOL)app{
	NSString *target = app ? @"app" : @"web";
	[self logEvent:@"Etsy" parameters:@{@"target" : target}];
}

@end
