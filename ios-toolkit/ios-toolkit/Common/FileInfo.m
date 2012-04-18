//
//  FileInfo.m
//
//  Created by Stéphane Tavera on 2/29/12.
//  Copyright (c) 2012 inagua.ch. All rights reserved.
//

#import "FileInfo.h"

@implementation FileInfo

@synthesize fileName;
@synthesize modificationDate;
@synthesize fileSize;

- (id) initWithFileName:(NSString *)fn fileSize:(NSNumber *)fs modificationDate:(NSDate *)md {
    self = [super init];
    
    if (self) {
        self.fileName           = fn;
        self.modificationDate   = md;
        self.fileSize           = fs;
    }
    
    return self;
}

- (void)dealloc {
    [fileName release];
    [modificationDate release];
    [fileSize release];
    
    [super dealloc];
}

- (NSString *) description {
    return [NSString stringWithFormat:@"(%@, %@, %@)", fileName, modificationDate, fileSize];
}

@end
