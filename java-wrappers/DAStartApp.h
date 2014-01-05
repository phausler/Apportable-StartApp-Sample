//
//  DAStartApp.h
//  [Duksel-Apportable extensions]
//
//  Created by Andrei Bakulin on 30/12/13.
//  Copyright (c) 2013 Duksel Corp. All rights reserved.
//

#import <BridgeKit/JavaObject.h>
#import <BridgeKit/AndroidActivity.h>

#import "DAStartAppInterstitial.h"

@interface DAStartApp : JavaObject

+ (DAStartApp*)shared;
+ (DAStartAppInterstitial*)interstitial;

- (void)setDeveloperId:(NSString*)developerId appId:(NSString*)appId;

// @test:show-banner
- (void)test_showBanner;

@end
