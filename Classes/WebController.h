//
//  WebController.h
//  SciBay
//
//  Created by Michael Colson on 4/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebController : UIViewController {

	IBOutlet UIWebView *browser;
	
	//The following are for implementing the back button:
	IBOutlet UINavigationBar *navBar;
	BOOL isModal; //Was the view launched as a modal dialog?
}

-(void)loadURL:(NSString *)url;
-(void)setIsModal:(BOOL)modality;
-(void)setTitle:(NSString *)title;

@end
