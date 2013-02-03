//
//  RTHEtsyConfig.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/3/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHEtsyConfig.h"

@implementation RTHEtsyConfig

+(NSString *)etsyAPIKey{
	NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"config.plist"];
	NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:path];
	NSString *apiKey = plistData[@"etsy_api_key"];
	return apiKey;
}

@end
