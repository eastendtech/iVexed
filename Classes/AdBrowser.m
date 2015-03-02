//
//  AdBrowser.m
//  AdProject
//
//  Created by Michael Colson on 8/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AdBrowser.h"


@implementation AdBrowser


//For setting the delegate and reporting the didDismissAdPage message
-(void)setDelegate:(id<AdBiosDelegateProtocol>)del
{
	adDelegate = del;
}

-(void)visitURL:(NSString *)url
{
	if (adView)
	{
		[adView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
	}
}

-(void)hitDone
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.superview cache:YES];
	
	
	[self removeFromSuperview];
	[UIView commitAnimations];
	
	//Report dismissal of the ad page:
	if (adDelegate && [adDelegate respondsToSelector:@selector(didDismissAdPage)])
		[adDelegate didDismissAdPage];
	
	[self release];
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		adView = [ [UIWebView alloc] initWithFrame:CGRectMake(0,20,320,436)];
		closeBar = [ [UIToolbar alloc] initWithFrame:CGRectMake(0, 436, 320,44)];
		
		doneItem = [ [UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(hitDone) ];
		[closeBar  setItems:[NSArray arrayWithObject: doneItem] animated:NO];
		
		[self addSubview:adView];
		[self addSubview:closeBar];
		
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [super dealloc];
}


@end
