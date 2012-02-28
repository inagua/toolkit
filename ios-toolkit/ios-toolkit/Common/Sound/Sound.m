//
//  Sound.m
//
//  Created by Stéphane Tavera on 6/12/10.
//  Copyright 2010 inagua.
//

#import "Sound.h"

static Sound *sharedInstance = nil;

@implementation Sound

+ (Sound *)sharedInstance{
    @synchronized(self){
        if (sharedInstance == nil){
			sharedInstance = [[Sound alloc] init];
			[sharedInstance playSoundNamed:@"clear_sound.aiff"];
		}			
    }
    return sharedInstance;
}

- (AVAudioPlayer *)createPlayer:(NSString *)soundName {
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
	resourcePath = [resourcePath stringByAppendingString:soundName];
	
	NSError *err;
	AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:resourcePath] error:&err];
	if ( err ){
		NSLog(@"Failed with reason: %@", [err localizedDescription]);	
	} else {
		NSLog(@"Created OK for %@", soundName);
	}	
	return player;	
}

-(id) init {
	if (self = [super init]) {		
        playerPerSound = [[NSMutableDictionary alloc] init];
        		        
        NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:PATH_SOUNDS];        
        NSError *error;
        NSArray* files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath 
                                                                             error:&error];
        for (NSString *fileName in files) {            
            NSString *pathForSound = [PATH_SOUNDS stringByAppendingPathComponent:fileName];                                    
            [playerPerSound setObject:[self createPlayer:pathForSound] forKey:fileName];                        
        }
	}	
	return self;
}

- (void) playSoundNamed:(NSString *)soundName loop:(BOOL)loop {	    
    AVAudioPlayer *player = [playerPerSound objectForKey:soundName];

    if (loop) {
        player.numberOfLoops = -1;
    }
    
    if (!player) {
        NSLog(@"ERROR : Unable to find sound named '%@'", soundName);
        return;
    }
    
    BOOL soundPlayed = [player play];
    if (!soundPlayed) {
        NSLog(@"ERROR : Unable to play sound '%@'", soundName);
    }
}

- (void) playSoundNamed:(NSString *)soundName {	    
    [self playSoundNamed:soundName loop:NO];
}

- (void) loopSoundNamed:(NSString *)soundName {
    [self playSoundNamed:soundName loop:YES];    
}

@end
