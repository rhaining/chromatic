//
//  RTHEtsyClient.h
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "AFHTTPClient.h"

@interface RTHEtsyClient : AFHTTPClient

+ (RTHEtsyClient *)sharedClient;

@end
