//
//  AppDelegate.h
//  StartApp-Sample
//
//  Created by Andrei Bakulin on 02/01/14.
//  Copyright (c) 2014 Duksel Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef ANDROID
#import "DAStartApp.h"
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate
#ifdef ANDROID
    , DAStartAppInterstitialDelegate
#endif
    >

@property (strong, nonatomic) UIWindow *window;

@end
