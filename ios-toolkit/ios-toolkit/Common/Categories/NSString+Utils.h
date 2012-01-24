//
//  NSString+Utils.h
//  inagua
//
//  Created by Jacques COUVREUR on 18.08.11.
//  Copyright 2011 inagua.ch. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (NSString_Utils)

+ (BOOL) areEqualsOrNils:(NSString*)a other:(NSString*)b;

+ (BOOL) isBlankOrNil:(NSString*)s;
+ (BOOL) isFilled:(NSString*)s;

- (NSString*) trim;
- (NSString*) lastCharacter;
- (BOOL) isBlank;
- (NSString*) append:(NSString*) string;
- (NSString*) appendSpace;
- (NSString*) replaceLastCharacterWith:(NSString*) string;
- (NSString*) removeLastCharacter;
- (BOOL) contains:(NSString*) string;
- (NSString *)rightPadOn:(int)nb;

+ (NSString*) stringOrBlankIfNil:(NSString*)string;

- (BOOL) isBlank;
- (BOOL) isFilled;

- (BOOL) contains:(NSString*)substring;

@end
