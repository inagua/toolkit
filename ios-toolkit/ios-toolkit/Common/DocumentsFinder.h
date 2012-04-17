//
//  DocumentsFinder.h
//  ios-toolkit
//
//  Created by Stéphane Tavera on 4/17/12.
//  Copyright (c) 2012 ch.inagua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentsFinder : NSObject

- (NSString *) documentsDirectory;

/*
 Returns the list of FileInfo objects with given suffix ordered by modification date. 
 A FileInfo is a structure containing the filename and the modification date.
 */
- (NSArray *) listFilesWithSuffix:(NSString *)suffix;

@end
