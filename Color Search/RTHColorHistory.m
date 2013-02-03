//
//  RTHColorHistory.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/3/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHColorHistory.h"

@implementation RTHColorHistory

#define COLOR_LIST_KEY @"kRTHColorList"
#define COLOR_LIST_LIMIT 20

+(void)addColorHex:(NSString *)colorHex{
	NSMutableArray *colors = [[self recentColorHexList] mutableCopy];
	if(!colors){
		colors = [NSMutableArray arrayWithCapacity:1];
	}
	[colors addObject:colorHex];
	if(colors.count > COLOR_LIST_LIMIT){
		[colors removeObjectAtIndex:0];
	}
//	NSLog(@"colors = %@", colors);
	[self saveColors:colors];
}
+(void)saveColors:(NSArray *)colors{
	[[NSUserDefaults standardUserDefaults] setObject:colors forKey:COLOR_LIST_KEY];
	[[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSArray *)recentColorHexList{
	NSArray *colorHexList = [[NSUserDefaults standardUserDefaults] arrayForKey:COLOR_LIST_KEY];
	return colorHexList;
}
+(NSArray *)recentColors{
	NSArray *colorHexList = [self recentColorHexList];
	NSMutableArray *colors = [NSMutableArray arrayWithCapacity:colorHexList.count];
	for(NSString *colorHex in colorHexList){
		UIColor *color = [self colorWithHexString:colorHex];
		[colors addObject:color];
	}
	return [NSArray arrayWithArray:colors];
}


// https://github.com/ars/uicolor-utilities/blob/master/UIColor-Expanded.m
// Returns a UIColor by scanning the string for a hex number and passing that to +[UIColor colorWithRGBHex:]
// Skips any leading whitespace and ignores any trailing characters
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
	NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
	unsigned hexNum;
	if (![scanner scanHexInt:&hexNum]) return nil;
	return [self colorWithRGBHex:hexNum];
}
+ (UIColor *)colorWithRGBHex:(UInt32)hex {
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}

@end
