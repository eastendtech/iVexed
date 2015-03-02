//
//  FonicBuddy.m
//  iVexed
//
//  Created by Michael Colson on 5/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FonicBuddy.h"
@implementation FonicBuddy
@synthesize isOnTimer;

- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"Yo, my view do so totally load.");
	//rolloView   = [ARRollerView requestRollerViewWithDelegate:self];
	
	adfonicView = [ [UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        [adfonicView loadHTMLString:@"<script src='http://adfonic.net/js/c0c767d3-b027-4510-b3d6-4237a23d782f'/>" baseURL:[NSURL URLWithString:@"http://adfonic.net/js"]];
    
	[self.view addSubview:adfonicView];
	[self.view bringSubviewToFront:adfonicView];
	[self retain];
	
	[self startTimer];
	

}

-(void)timerTick:(NSTimer *)timer;
{
    NSLog(@"tick");
	[adfonicView loadHTMLString:@"<script src='http://adfonic.net/js/c0c767d3-b027-4510-b3d6-4237a23d782f'/>" baseURL:[NSURL URLWithString:@"http://adfonic.net/js"]]; 
  
}

-(void)startTimer
{
	if (!timer)
	{
	    NSLog(@"Starting a timer.");
		timer = [NSTimer  timerWithTimeInterval:30.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
		[timer retain];
		[ [NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode ];
	
   }
}

-(void)stopTimer
{
	if (timer)
	{
		[timer invalidate];
		[timer release];
		timer = nil;
	}
}

//----------------------AdFonic web view delegate-------------------------------//
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType 
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        //[[UIApplication sharedApplication] openURL:request.URL];
		
		AdBrowser *browser = [ [AdBrowser alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		[browser setDelegate:self];
		
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:1];
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view.window cache:YES];
		
		[self.view.window addSubview:browser];
		[browser visitURL:[[request URL] absoluteString]];
		
		[UIView commitAnimations];
		
		
		
		
        return false;
    }
    return true;
}


//---------------------End AdFonic web view delegate---------------------------//

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
