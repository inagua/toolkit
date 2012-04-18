//
//  DocumentsFinder.m
//  ios-toolkit
//
//  Created by Stéphane Tavera on 4/17/12.
//  Copyright (c) 2012 ch.inagua. All rights reserved.
//

#import "DocumentsFinder.h"
#import "FileInfo.h"

@implementation DocumentsFinder

#pragma mark - Private

- (NSString *) documentsDirectory {
    return [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

- (NSArray *) infoForFileNames:(NSArray *) fileNames inDirectory:(NSString *)directory suffixed:(NSString *)suffix {

    NSMutableArray* filesAndProperties = [NSMutableArray arrayWithCapacity:[fileNames count]];

    for(NSString *fileName in fileNames) {
        NSString *filePath = [directory stringByAppendingPathComponent:fileName];
        
        if ([filePath hasSuffix:suffix]) {            
            NSDictionary *properties    = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            NSDate *modificationDate    = [properties objectForKey:NSFileModificationDate];                        
            NSNumber *fileSize          = [properties objectForKey:NSFileSize];                        
            
            [filesAndProperties addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                           fileName,            @"fileName",
                                           modificationDate,    NSFileModificationDate,
                                           fileSize,            NSFileSize,
                                           nil]];                             
        }
    }
    return filesAndProperties;
}

#pragma mark - Public

- (NSArray *) listFilesWithSuffix:(NSString *)suffix {
    
    NSString *documentsDirectory    = [self documentsDirectory];        
    NSArray *fileNames              = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:nil];
    NSMutableArray *result          = [NSMutableArray arrayWithCapacity:[fileNames count]];
    
    NSArray* filesAndProperties     = [self infoForFileNames:fileNames inDirectory:documentsDirectory suffixed:suffix];
    
    NSArray* sortedFiles            = [filesAndProperties sortedArrayUsingComparator:^(id path1, id path2) {                               
        return [[path2 objectForKey:NSFileModificationDate] 
                compare:[path1 objectForKey:NSFileModificationDate]];
    }];
    
    for (NSDictionary *fileAndProperty in sortedFiles) {
        FileInfo *newFileInfo = [[FileInfo alloc] initWithFileName:[fileAndProperty objectForKey:@"fileName"]
                                                          fileSize:[fileAndProperty objectForKey:NSFileSize]
                                                   modificationDate:[fileAndProperty objectForKey:NSFileModificationDate]];
        [result addObject:newFileInfo];
    }
    
    return result;
}

@end
