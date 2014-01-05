//
//  AppDelegate.m
//  StartApp-Sample
//
//  Created by Andrei Bakulin on 02/01/14.
//  Copyright (c) 2014 Duksel Corp. All rights reserved.
//

#import "AppDelegate.h"

#ifdef ANDROID
#import "DAStartApp.h"
#endif

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef ANDROID
    // @DAStartApp
    [[DAStartApp shared] setDeveloperId:@"110472750" appId:@"201436411"];
    [[DAStartApp interstitial] loadAd];
    [[DAStartApp interstitial] setDelegate:self];
    
    [[DAStartApp shared] test_showBanner];
#endif
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

#ifdef ANDROID
- (void)buttonUpWithEvent:(UIEvent *)event
{
    switch (event.buttonCode)
    {
        case UIEventButtonCodeBack:
            // @DAStartApp
            [[DAStartApp interstitial] showAd];
            exit(0);
            break;

        case UIEventButtonCodeMenu:
            // @DAStartApp
            [[DAStartApp interstitial] showAdAndLoadNextAd];
            break;

        default:
            break;
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
#endif

//----------------------------------------------------------------------------------------------------------------------
#pragma mark - DAStartAppInterstitialDelegate methods

#ifdef ANDROID
- (void)DAStartAppInterstitialReceiveAd
{
    NSLog(@"DAStartAppInterstitialReceiveAd");
}

- (void)DAStartAppInterstitialFailedToReceiveAd
{
    NSLog(@"DAStartAppInterstitialFailedToReceiveAd");
}

- (void)DAStartAppInterstitialDisplayed
{
    NSLog(@"DAStartAppInterstitialDisplayed");
}

- (void)DAStartAppInterstitialHidden
{
    NSLog(@"DAStartAppInterstitialHidden");
}
#endif

@end
