//
//  DocumentsFinderTest.m
//  ios-toolkit
//
//  Created by Stéphane Tavera on 4/17/12.
//  Copyright (c) 2012 ch.inagua. All rights reserved.
//

#import "DocumentsFinderTest.h"
#import "FileInfo.h"

@implementation DocumentsFinderTest

- (void) writeString:(NSString *)s toFile:(NSString *)filename {    
    [s writeToFile:[[df documentsDirectory] stringByAppendingPathComponent:filename] atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

- (void) setUp {
    df              = [[DocumentsFinder alloc] init];
    tmpFilenames    = [NSArray arrayWithObjects:@"first.test1", @"second.test1", nil];                        
    for (NSString *filename in tmpFilenames) {        
        [self writeString:filename toFile:filename];
    }    
}

- (void) tearDown {    
    NSFileManager *fm   = [NSFileManager defaultManager];    
    for (NSString *filename in tmpFilenames) {                
        NSError *error = nil;
        BOOL success = [fm removeItemAtPath:[[df documentsDirectory] stringByAppendingPathComponent:filename] error:&error];
        if (!success || error) {
            STFail(@"unable to delete tmp files");
        }
    }
}

# pragma mark - Tests

- (void) testDocumentsDirectoryLooksOK {    
    NSArray *pathComponents = [[df documentsDirectory] pathComponents];    
    STAssertTrue([pathComponents containsObject:@"Users"], @"");
    STAssertTrue([pathComponents containsObject:@"Application Support"], @"");
    STAssertTrue([pathComponents containsObject:@"iPhone Simulator"], @"");
    STAssertTrue([pathComponents containsObject:@"Documents"], @"");
}

- (void) testListFilesWithSuffixReturnsEmptyArrayWhenNoFiles {    
    NSArray *files = [df listFilesWithSuffix:@"XYZ"];
    STAssertEquals((int)[files count], 0, @"");    
}

- (void) testListFilesWithSuffix {        
    NSArray *files = [df listFilesWithSuffix:@"test1"];

    STAssertEquals((int)[files count], 2, @"");         
    FileInfo *fileInfo1 = [files objectAtIndex:0];
    FileInfo *fileInfo2 = [files objectAtIndex:1];        

    STAssertEqualObjects(fileInfo1.fileName, @"first.test1", @""); 
    STAssertEquals([fileInfo1.fileSize intValue], 11, @""); 
    
    STAssertEqualObjects(fileInfo2.fileName, @"second.test1", @"");
    STAssertEquals([fileInfo2.fileSize intValue], 12, @""); 
}

@end
