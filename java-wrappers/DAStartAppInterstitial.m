//
//  DAStartAppInterstitial.m
//  [Duksel-Apportable extensions]
//
//  Created by Andrei Bakulin on 30/12/13.
//  Copyright (c) 2013 Duksel Corp. All rights reserved.
//

#import "DAStartAppInterstitial.h"

@implementation DAStartAppInterstitial

@synthesize delegate;

+ (void)initializeJava
{
    [super initializeJava];
    
    [DAStartAppInterstitial registerConstructorWithSelector:@selector(initInActivity:)
                                                  arguments:@"android/app/Activity", nil];
    
    [DAStartAppInterstitial registerInstanceMethod:@"loadAd"
                                          selector:@selector(loadAd)];
    
    [DAStartAppInterstitial registerInstanceMethod:@"isReady"
                                          selector:@selector(isReady)
                                       returnValue:[JavaClass boolPrimitive]];
    
    [DAStartAppInterstitial registerInstanceMethod:@"showAd"
                                          selector:@selector(showAd)
                                       returnValue:[JavaClass boolPrimitive]];
    
    [DAStartAppInterstitial registerInstanceMethod:@"showAdAndLoadNextAd"
                                          selector:@selector(showAdAndLoadNextAd)
                                       returnValue:[JavaClass boolPrimitive]];

    [DAStartAppInterstitial registerInstanceMethod:@"close"
                                          selector:@selector(close)];
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // Delegate methods

    [DAStartAppInterstitial registerCallback:@"loadAd_onReceiveAd"
                                    selector:@selector(loadAd_onReceiveAd)
                                 returnValue:nil];
    
    [DAStartAppInterstitial registerCallback:@"loadAd_onFailedToReceiveAd"
                                    selector:@selector(loadAd_onFailedToReceiveAd)
                                 returnValue:nil];
    
    [DAStartAppInterstitial registerCallback:@"showAd_adDisplayed"
                                    selector:@selector(showAd_adDisplayed)
                                 returnValue:nil];
    
    [DAStartAppInterstitial registerCallback:@"showAd_adHidden"
                                    selector:@selector(showAd_adHidden)
                                 returnValue:nil];
}

+ (NSString *)className
{
    return @"com.duksel.apportable.DAStartAppInterstitial";
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// Delegate methods

- (void)loadAd_onReceiveAd
{
    if( self.delegate && [self.delegate respondsToSelector:@selector(DAStartAppInterstitialReceiveAd)] == YES )
        [self.delegate DAStartAppInterstitialReceiveAd];
}

- (void)loadAd_onFailedToReceiveAd
{
    if( self.delegate && [self.delegate respondsToSelector:@selector(DAStartAppInterstitialFailedToReceiveAd)] == YES )
        [self.delegate DAStartAppInterstitialFailedToReceiveAd];
}

- (void)showAd_adDisplayed
{
    if( self.delegate && [self.delegate respondsToSelector:@selector(DAStartAppInterstitialDisplayed)] == YES )
        [self.delegate DAStartAppInterstitialDisplayed];
}

- (void)showAd_adHidden
{
    if( self.delegate && [self.delegate respondsToSelector:@selector(DAStartAppInterstitialHidden)] == YES )
        [self.delegate DAStartAppInterstitialHidden];
}

@end
