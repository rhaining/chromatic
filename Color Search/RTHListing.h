//
//  RTHListing.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTHCategory;

@interface RTHListing : NSObject

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *listingId;
@property (nonatomic, copy) NSURL *url;


+ (void)listingsForHexColor:(NSString *)hexColor category:(RTHCategory *)category keyword:(NSString *)keyword minimumPrice:(NSInteger)minimumPrice maximumPrice:(NSInteger)maximumPrice withBlock:(void (^)(NSArray *posts, NSError *error))block ;
- (void)imageWithBlock:(void (^)(NSURL *imageURL, NSError *error))block;

@end
