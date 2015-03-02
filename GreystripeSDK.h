/*
 *  GreystripeSDK.h
 *
 *  Copyright 2009 Greystripe, Inc. All rights reserved.
 *
 */

#ifndef _GREYSTRIPE_H
#define _GREYSTRIPE_H

/**
 * To install the Greystripe SDK into your XCode project, from the Project menu
 * choose "Add to Project", and add the libGreystripeSDK.a file and all
 * associated header files to your project.  The SDK requires no additional
 * resource files, but it does require a number of Apple's frameworks to be
 * included as well.  Right-click (or control-click) on your project in the
 * Groups & Files view, and click "Add", and click "Existing Frameworks...".
 * From the "/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/
 * [YOUR_BASE_SDK]/System/Library/Frameworks" folder, add CoreGraphics.framework,
 * MediaPlayer.framework, OpenAL.framework, OpenGLES.framework, 
 * QuartzCore.framework, and SystemConfiguration.framework if they're not
 * already included in your project.  Then, from the "/Developer/Platforms/
 * iPhoneOS.platform/Developer/SDKs/[YOUR_BASE_SDK]/usr/lib" folder, add
 * libz.dylib and libsqlite3.dylib if they're not already included in your
 * project.
 */

typedef long long GSValue;

#define GS_VIEW_ALL_ADS	-1

#ifdef __cplusplus
extern "C"
{
#endif

	/**
	 * Invoke this once during application startup to initialize the Greystripe ad
	 * client.  This function must be called before any other Greystripe functions
	 * are called.
	 *
	 * @param appID				the ID of your application within the AdWRAP system
	 */
	void GSInit(GSValue a_appID);
	
	/**
	 * Sets the delegate class to handle Greystripe events, such as greystripeAdDidOpen,
	 * which many game applications will want to handle in order to pause game activity
	 * when an advertisement is opened.  For more information see GreystripeDelegate.h.
	 *
	 * @param a_delegate	The delegate class instance, which must implement the
	 *						GreystripeDelegate protocol.
	 */
	void GSSetDelegate(void * a_delegate);
	
	/**
	 * Displays the next ad.
	 *
	 * @return	TRUE, if there is an attempt to display an ad.  If there is no 
	 *			ad currently ready the ad system will return false.  The 
	 *			application can handle this by tracking the number	of failed
	 *			attempts and nagging the user to connect to the network after
	 *			trying too many times.
	 */
	BOOL GSDisplayAd();
	
	/**
	 * Sets a forced rotation for ad display. Landscape-oriented apps will want
	 * to make use of this.
	 *
	 * @param a_rotation	Angle of the rotation.
	 */
	void GSSetRelativeRotation(float a_rotation);
	
	/**
	 * Invoke this at application shutdown to shutdown the Greystripe ad client.
	 * This will release all major resources associated with the GreystripeSDK.  
	 * The memory freed by calling this function may not be equal to the memory
	 * allocated since instantiating the SDK due to internal caching of data
	 * in some native classes such as the web view.  
	 *
	 * Note that invoking this function at any point other than application 
	 * shutdown will lead to undefined behavior of the Greystripe SDK.
	 */
	void GSDealloc();
		
#ifdef __cplusplus
}
#endif

#endif
