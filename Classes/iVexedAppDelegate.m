//
//  iVexedAppDelegate.m
//  iVexed
//
//  Created by Michael Colson on 7/15/08.
//  Copyright Thetalogik 2008. All rights reserved.
//

#import "iVexedAppDelegate.h"
#import "PuzzleController.h"

@implementation iVexedAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	//Initialize Greystripe ads: (TODO: replace with production ad code lata :])
	GSInit(486863);
    
	/*
	NSLog(@"didFinishLaunching:");
	printf("didFinishLaunching:");
	UIAlertView *version = [ [UIAlertView alloc] initWithTitle:@"Fin" message:@"Finished Launching!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
	[version show];
	[version release];
	*/
	// Override point for customization after app launch	
    [window addSubview:viewController.view];
	[window makeKeyAndVisible];
	/*
	TapjoyConnectInterface *ti = [[TapjoyConnectInterface alloc] init]; 
    TapjoyConnect* tc = [TapjoyConnect requestTapjoyConnectWithDelegate:ti]; 

	[tc getAdOrder];  
    [tc preloadAds:1];
	*/
	NSString *applicationCode = @"f0de59678e4bb1ebd6686235d21ce7f2";
    //NSString *mobclixCode = @"ca9c5b5f-d5e7-4c45-be0c-abf83d7a36dc";
	
	
	[Beacon initAndStartBeaconWithApplicationCode:applicationCode
								  useCoreLocation:NO useOnlyWiFi:NO];
	
	[viewController newGame];
	}


//NEW: This is for handling shared games that are shared via a URL
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	/*
	UIAlertView *version = [ [UIAlertView alloc] initWithTitle:@"Game" message:[url absoluteString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
	[version show];
	[version release];
	 */
	NSArray * parts = [ [url absoluteString] componentsSeparatedByString:@"://"];
    NSString *numericCode = [parts objectAtIndex:1];
	
	[Beacon endBeacon];
	[viewController newGameFromURL:numericCode];
	return YES;
}



- (void) applicationWillTerminate:(UIApplication *)application
{
	
	//TODO: Add state saving system if a game is in progress.
	
	//[Mobclix endApplication];
	
	[Beacon endBeacon];

	GSDealloc();
	 
}	

- (void)dealloc {
    [viewController release];
	[window release];
	[super dealloc];
}


@end
