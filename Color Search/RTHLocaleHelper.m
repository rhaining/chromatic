//
//  RTHLocaleHelper.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/10/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHLocaleHelper.h"

@implementation RTHLocaleHelper


//adapted from http://stackoverflow.com/questions/6908834/how-to-get-nslocale-from-currency-code
+ (NSLocale *) findLocaleByCurrencyCode:(NSString *)currencyCode{
	NSArray *locales = [NSLocale availableLocaleIdentifiers];
	NSLocale *locale = nil;
	NSString *localeId;
	
	for (localeId in locales) {
		locale = [[NSLocale alloc] initWithLocaleIdentifier:localeId];
		NSString *code = [locale objectForKey:NSLocaleCurrencyCode];
		if ([code isEqualToString:currencyCode]){
			break;
		}else{
			locale = nil;
		}
	}
	
	/* For some codes that locale cannot be found, init it different way. */
	if (!locale) {
        if(currencyCode){
            NSDictionary *components = @{NSLocaleCurrencyCode : currencyCode};
            localeId = [NSLocale localeIdentifierFromComponents:components];
            locale = [[NSLocale alloc] initWithLocaleIdentifier:localeId];
        }else if(locales.count > 0){
            locale = locales[0];
        }
	}
	return locale;
}

@end
