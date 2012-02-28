//
//  ReachabilityObserver.h
//  Skippers
//
//  Created by Robert Branchat i Freixa on 10/01/12.
//  Copyright 2012 inagua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

#define REACHABILITY_MSG_PREFIX @"[Reachability Framework Message]"

@protocol ReachabilityObserverDelegate;
@interface ReachabilityObserver : NSObject {
@private
    NSString *observedHostName;
    Reachability *hostReachability;
    Reachability *internetReachability;
    BOOL isAlertShowing;
    UIAlertView *alert;
    NSString* alertTitle;
    NSString* alertContent;
    id <ReachabilityObserverDelegate> delegate;
}

- (void)startObservingInternetAvailability;
- (void)startObservingInternetAvailabilityWithDelegate:(id /*<ReachabilityObserverDelegate>*/)d;
- (void)startObservingHostReachability:(NSString*)hostName;
- (void)startObservingHostReachability:(NSString*)hostName withDelegate:(id /*<ReachabilityObserverDelegate>*/)d;
- (void)stopObserving;

- (BOOL)isInternetCurrentlyAvailable;
- (BOOL)isObservedHostCurrentlyAvailable;

@end

@protocol ReachabilityObserverDelegate <NSObject>
@optional

- (void)didInternetBecomeAvailable;
- (void)didInternetBecomeUnavailable;

- (void)didHostBecomeAvailable:(NSString*)hostName;
- (void)didHostBecomeUnavailable:(NSString*)hostName;

@end