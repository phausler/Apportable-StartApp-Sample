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

@implementation AppDelegate {
    BOOL showing_ad;
}

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

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    showing_ad = NO;
}

#if ALERT_DIALOG_EXIT
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        exit(0);
    }
}
#endif

- (void)buttonUpWithEvent:(UIEvent *)event
{
    switch (event.buttonCode)
    {
        case UIEventButtonCodeBack:
            // @DAStartApp
            // tracking the state and gating ads is preferable
            // so that when you suspend/resume, the app can
            // remain active and gate accordingly for registration
            // however using the back button to show advertizements
            // is not suggested since the expected behavior 
            // perscribed by Google (used in their process to feature
            // apps for Google Play) is to exit (possibly with an alert
            // that confirms the behavior)
#if ALERT_DIALOG_EXIT
            UIAlertView *exitDialog = [[UIAlertView alloc] initWithTitle:@"Exit" 
                                                                 message:@"Are you sure you want to exit?" 
                                                                delegate:self 
                                                       cancelButtonTitle:@"NO"
                                                       otherButtonTitles:@"YES", nil];
            [exitDialog show];
            break;
#else
            if (!showing_ad) {
                showing_ad = YES;
                [[DAStartApp interstitial] showAd];
            }
            break;
#endif

        case UIEventButtonCodeMenu:
            // @DAStartApp
            if (!showing_ad) {
                showing_ad = YES;
                [[DAStartApp interstitial] showAdAndLoadNextAd];
            }
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
