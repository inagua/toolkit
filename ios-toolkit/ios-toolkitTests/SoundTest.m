//
//  SoundTest.m
//  ios-toolkit
//
//  Created by Stéphane Tavera on 1/26/12.
//  Copyright (c) 2012 ch.inagua. All rights reserved.
//

#import "SoundTest.h"
#import "Sound.h"

@implementation SoundTest

- (void) playSound {
    [[Sound sharedInstance] playSoundNamed:@"car_start.aiff"];  
}

// Test by aural inspection ;-)
// Does not work yet : no sound is heard
- (void) testPlaySound {        
    [self performSelectorOnMainThread:@selector(playSound) withObject:nil waitUntilDone:YES];    
}

@end
