//
//  ReachabilityObserver.m
//  Skippers
//
//  Created by Robert Branchat i Freixa on 10/01/12.
//  Copyright 2012 inagua. All rights reserved.
//

#import "ReachabilityObserver.h"
#import "NSString+Utils.h"

@implementation ReachabilityObserver

- (BOOL)isStatusAvailable:(NetworkStatus) status {
    BOOL isAvailable = YES;
	if ((status != ReachableViaWiFi) && (status != ReachableViaWWAN)) {
		isAvailable = NO; // then: NotReachable
	}
    return isAvailable;
}

- (BOOL)isInternetCurrentlyAvailable {
    NetworkStatus internetStatus = [internetReachability currentReachabilityStatus];
	return [self isStatusAvailable:internetStatus];
}

- (BOOL)isObservedHostCurrentlyAvailable {
    if ([observedHostName isBlank]) {
        return NO;
    }
    NetworkStatus hostStatus = [hostReachability currentReachabilityStatus];
    return [self isStatusAvailable:hostStatus];
}

- (void)addActivityIndicatorTo:(UIAlertView*)existentAlert {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(existentAlert.bounds.size.width / 2, existentAlert.bounds.size.height - 45);
    [indicator startAnimating];
    [existentAlert addSubview:indicator];
    [indicator release];    
}

// The alert will use the localized strings defined in the project under:
// NSLocalizedString(@"reachability.popup.title", nil)
// NSLocalizedString(@"reachability.popup.content", nil)
// If they are not defined, a default message will be shown.
// See - (void)initializeAlertStrings below.
- (void) showAlert {
    if (isAlertShowing) {
        return;
    }
    alert = [[[UIAlertView alloc] initWithTitle:alertTitle
                                        message:alertContent
                                       delegate:self 
                              cancelButtonTitle:nil
                              otherButtonTitles:nil] autorelease];
    [alert show];
    [self addActivityIndicatorTo:alert]; // instead of any button
    isAlertShowing = YES;
}

- (void)hideAlert {
    if (isAlertShowing) {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        isAlertShowing = NO;
    }
}

- (void)fireEventsForReachableFor:(Reachability*)reachability {
    [self hideAlert];
    if (reachability == hostReachability) {
        NSLog(@"%@ Observed host (%@) is available.", REACHABILITY_MSG_PREFIX, observedHostName);
        if ([delegate respondsToSelector:@selector(didHostBecomeAvailable:)]) {
            [delegate didHostBecomeAvailable:observedHostName];
        }
    }
    if (reachability == internetReachability) {
        NSLog(@"%@ Internet is available.", REACHABILITY_MSG_PREFIX);
        if ([delegate respondsToSelector:@selector(didInternetBecomeAvailable)]) {
            [delegate didInternetBecomeAvailable];
        }
    }
}

- (void)fireEventForNotReachableFor:(Reachability*)reachability {
    [self showAlert];
    if (reachability == hostReachability) {
        NSLog(@"%@ Observed host (%@) is unavailable.", REACHABILITY_MSG_PREFIX, observedHostName);
        if ([delegate respondsToSelector:@selector(didHostBecomeUnavailable:)]) {
            [delegate didHostBecomeUnavailable:observedHostName];
        }
    }
    if (reachability == internetReachability) {
        NSLog(@"%@ Internet is unavailable.", REACHABILITY_MSG_PREFIX);
        if ([delegate respondsToSelector:@selector(didInternetBecomeUnavailable)]) {
            [delegate didInternetBecomeUnavailable];
        }
    }    
}

- (void)fireEventsFor:(Reachability*)currentReachability {
    NetworkStatus netStatus = [currentReachability currentReachabilityStatus];
    if ([self isStatusAvailable:netStatus]) {
        [self fireEventsForReachableFor:currentReachability];
    } else {
        [self fireEventForNotReachableFor:currentReachability];
    }
}

//Called by Reachability whenever Network status changes.
- (void) reachabilityChanged: (NSNotification* )note {
	Reachability* currentReachability = [note object];
	NSParameterAssert([currentReachability isKindOfClass: [Reachability class]]);
    [self fireEventsFor:currentReachability];
}

- (void)fireFirstEventFor:(Reachability*)reachability {
    [self fireEventsFor:reachability];
}

- (void) startObservingInternetAvailabilityWithDelegate:(id)d {
    delegate = d;
    internetReachability = [[Reachability reachabilityForInternetConnection] retain];
    [internetReachability startNotifier];
    [self fireFirstEventFor:internetReachability];
}

- (void) startObservingInternetAvailability{
    [self startObservingInternetAvailabilityWithDelegate:nil];
}

- (void) startObservingHostReachability:(NSString*)hostName withDelegate:(id)d {
    observedHostName = hostName;
    hostReachability = [[Reachability reachabilityWithHostName:hostName ] retain];
    [hostReachability startNotifier];
    [self fireFirstEventFor:hostReachability];
    [self startObservingInternetAvailabilityWithDelegate:d];
}

- (void) startObservingHostReachability:(NSString*)hostName {
    [self startObservingHostReachability:hostName withDelegate:nil];
}

- (void) stopObserving{
    [hostReachability stopNotifier];
    [internetReachability stopNotifier];
}

- (void) initializeNotificationObserver {
    // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method "reachabilityChanged" will be called. 
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
}

- (void)initializeAlertStrings {
    alertTitle = NSLocalizedString(@"reachability.popup.title", nil);
    if ([alertTitle isBlank]) {
        alertTitle = @"No Internet Available";
    }
    alertContent = NSLocalizedString(@"reachability.popup.content", nil);
    if ([alertTitle isBlank]) {
        alertTitle = @"This app needs internet to work. Waiting for connection...";
    }
}

- (id)init {
    self = [super init];
    if (self) {
        isAlertShowing = NO;
        [self initializeAlertStrings];
        [self initializeNotificationObserver];
    }
    return self;
}

- (void)dealloc {
    [self stopObserving];
    [super dealloc];
}

@end
