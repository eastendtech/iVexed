//
//  WebController.m
//  SciBay
//
//  Created by Michael Colson on 4/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WebController.h"


@implementation WebController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	UINavigationItem *back = [ [UINavigationItem alloc] initWithTitle:@"Cool Stuff!"];
	back.backBarButtonItem.title = @"Back";
	
	[navBar setDelegate:self];
	[navBar pushNavigationItem:back animated:NO];
	[browser setDelegate:self];
	isModal = NO;
	
	[browser loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cool" ofType:@"html"]isDirectory:NO]]];
}


-(void)setIsModal:(BOOL)modality
{
	isModal = modality;
}

-(void)setTitle:(NSString *)title
{
	navBar.topItem.title = title;
}

//----------------Navigation Delegate Functions for Back button support----------//
-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
	
	if (!isModal)
	{
	  NSLog(@"Did pop item");
	 /*
		CATransition *applicationLoadViewIn = [CATransition animation];
	  [applicationLoadViewIn setDuration:0.5];
	  [applicationLoadViewIn setType:kCATransitionPush];
	  [applicationLoadViewIn setSubtype:kCATransitionFromRight];
	  [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
	  [[self.view.superview layer] addAnimation:applicationLoadViewIn forKey:kCATransitionPush];
   	  [self.view removeFromSuperview];
	  */
	  }
	else
		[self.parentViewController dismissModalViewControllerAnimated:YES];
	
	
	return NO;
}

//------------------------------End Nav Delegate Functions----------------------//
//Page loading function:
-(void)loadURL:(NSString *)url
{
	[browser loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

//---------------------------------Web Delegate Functions--------------------//
-(void)webViewDidStartLoad:(UIWebView *)webView
{
	[ [UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; 
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	[ [UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; 
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  	[ [UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; 		
}


//----------------------------------End Web Delegate Functions--------------//


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
