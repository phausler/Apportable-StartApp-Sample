//
//  DAStartAppInterstitial.h
//  [Duksel-Apportable extensions]
//
//  Created by Andrei Bakulin on 30/12/13.
//  Copyright (c) 2013 Duksel Corp. All rights reserved.
//

#import <BridgeKit/JavaObject.h>
#import <BridgeKit/AndroidActivity.h>

@protocol DAStartAppInterstitialDelegate
@optional
- (void)DAStartAppInterstitialReceiveAd;
- (void)DAStartAppInterstitialFailedToReceiveAd;
- (void)DAStartAppInterstitialDisplayed;
- (void)DAStartAppInterstitialHidden;
@end

@interface DAStartAppInterstitial : JavaObject

@property (nonatomic, assign) NSObject <DAStartAppInterstitialDelegate> *delegate;

- (id)initInActivity:(AndroidActivity*)activity;

// @public

- (void)loadAd;
- (BOOL)isReady;

- (BOOL)showAd;
- (BOOL)showAdAndLoadNextAd;
- (void)close;

// @callback methods

- (void)loadAd_onReceiveAd;
- (void)loadAd_onFailedToReceiveAd;
- (void)showAd_adDisplayed;
- (void)showAd_adHidden;

@end
