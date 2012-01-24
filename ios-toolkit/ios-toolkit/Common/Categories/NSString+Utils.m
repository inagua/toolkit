//
//  NSString+Utils.m
//  inagua
//
//  Created by Jacques COUVREUR on 18.08.11.
//  Copyright 2011 inagua.ch. All rights reserved.
//

#import "NSString+Utils.h"


@implementation NSString (NSString_Utils)

+ (BOOL) areEqualsOrNils:(NSString*)a other:(NSString*)b {
    if (a == nil && b == nil) return YES;
    if ((a == nil || b == nil) && ([a isBlank] || [b isBlank])) return YES;
    return [a isEqualToString:b];
}

+ (BOOL) isBlankOrNil:(NSString*)s {
    return s == nil || [s isBlank];
}

+ (BOOL) isFilled:(NSString*)s {
    return ! [NSString isBlankOrNil:s];
}

- (BOOL) isFilled {
    return ! [self isBlank];
}

- (NSString*) trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL) isEmpty {
    return ![self length];
}

- (BOOL) isBlank {
    return [[self trim] isEmpty];
}

- (NSString*) lastCharacter{
    if ([self isEmpty]) {
        return nil;
    }
    return [self substringFromIndex:([self length] - 1)];
}


- (NSString*) append:(NSString*) string {
    if (!string || [string isEmpty]) {
        return self;
    }
    return [self stringByAppendingFormat:@"%@", string];
}


- (NSString*) appendSpace {
    return [self append:@" "];
}


- (NSString*) appendNewLineChar {
    return [self append:@"\n"];
}

- (NSString*) replaceLastCharacterWith:(NSString*) string {
    if ([self isEmpty] || !string) {
        return self;
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange([self length] - 1, 1) withString:string];
}

- (NSString*) removeLastCharacter {
    return [self replaceLastCharacterWith:@""];
}

- (BOOL) contains:(NSString*) string{
    if (!string) {        
        [NSException raise:NSInvalidArgumentException format:@"String may not be nil."];
    }
    
    if ([string isEmpty]) {
        return YES;
    }
    return ([self rangeOfString:string].location != NSNotFound);
}

- (NSString *)rightPadOn:(int)nb {
    int delta = nb - [self length];
    
    if (delta>0) {
        for (int i=0; i<delta; i++) {
            self = [self append:@" "];
        }
    }
    return self;
}

+ (NSString*) stringOrBlankIfNil:(NSString*)string {
    if (string) return string;
    return @"";
}

@end
