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

- (NSArray *) infoForFiles:(NSArray *) files inDirectory:(NSString *)directory suffixed:(NSString *)suffix {
    NSMutableArray* filesAndProperties = [NSMutableArray arrayWithCapacity:[files count]];
    for(NSString* file in files) {
        NSString* filePath = [directory stringByAppendingPathComponent:file];
        
        if ([filePath hasSuffix:suffix]) {            
            NSDictionary* properties    = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            NSDate* modificationDate    = [properties objectForKey:NSFileModificationDate];                        
            [filesAndProperties addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                           file,                @"path",
                                           modificationDate,    NSFileModificationDate,
                                           nil]];                             
        }
    }
    return filesAndProperties;
}

#pragma mark - Public

- (NSArray *) listFilesWithSuffix:(NSString *)suffix {
    
    NSString *documentsDirectory    = [self documentsDirectory];        
    NSArray *files                  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:nil];
    NSMutableArray *result          = [NSMutableArray arrayWithCapacity:[files count]];
    
    NSArray* filesAndProperties     = [self infoForFiles:files inDirectory:documentsDirectory suffixed:suffix];
    
    NSArray* sortedFiles            = [filesAndProperties sortedArrayUsingComparator:^(id path1, id path2) {                               
        return [[path2 objectForKey:NSFileModificationDate] 
                compare:[path1 objectForKey:NSFileModificationDate]];
    }];
    
    for (NSDictionary *fileAndProperty in sortedFiles) {
        FileInfo *newFileInfo = [[FileInfo alloc] initWithFileName:[fileAndProperty objectForKey:@"path"]
                                               andModificationDate:[fileAndProperty objectForKey:NSFileModificationDate]];
        [result addObject:newFileInfo];
    }
    
    return result;
}

@end
