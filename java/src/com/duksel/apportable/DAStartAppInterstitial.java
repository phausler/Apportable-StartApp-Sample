package com.duksel.apportable;

import android.app.Activity;
import android.widget.Toast;

import com.startapp.android.publish.Ad;
import com.startapp.android.publish.AdDisplayListener;
import com.startapp.android.publish.AdEventListener;
import com.startapp.android.publish.StartAppAd;
import com.startapp.android.publish.StartAppAd.AdMode;

import java.util.Random;

public class DAStartAppInterstitial
{
    private static final String TAG = "DAStartAppInterstitial";
    
    private Activity   appActivity;
    private StartAppAd startAppAd;
    
    public DAStartAppInterstitial( Activity activity )
    {
        appActivity = activity;

		startAppAd = new StartAppAd( appActivity );
    }
    
    public void loadAd()
    {
        logMessage("exec: loadAd");

        appActivity.runOnUiThread(new Runnable() {
            public void run() {
                
                AdMode adMode;
                
                // @notice: Why need this?
                //
                // Because in AdMode.OFFERWALL on try to show 3D-List of apps -> app will crash
                // with error that "com.startapp.android.publish.list3d.List3DActivity" not found,
                // but it exists in manifest file.
                // So this value is ignored!
                //
                // If you know how to make it work - that's greate! Please, contact with me [ab@duksel.com] ;)

                switch( new Random().nextInt(2) )
                {
                    default:
                    case 0: adMode = AdMode.FULLPAGE; break;
                    case 1: adMode = AdMode.OVERLAY;  break;
                }
                
                startAppAd.loadAd( adMode, new AdEventListener() {
                    @Override
                    public void onReceiveAd(Ad ad) {
                        loadAd_onReceiveAd();
                    }
                    
                    @Override
                    public void onFailedToReceiveAd(Ad ad) {
                        loadAd_onFailedToReceiveAd();
                    }
                });
            }
        });
    }
    
    public boolean isReady()
    {
        logMessage("exec: isReady");

        return startAppAd.isReady();
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    public boolean showAd()
    {
        logMessage("exec: showAd");

        if( isReady() == false )
            return false;

        appActivity.runOnUiThread(new Runnable() {
            public void run() {
                startAppAd.showAd( new AdDisplayListener() {
                    @Override
                    public void adDisplayed(Ad ad) {
                        showAd_adDisplayed();
                    }

                    @Override
                    public void adHidden(Ad ad) {
                        showAd_adHidden();
                    }
                });
            }
        });
        
        return true;
    }
    
    public boolean showAdAndLoadNextAd()
    {
        logMessage("exec: showAdAndLoadNextAd");

        if( showAd() == false )
            return false;

        loadAd();
        
        return true;
    }

    public void close()
    {
        logMessage("exec: close");

        appActivity.runOnUiThread(new Runnable() {
            public void run() {
                startAppAd.close();
            }
        });
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // Delegate methods
    
    private native void loadAd_onReceiveAd();
    private native void loadAd_onFailedToReceiveAd();
    private native void showAd_adDisplayed();
    private native void showAd_adHidden();

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    public void logMessage( String message )
    {
        // @notice: this is just for debug
        Toast.makeText( appActivity, message, Toast.LENGTH_SHORT ).show();
    }
}
