//
//  RTHListing.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHListing.h"
#import "RTHEtsyClient.h"
#import "AFImageRequestOperation.h"
#import "RTHCategory.h"
#import "RTHEtsyConfig.h"
#import "NSString+HTML.h"

@implementation RTHListing

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
//    NSLog(@"attributes = %@", attributes);
	
	self.title = [attributes[@"title"] stringByDecodingHTMLEntities];
	self.listingId = attributes[@"listing_id"];
	self.etsyWebURL = [NSURL URLWithString:attributes[@"url"]];
	
	NSArray *images = attributes[@"Images"];
	if(images.count > 0){
		NSDictionary *imgAttributes = images[0];
		self.imageURL = [NSURL URLWithString:imgAttributes[@"url_170x135"]];
		self.largeImageURL = [NSURL URLWithString:imgAttributes[@"url_570xN"]];
	}

	self.price = attributes[@"price"];
	self.currencyCode = attributes[@"currency_code"];
	
	self.itemDescription = [attributes[@"description"] stringByDecodingHTMLEntities];
	
	NSDictionary *shop = attributes[@"Shop"];
	if(shop && shop.count > 0){
		self.shopName = [shop[@"title"] stringByDecodingHTMLEntities];
		self.shopURL = [NSURL URLWithString:shop[@"url"]];
	}
	
//	self.imageURL =
//    _postID = [[attributes valueForKeyPath:@"id"] integerValue];
//    _text = [attributes valueForKeyPath:@"text"];
//    
//    _user = [[User alloc] initWithAttributes:[attributes valueForKeyPath:@"user"]];
    
    return self;
}

-(NSURL *)etsyAppURL{
	return [NSURL URLWithString:[NSString stringWithFormat:@"etsy://listing/%@", self.listingId]];
}

#pragma mark -

+ (void)listingsForHexColor:(NSString *)hexColor category:(RTHCategory *)category keyword:(NSString *)keyword minimumPrice:(NSInteger)minimumPrice maximumPrice:(NSInteger)maximumPrice offset:(NSInteger)offset withBlock:(void (^)(NSArray *listings, NSInteger nextSearchOffset, NSError *error))block {
	NSMutableDictionary *params = [@{
								   @"sort_on" : @"created",
								   @"sort_order" : @"down",
								   @"color" : hexColor,
								   @"color_accuracy" : @"30",
								   @"api_key" : [RTHEtsyConfig etsyAPIKey],
								   @"includes" : @"Images:1:0,Shop"
								   } mutableCopy];
	if(category){
		params[@"category"] = category.name;
	}
	if(keyword){
		params[@"keywords"] = keyword;
		params[@"sort_on"] = @"score";
	}
	if(maximumPrice){
		params[@"min_price"] = [NSString stringWithFormat:@"%d", minimumPrice];
		params[@"max_price"] = [NSString stringWithFormat:@"%d", maximumPrice];
	}
	if(offset > 0){
		params[@"offset"] = [NSString stringWithFormat:@"%d", offset];
	}
	
	
    [[RTHEtsyClient sharedClient] getPath:@"v2/private/listings/active" parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"results"];
        NSMutableArray *mutableListings = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary *attributes in postsFromResponse) {
            RTHListing *listing = [[RTHListing alloc] initWithAttributes:attributes];
            [mutableListings addObject:listing];
        }
		
		NSDictionary *pagination = [JSON valueForKeyPath:@"pagination"];
		NSInteger nextSearchOffset = -1;
		if(pagination[@"next_offset"] != [NSNull null]){
			nextSearchOffset = [pagination[@"next_offset"] intValue];
        }
		
        if (block) {
            block([NSArray arrayWithArray:mutableListings], nextSearchOffset, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], -1, error);
        }
    }];
}
/*
- (void)imageWithBlock:(void (^)(NSURL *imageURL, NSError *error))block {
	NSDictionary *params = @{@"api_key" : @""};
	NSString *path = [NSString stringWithFormat:@"v2/private/listings/%@/images/", self.listingId];
    [[RTHEtsyClient sharedClient] getPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"results"];
		if(postsFromResponse.count > 0){
			NSDictionary *attributes = postsFromResponse[0];
			NSString *imageURLString = attributes[@"url_170x135"];
			self.imageURL = [NSURL URLWithString:imageURLString];
		}
        
        if (block) {
            block(self.imageURL, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}
*/
@end
