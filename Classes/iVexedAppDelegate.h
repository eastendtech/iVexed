//
//  iVexedAppDelegate.h
//  iVexed
//
//  Created by Michael Colson on 7/15/08.
//  Copyright Thetalogik 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PuzzleController;

@interface iVexedAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet PuzzleController *viewController;
	
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) PuzzleController *viewController;

@end

