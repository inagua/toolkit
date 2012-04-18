//
//  FileInfo.h
//
//  Created by Stéphane Tavera on 2/29/12.
//  Copyright (c) 2012 inagua.ch. All rights reserved.
//


@interface FileInfo : NSObject {
    
    NSString    *fileName;
    NSDate      *modificationDate;
    NSNumber    *fileSize;

}

@property(nonatomic, retain) NSString   *fileName;
@property(nonatomic, retain) NSDate     *modificationDate;
@property(nonatomic, retain) NSNumber   *fileSize;

- (id) initWithFileName:(NSString *)fn fileSize:(NSNumber *)fs modificationDate:(NSDate *)md;

@end
