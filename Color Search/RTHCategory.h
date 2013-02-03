//
//  RTHCategory.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTHCategory : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, copy) NSString *displayName;

+ (void)categoriesWithBlock:(void (^)(NSArray *categories, NSError *error))block ;

@end
