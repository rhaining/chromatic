//
//  RTHColorHistory.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/3/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTHColorHistory : NSObject

+(void)addColorHex:(NSString *)colorHex;
+(NSArray *)recentColors;

@end
