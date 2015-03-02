//
//  Created by Michael Colson on 5/11/09.
//  Copyright 2009 Thetalogik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdBrowser.h"
#import "AdBiosDelegate.h"

@interface FonicBuddy : UIViewController 
{
	
	BOOL isOnTimer;
	NSTimer *timer;
	UIWebView *adfonicView;
}

@property BOOL isOnTimer;
-(void)timerTick:(NSTimer *)timer;
-(void)startTimer;
-(void)stopTimer;
@end
