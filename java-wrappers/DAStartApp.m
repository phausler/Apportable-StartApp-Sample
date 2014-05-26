//
//  DAStartApp.m
//  [Duksel-Apportable extensions]
//
//  Created by Andrei Bakulin on 30/12/13.
//  Copyright (c) 2013 Duksel Corp. All rights reserved.
//

#import "DAStartApp.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-implementation"
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation DAStartApp

+ (void)initializeJava
{
    [super initializeJava];
    
    [DAStartApp registerConstructorWithSelector:@selector(initInActivity:)
                                      arguments:[AndroidActivity className], nil];
    
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
#pragma clang diagnostic pop
