package com.duksel.apportable;

import android.app.Activity;

import com.startapp.android.publish.StartAppAd;

// @test:show-banner
import android.os.Handler;
import android.view.Gravity;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.PopupWindow;
import com.startapp.android.publish.banner.Banner;

public class DAStartApp
{
    private static final String TAG = "DAStartApp";
    
    private Activity appActivity;
    
    public DAStartApp( Activity activity )
    {
        appActivity = activity;
    }
    
    public void setDeveloperIdAndAppId( String developerId, String appId )
    {
        StartAppAd.init( appActivity, developerId, appId );
    }
    
    // @test:show-banner
    public void test_showBanner()
    {
        // @notice: this code will show banner, but banner not respond on user click on it.
        // So failed to use banners :(
        //
        // If you know how to make it work - that's greate! Please, contact with me [ab@duksel.com] ;)

        Handler handler = new Handler( appActivity.getBaseContext().getMainLooper() );
        
        handler.post( new Runnable() {
            @Override
            public void run()
            {
                PopupWindow  popupWindow = new PopupWindow(appActivity);
                LinearLayout popupLayout = new LinearLayout(appActivity);
                LinearLayout mainLayout  = new LinearLayout(appActivity);

                Banner banner = new Banner( appActivity );

                popupLayout.addView( banner, new Banner.LayoutParams(640,100) );
                popupLayout.setOrientation(LinearLayout.VERTICAL);
                
                popupWindow.setContentView( popupLayout );
                popupWindow.showAtLocation( mainLayout, Gravity.BOTTOM, 0, 0 );
                popupWindow.update( 0, 0, 660, 120 );
            }
        } );
    }
}
