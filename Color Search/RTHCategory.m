//
//  RTHCategory.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHCategory.h"
#import "RTHEtsyClient.h"
#import "RTHEtsyConfig.h"

@implementation RTHCategory


- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
//    NSLog(@"attributes = %@", attributes);
	
	self.name = attributes[@"name"];
	self.displayName = attributes[@"long_name"];
	self.shortName = attributes[@"short_name"];
    
    return self;
}

#pragma mark -

+ (void)categoriesWithBlock:(void (^)(NSArray *categories, NSError *error))block{
	NSDictionary *params = @{
	@"api_key" : [RTHEtsyConfig etsyAPIKey]
	};
	
    [[RTHEtsyClient sharedClient] getPath:@"v2/private/taxonomy/categories" parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"results"];
        NSMutableArray *mutableCategories = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary *attributes in postsFromResponse) {
            RTHCategory *category = [[RTHCategory alloc] initWithAttributes:attributes];
            [mutableCategories addObject:category];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableCategories], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

@end
