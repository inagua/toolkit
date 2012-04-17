//
//  FileInfo.h
//
//  Created by Stéphane Tavera on 2/29/12.
//  Copyright (c) 2012 inagua.ch. All rights reserved.
//


@interface FileInfo : NSObject {
    
    NSString    *fileName;
    NSDate      *modificationDate;

}

@property(nonatomic, retain) NSString    *fileName;
@property(nonatomic, retain) NSDate      *modificationDate;

- (id) initWithFileName:(NSString *)fn andModificationDate:(NSDate *)md;

@end
