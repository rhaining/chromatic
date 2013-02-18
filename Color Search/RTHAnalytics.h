//
//  RTHAnalytics.h
//  Chromatic
//
//  Created by Robert Tolar Haining on 2/18/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTHAnalytics : NSObject

+(void)start;
+(void)addNavigationController:(UINavigationController *)navigationController;
+(void)logHomeView;
+(void)logAboutView;
+(void)logCameraView;
+(void)logPhotoAlbumView;
+(void)logColorHistoryView;
+(void)logImageSelectionFromSource:(NSString *)source;
+(void)logSearchSelectedColor;
+(void)logSearchComplementaryColor;
+(void)logResultsView;
+(void)logDidModifyCategory;
+(void)logDidModifyPrice;
+(void)logDidModifyKeyword;
+(void)logListingView;
+(void)logEtsyView;

@end
