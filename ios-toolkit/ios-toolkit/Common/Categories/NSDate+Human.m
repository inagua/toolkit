//
//  NSDate+Human.m
//  inHout
//
//  Created by Jacques COUVREUR on 02.01.12.
//  Copyright 2012 me.couvreur.ios. All rights reserved.
//

#import "NSDate+Human.h"


@implementation NSDate (Human)

- (NSString*) humanDisplay {
    static NSDateFormatter* dateFormatter;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        //    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
        //    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"EEEE d MMMM yyyy 'à' HH:mm"];
    }

    return [dateFormatter stringFromDate:self];
}

@end
