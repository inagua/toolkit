//
//  NSString+UtilsTest.m
//  Celli
//
//  Created by Stéphane Tavera on 5/25/11.
//  Copyright 2011 inagua.ch. All rights reserved.
//

#import "NSString+UtilsTest.h"
#import "NSString+Utils.h"

@implementation NSString_UtilsTest

- (void)testTrim {
    NSString* nilString = nil;
    STAssertEqualObjects([nilString trim], nil, @"");
    
    STAssertEqualObjects([@"" trim], @"", @"");
    STAssertEqualObjects([@"1" trim], @"1", @"");
    STAssertEqualObjects([@"123" trim], @"123", @"");
    STAssertEqualObjects([@" " trim], @"", @"");
    STAssertEqualObjects([@"123 " trim], @"123", @"");
    STAssertEqualObjects([@" 123" trim], @"123", @"");
    STAssertEqualObjects([@" 123 " trim], @"123", @"");
    STAssertEqualObjects([@" 1 23 " trim], @"1 23", @"");
    STAssertEqualObjects([@"    1 23       " trim], @"1 23", @"");
    STAssertEqualObjects([@"                  " trim], @"", @"");
}

- (void)testGettingLastCharacter {
    
    NSString* nilString = nil;
    STAssertEqualObjects([nilString lastCharacter], nil, @"");
    
    STAssertEqualObjects([@"" lastCharacter], nil, @"");
    STAssertEqualObjects([@"1" lastCharacter], @"1", @"");
    STAssertEqualObjects([@"123" lastCharacter], @"3", @"");
    STAssertEqualObjects([@" " lastCharacter], @" ", @"");
    STAssertEqualObjects([@"123 " lastCharacter], @" ", @"");
}

- (void)testIsBlank {
    NSString* nilString = nil;
    STAssertFalse([nilString isBlank], @"");
    
    STAssertTrue([@"" isBlank], @"");
    STAssertTrue([@" " isBlank], @"");
    STAssertTrue([@"  " isBlank], @"");
    
    STAssertFalse([@"." isBlank], @"");
    STAssertFalse([@"a " isBlank], @"");
    }


- (void)testAppendString {
    
    NSString* nilString = nil;
    STAssertEqualObjects([nilString append:@"a"], nil, @"");
    
    STAssertEqualObjects([@"" append:@"a"], @"a", @"");
    STAssertEqualObjects([@"1" append:@"a"], @"1a", @"");
    STAssertEqualObjects([@"123" append:@"a"], @"123a", @"");
    STAssertEqualObjects([@" " append:@"a"], @" a", @"");
    STAssertEqualObjects([@"123 " append:@"a"], @"123 a", @"");
    
    STAssertEqualObjects([@"" append:@""], @"", @"");
    STAssertEqualObjects([@"1" append:@""], @"1", @"");
    STAssertEqualObjects([@"123" append:@""], @"123", @"");
    STAssertEqualObjects([@" " append:@""], @" ", @"");
    STAssertEqualObjects([@"123 " append:@""], @"123 ", @"");
    
    STAssertEqualObjects([@"" append:nilString], @"", @"");
    STAssertEqualObjects([@"1" append:nilString], @"1", @"");
    STAssertEqualObjects([@"123" append:nilString], @"123", @"");
    STAssertEqualObjects([@" " append:nilString], @" ", @"");
    STAssertEqualObjects([@"123 " append:nilString], @"123 ", @"");
}


- (void)testAppendSpace {
    
    NSString* nilString = nil;
    STAssertEqualObjects([nilString appendSpace], nil, @"");
    
    STAssertEqualObjects([@"" appendSpace], @" ", @"");
    STAssertEqualObjects([@"1" appendSpace], @"1 ", @"");
    STAssertEqualObjects([@"123" appendSpace], @"123 ", @"");
    STAssertEqualObjects([@" " appendSpace], @"  ", @"");
    STAssertEqualObjects([@"123 " appendSpace], @"123  ", @"");
}


- (void)testReplaceLastCharacter {
    
    NSString* nilString = nil;
    STAssertNil([nilString replaceLastCharacterWith:@"a"], @"");
    
    STAssertEqualObjects([@"" replaceLastCharacterWith:@"a"], @"", @"");
    STAssertEqualObjects([@"1" replaceLastCharacterWith:@"a"], @"a", @"");
    STAssertEqualObjects([@"123" replaceLastCharacterWith:@"a"], @"12a", @"");
    STAssertEqualObjects([@" " replaceLastCharacterWith:@"a"], @"a", @"");
    STAssertEqualObjects([@"123 " replaceLastCharacterWith:@"a"], @"123a", @"");
    
    STAssertEqualObjects([@"" replaceLastCharacterWith:@""], @"", @"");
    STAssertEqualObjects([@"1" replaceLastCharacterWith:@""], @"", @"");
    STAssertEqualObjects([@"123" replaceLastCharacterWith:@""], @"12", @"");
    STAssertEqualObjects([@" " replaceLastCharacterWith:@""], @"", @"");
    STAssertEqualObjects([@"123 " replaceLastCharacterWith:@""], @"123", @"");
    
    STAssertEqualObjects([@"" replaceLastCharacterWith:nilString], @"", @"");
    STAssertEqualObjects([@"1" replaceLastCharacterWith:nilString], @"1", @"");
    STAssertEqualObjects([@"123" replaceLastCharacterWith:nilString], @"123", @"");
    STAssertEqualObjects([@" " replaceLastCharacterWith:nilString], @" ", @"");
    STAssertEqualObjects([@"123 " replaceLastCharacterWith:nilString], @"123 ", @"");
}

- (void)testRemoveLastCharacter {
    
    NSString* nilString = nil;
    STAssertNil([nilString removeLastCharacter], @"");
    
    STAssertEqualObjects([@"" removeLastCharacter], @"", @"");
    STAssertEqualObjects([@"1" removeLastCharacter], @"", @"");
    STAssertEqualObjects([@"123" removeLastCharacter], @"12", @"");
    STAssertEqualObjects([@" " removeLastCharacter], @"", @"");
    STAssertEqualObjects([@"123 " removeLastCharacter], @"123", @"");
}

- (void) testContainsString {
    NSString* nilString = nil;
    STAssertFalse([nilString contains:@"1"], @"");

//  TODO_TEST
    STAssertThrowsSpecificNamed([@"123" contains:nilString], NSException, NSInvalidArgumentException, @"");

    STAssertFalse([@"" contains:@"1"], @"");
    STAssertTrue([@"" contains:@""], @"");
    STAssertTrue([@"1" contains:@""], @"");
    STAssertTrue([@"1" contains:@"1"], @"");
    STAssertTrue([@"11" contains:@"1"], @"");
}

- (void) testRightPadOn {
    STAssertEqualObjects([@"123" rightPadOn:5], @"123  ", @"");
    STAssertEqualObjects([@"123" rightPadOn:2], @"123", @"");
}

- (void) testStringOrBlankIfNil {
    STAssertEqualObjects([NSString stringOrBlankIfNil:nil],     @"", @"");
    STAssertEqualObjects([NSString stringOrBlankIfNil:@""],     @"", @"");
    STAssertEqualObjects([NSString stringOrBlankIfNil:@"123"],  @"123", @"");
    STAssertEqualObjects([NSString stringOrBlankIfNil:@"   "],  @"   ", @"");
}

@end
