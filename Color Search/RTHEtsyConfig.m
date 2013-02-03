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



/**

add a config.plist file with the following format:
 
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
 <key>etsy_api_key</key>
 <string>PUT_ETSY_API_KEY_HERE</string>
 </dict>
 </plist>



*/