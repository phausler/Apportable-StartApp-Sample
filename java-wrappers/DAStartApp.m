//
//  DAStartApp.m
//  [Duksel-Apportable extensions]
//
//  Created by Andrei Bakulin on 30/12/13.
//  Copyright (c) 2013 Duksel Corp. All rights reserved.
//

#import "DAStartApp.h"

@implementation DAStartApp

+ (void)initializeJava
{
    [super initializeJava];
    
    [DAStartApp registerConstructorWithSelector:@selector(initInActivity:)
                                      arguments:@"android/app/Activity", nil];
    
    [DAStartApp registerInstanceMethod:@"setDeveloperIdAndAppId"
                              selector:@selector(setDeveloperId:appId:)
                             arguments:[NSString className], [NSString className], nil];
    
    // @test:show-banner
    [DAStartApp registerInstanceMethod:@"test_showBanner"
                              selector:@selector(test_showBanner)];
}

+ (NSString *)className
{
    return @"com.duksel.apportable.DAStartApp";
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

+ (DAStartApp*)shared
{
    static DAStartApp *instance = nil;
    
    if( instance == nil )
        instance = [[self alloc] initInActivity:[AndroidActivity currentActivity]];
    
    return instance;
}

+ (DAStartAppInterstitial*)interstitial
{
    static DAStartAppInterstitial *instance = nil;
    
    if( instance == nil )
        instance = [[DAStartAppInterstitial alloc] initInActivity:[AndroidActivity currentActivity]];

    return instance;
}

@end
