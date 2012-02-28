//
//  Sound.h
//  
//  Created by Stéphane Tavera on 6/12/10.
//  Copyright 2010 inagua.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define PATH_SOUNDS @"/Sounds"

@interface Sound : NSObject {	    
    NSMutableDictionary *playerPerSound;    
}

+ (Sound *)sharedInstance;

- (void) playSoundNamed:(NSString *)soundName;	
- (void) loopSoundNamed:(NSString *)soundName;

@end
