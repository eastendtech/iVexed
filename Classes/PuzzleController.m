//
//  PuzzleController.m
//  iVexed
//
//  Created by Michael Colson on 7/15/08.
//  Copyright Thetalogik 2008. All rights reserved.
//
//  BUGFIX -- Apparently there was an error in the way I do my memory management
// and releasing the puzzle pieces from the board array is a no-no. So to fix the bug,
// I retain them beforehand or not even release them at all. I opted to do retain on
// the game pieces to fix the problem

//BUGFIX -- Fixed an error where because of not checking the finished flag in 
//animationDidStop:finished caused the timer to start prematurely

//BUGFIX -- If highscore btn is hit twice, gameTimer will invalidate and be relased twice
//Made it so it checks if shouldTime is YES before releasing it.

#import "PuzzleController.h"


@implementation PuzzleController
/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */


/*
   Perform game initialization after the view loads:
   Init puzzle will create game pieces:
 */
- (void)viewDidLoad {
	//NSLog(@"View did load.");
	//printf("View did load.");
	[super viewDidLoad];
	//[self showScores];
   	xdocks[3] = 32;
	xdocks[2] = 96;
	xdocks[1] = 157;
	xdocks[0] = 222;
	xdocks[8] = 0;
	xdocks[7] = 64;
	xdocks[6] = 126;
	xdocks[5] = 190;
	xdocks[4] = 255;
	
	ydocks[0] = 52;
	ydocks[1] = 52;
	ydocks[2] = 52;
	ydocks[3] = 52;
	ydocks[4] = 349;
	ydocks[5] = 349;
	ydocks[6] = 349;
	ydocks[7] = 349;
	ydocks[8] = 349;
	
	xdocks[9] =  65;
	xdocks[10] = 126;
	xdocks[11] = 190;
	xdocks[12] = 65;
	xdocks[13] = 126;
	xdocks[14] = 190;
	xdocks[15] = 65;
	xdocks[16] = 126;
	xdocks[17] = 190;
	
	ydocks[9] =  130;
	ydocks[10] = 130;
	ydocks[11] = 130;
	ydocks[12] = 192;
	ydocks[13] = 192;
	ydocks[14] = 192;
	ydocks[15] = 256;
	ydocks[16] = 256;
	ydocks[17] = 256;
	
	//Fix text field
	timeField.adjustsFontSizeToFitWidth = YES;
	
	/*Create the High Score View*/
	scoreView = [ [ScoreController alloc] initWithNibName:@"ScoreView" bundle:nil ];
	[scoreView setParentViewController:self];
	
	//[self initPuzzle];
	GSSetDelegate(self);
	lastAdImpression = [[NSDate date] retain];
	first = NO;
}
 
/*Init Puzzle*/
/*This creates a 9x9 tetravex puzzle and gets the pieces ready
   for presentation. It is called at app start and when the New Game
   button is pressed.
 */
-(void)initPuzzle
{
	
	hasWon = NO;
	
	srand(time(0));
	for (int i = 0; i < 9; i++)
	{
		//Create the puzzle places off screen and position them for slide in at the top
		//and bottom docks:
		board[i] = [ [GamePiece alloc] initWithFrame:CGRectMake(-70, (i < 4) ? 52 : 349 ,65,65) ];
		[board[i] setSequence:i];
		
		[board[i] retain];
		[self.view addSubview:board[i] ];
		
	}
	//[bgView setImage:[UIImage defaultDesktopImage]]; REMOVED
	
	/*Cannot drag pieces until the intro is over:*/
	canDrag = NO;
	
	/*Clear the timer & totalTime:*/
	[timeField setText:@"0:00"];
	totalTime = 0;
	//Set up the timer:
	gameTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
	[gameTimer retain];
	
	stateString = [[NSMutableString alloc] initWithString:@"ivg://"];
	
	/*Generate the puzzle numbers: */
	int arbitrary[24];
	for(int i = 0; i < 24; i++)
	{
		arbitrary[i] = rand() % 10;
		//[stateString appendFormat:@"%i",arbitrary[i] ];
	}
	//[stateString appendFormat
	[board[0] setLeft:arbitrary[0] ];
	[stateString appendFormat:@"%i",arbitrary[0] ];
	[board[0] setTop:arbitrary[1] ];
	[stateString appendFormat:@"%i",arbitrary[1] ];
	[board[0] setRight:arbitrary[2] ];
	[stateString appendFormat:@"%i",arbitrary[2] ];
	[board[0] setBottom:arbitrary[8] ];
	[stateString appendFormat:@"%i",arbitrary[8] ];
	
	[board[1] setLeft:arbitrary[2] ];
	[stateString appendFormat:@"%i",arbitrary[2] ];
	[board[1] setTop:arbitrary[3] ];
	[stateString appendFormat:@"%i",arbitrary[3] ];
	[board[1] setRight:arbitrary[4] ];
	[stateString appendFormat:@"%i",arbitrary[4] ];
	[board[1] setBottom:arbitrary[10] ];
	[stateString appendFormat:@"%i",arbitrary[10] ];
	
	[board[2] setLeft:arbitrary[4] ];
	[stateString appendFormat:@"%i",arbitrary[4] ];
	[board[2] setRight:arbitrary[6] ];
	[stateString appendFormat:@"%i",arbitrary[6] ];
	[board[2] setTop:arbitrary[5] ];
	[stateString appendFormat:@"%i",arbitrary[5] ];
	[board[2] setBottom:arbitrary[12] ];
	[stateString appendFormat:@"%i",arbitrary[12] ];
	
	[board[3] setLeft:arbitrary[7] ];
	[stateString appendFormat:@"%i",arbitrary[7] ];
	[board[3] setRight:arbitrary[9] ];
	[stateString appendFormat:@"%i",arbitrary[9] ];
	[board[3] setTop:arbitrary[8] ];
	[stateString appendFormat:@"%i",arbitrary[8] ];
	[board[3] setBottom:arbitrary[15] ];
	[stateString appendFormat:@"%i",arbitrary[15] ];

	
	[board[4] setLeft: arbitrary[9] ];
	[stateString appendFormat:@"%i",arbitrary[9] ];
    [board[4] setRight:arbitrary[11] ];
	[stateString appendFormat:@"%i",arbitrary[11] ];
	[board[4] setTop:arbitrary[10] ];
	[stateString appendFormat:@"%i",arbitrary[10] ];
	[board[4] setBottom:arbitrary[18]];
	[stateString appendFormat:@"%i",arbitrary[18] ];

	
	[board[5] setLeft:arbitrary[11] ];
	[stateString appendFormat:@"%i",arbitrary[11] ];
	[board[5] setRight:arbitrary[13] ];
	[stateString appendFormat:@"%i",arbitrary[13] ];
    [board[5] setTop:arbitrary[12]];
	[stateString appendFormat:@"%i",arbitrary[12] ];
	[board[5] setBottom:arbitrary[21] ];
	[stateString appendFormat:@"%i",arbitrary[21] ];
	
	[board[6] setLeft:arbitrary[14] ];
	[stateString appendFormat:@"%i",arbitrary[14] ];
	[board[6] setRight:arbitrary[17] ];
	[stateString appendFormat:@"%i",arbitrary[17] ];
	[board[6] setTop:arbitrary[15] ];
	[stateString appendFormat:@"%i",arbitrary[15] ];
	[board[6] setBottom:arbitrary[16] ];
	[stateString appendFormat:@"%i",arbitrary[16] ];
	
	[board[7] setLeft:arbitrary[17] ];
	[stateString appendFormat:@"%i",arbitrary[17] ];
	[board[7] setRight:arbitrary[20] ];
	[stateString appendFormat:@"%i",arbitrary[20] ];
	[board[7] setTop:arbitrary[18] ];
	[stateString appendFormat:@"%i",arbitrary[18] ];
	[board[7] setBottom:arbitrary[19]];
	[stateString appendFormat:@"%i",arbitrary[19] ];

	[board[8] setLeft:arbitrary[20] ];
	[stateString appendFormat:@"%i",arbitrary[20] ];
	[board[8] setRight:arbitrary[23]];
	[stateString appendFormat:@"%i",arbitrary[23] ];
	[board[8] setTop:arbitrary[21] ];
	[stateString appendFormat:@"%i",arbitrary[21] ];
	[board[8] setBottom:arbitrary[22] ];
	[stateString appendFormat:@"%i",arbitrary[22] ];

	
	
	/*permute the puzzle pieces:*/
	/*
	for (int i  = 0; i < 9; i++)
	{
		GamePiece *tmp;
		int swap = rand() % 9;
		int swap2 = rand() % 9;
		tmp = board[swap];
		board[swap] = board[swap2];
		board[swap2] = tmp;
		CGRect frame1 = CGRectMake(-70, (swap < 4) ? 52 : 349 ,65,65);
		CGRect frame2 = CGRectMake(-70, (swap2 < 4) ? 52 : 349 ,65,65);
		[board[swap] setFrame:frame1];
		[board[swap2] setFrame:frame2];
		
	}
	*/
	//Animate the pieces in:
	
	for (int i = 0; i < 9; i++)
	{
	    [UIView beginAnimations:nil	context:(void *)8787];
		[UIView setAnimationDelay:1.0*i];
		[UIView setAnimationDuration:0.2];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		
		//We need to know when the last animation ends:
		if (i == 8)
		  [UIView setAnimationDelegate:self];
		
		CGRect frame = board[i].frame;
		
		frame.origin.x = xdocks[i];
		frame.origin.y = ydocks[i];
		[board[i] setFrame:frame];
		
		[UIView commitAnimations];
	}
	
	
}

/*Touch event handling */

/*
  When touches end, the piece will be tested to see if it is within a
  snapping area. If it is, then the piece's positon will be locked to that area,
  and a validation of that piece to its neighbors will be performed. If it is rejected,
  it won't snap. Puzzle is won when all areas are taken & all numbers match.
*/ 
-  (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"Touches Ended");
	//CGPoint loc = [ [touches anyObject] locationInView:[self view] ];
	//CGRect frame = [targetView frame];
	//frame.origin.x = loc.x - (frame.size.width/2);
	//frame.origin.y = loc.y - (frame.size.height/2);
	if (canDrag)
	{	
	 CGPoint loc = [ [touches anyObject] locationInView: [self view] ];
	 CGRect frame = [activePiece frame];
	
	  for (int i = 0; i < 9; i++)
	  {
		 if (loc.x > xdocks[i] && loc.x <  (xdocks[i] + 65) )
		 {
			 if (loc.y > ydocks[i] && loc.y < (ydocks[i] + 65) )
			 {
				    frame.origin.x = xdocks[i];
					frame.origin.y = ydocks[i];
					[activePiece setFrame:frame];
					//docked[i - 9] = activePiece;
				    break;
			 }
		 }
	 }
	
	 for (int i = 9; i < 18; i++)
	 {
		if (loc.x > xdocks[i] && loc.x <  (xdocks[i] + 65) )
		{
			if (loc.y > ydocks[i] && loc.y < (ydocks[i] + 65) )
			{
				if(docked[i - 9] == nil)
				{
				  frame.origin.x = xdocks[i];
				  frame.origin.y = ydocks[i];
				  [activePiece setFrame:frame];
				  docked[i - 9] = activePiece;
				 }	
				
				break;
			 }
			//[activePiece setFrame:frame];
		 }
	}
	[self validatePuzzle];
   }		
 }

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"Touches Ended");
	if (activePiece)
	{
	   CGPoint loc = [ [touches anyObject] locationInView:[self view] ];
	   CGRect frame = [activePiece frame];
	   frame.origin.x = loc.x - (frame.size.width/2);
	   frame.origin.y = loc.y - (frame.size.height/2);
	if(frame.origin.y > 44 && frame.origin.x > 0 && (frame.origin.x+65) < 320 && (frame.origin.y+65 ) < 460) 	
	   [activePiece setFrame:frame];	
	}
	
	
	//[targetView setFrame:frame];	
}

/*When touches start, hit test all views and if one of the 
   game pieces was hit,make it the active piece & if the touches move, it will move 
   that piece.
   Then check if the active piece is in the dock array, if it is,
   set that dock to nill.
 */
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	//Clear the active piece, and find one, if any:
	activePiece = nil;
	if (canDrag)
	{	
	  CGPoint loc = [ [touches anyObject] locationInView:[self view] ];
	  UIView* hitView = [self.view hitTest:loc withEvent:event];
	
	  for (int i = 0; i < 9; i++)
	  {
	  	  if(board[i] == hitView)
		  {
			 activePiece = board[i];
			/*Make active piece topmost*/
			[self.view bringSubviewToFront:activePiece];

			break;
		}
	 }
	
	  for (int i = 0; i < 9; i++)
	  {
		if (activePiece == docked[i])
		{	
		   docked[i] = nil;
		}	
	  }
	
	}	
}

/*End touch event handling*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[super dealloc];
}

/*Animations stopped: A possible signal to start the timer*/
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	//8787 means that the last piece has slid in:
	if ((int) context == 8787 && [finished boolValue] == YES)
	{	
	  
		
	  //Start the game timer:
	  [ [NSRunLoop mainRunLoop] addTimer:gameTimer forMode:NSDefaultRunLoopMode ];
	  shouldTime = YES;
     
	 //Player can drag pieces: 
	 canDrag = YES;
	}
}

//The tick function: 
//When the timer fires, tick will update the text on the timer label.
-(void) tick:(NSTimer *)timer
{
	//NSLog(@"Tick");
	if ( [timer isValid] && shouldTime)
	  totalTime += 1;
	
	NSString *lblText = [NSString stringWithFormat:( ( (totalTime % 60) < 10) ?  @"%d:0%d" : @"%d:%2d" ),(totalTime / 60),(totalTime % 60) ];
	[timeField setText:lblText];
	
}

//newGame releases all pieces and resets the board and docked arrays. It alpha fades the pieces out
//before releasing them, using the help of animationDidStop. It also stops the game timer
-(IBAction)newGame
{
	
	//Stop the timer:
	if (shouldTime)
	{
	  [gameTimer invalidate];
	  [gameTimer release];
	  shouldTime = NO;
    }
	
	//Remove the pieces:
	
	if (board[0] != nil)
	{	
	  for (int i = 0; i < 9; i++)
	  {
		[board[i] removeFromSuperview];
		[board[i] release];
		docked[i] = nil;
	  }
	}	
	
	//Start the game over:
	//[self initPuzzle];
	
	NSDate *now = [NSDate date];
	//[lastAdImpression
	
	if ([now timeIntervalSinceDate:lastAdImpression ] > 30.0 || first)
	{
		[lastAdImpression release];
		GSDisplayAd();
		first = NO;
		which = YES;
		lastAdImpression = [now retain];
	}
	else
		[self initPuzzle];
	
	
}

//Show high score view:
-(IBAction)showScores
{
	//[self emailChallenge];
	//UIAlertView *uiAlert = [ [UIAlertView alloc] initWithTitle:@"High Scores" message:@"You Win!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	//[uiAlert show];
	//[uiAlert release];
	
	//Stop the timer:
	if(shouldTime)
	{
	  shouldTime = NO;
	  [gameTimer invalidate];
	  [gameTimer release];
	}
	
	if (hasWon == YES)
	{
		if ( [ scoreView checkScore:totalTime] == YES)
		{	
		   UIAlertView *uiAlert = [ [UIAlertView alloc] initWithTitle:@"You Got a High Score!" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		   //alertFrame.origin.y -= 85;
		  [uiAlert addTextFieldWithValue:@"" label:@"Enter name"]; 
		  scoreField = [uiAlert textFieldAtIndex:0]; //[ [UITextView alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)]; 
		 [scoreField retain];
		  scoreField.keyboardAppearance = UIKeyboardAppearanceAlert;
		  scoreField.autocorrectionType = UITextAutocorrectionTypeNo;
			
		  [uiAlert show];
		 
		 // CGRect alertFrame = [uiAlert frame];
		  //alertFrame.origin.y -= 55;
		  //[uiAlert setFrame:alertFrame];
		
		 		
		  //[uiAlert addSubview:scoreField];
		  hasWon = NO;
		  canDrag = YES;  
		
		 }
		 else
		 {
		     /*	 
			 UIAlertView *askChallenge =  [ [UIAlertView alloc]  initWithTitle:@"Challenge Friends" message:@"Would You Like to Send This Puzzle To a Friend?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
			 [askChallenge show];
			  */
			 
		 }
	}
	[scoreView insertAd];
	[self presentModalViewController:scoreView animated:YES];
	
		
	
	
	/*Reset the game:*/
	if(board[0] != nil)
	{	
		NSArray* subviews = self.view.subviews;
		//Remove the pieces:
		for (int i = 0; i < [subviews count]; i++)
		{
			if ([ [subviews objectAtIndex:i] isKindOfClass:[GamePiece class] ])	
				[[subviews objectAtIndex:i] setHidden:YES];
			canDrag = NO;
			//[board[i] dealloc];
			
			//board[i] = nil;
			//docked[i] = nil;
		}
	}	
	 	
	}

//Validate puzzle makes sure all pieces are in valid sequence, and then
//it will stop the timer and show the high scores.
-(void)validatePuzzle
{
	int i = 0;
	while (i < 9)
	{
		if (docked[i] == nil)
			break;
		else
			if ([docked[i] getSequence] == i)
			{	
				if (i == 8)
				{
					 hasWon = YES;
					[self showScores];
				}
			}
			else
			break;
		i++;
	}
}
//Dismissing the high score alert view:
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{	
  if ([alertView.title isEqualToString:@"You Got a High Score!"])
  {
	  [scoreView newEntry:[scoreField text] withScore:totalTime];
	  /*
	  UIAlertView *askChallenge =  [ [UIAlertView alloc]  initWithTitle:@"Challenge Friends" message:@"Would You Like to Send This Puzzle To a Friend?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
	  [askChallenge show];
	   */
	  
  }
  else
  {
	  if (buttonIndex == [alertView cancelButtonIndex])
	  {
		  [self emailChallenge];
	  }
  }
  //Prepare for new game:
	/*
	if (hasWon == YES)
	{
		
		//Remove the pieces:
		for (int i = 0; i < 9; i++)
		{
			[board[i] removeFromSuperview];
			[board[i] release];
			//[board[i] dealloc];
			board[i] = nil;
			docked[i] = nil;
		}
		hasWon = NO;
	}
	*/
	
}

//----------------------------------Greystripe delegate methods------------------------------//
- (void) greystripeDisplayWillOpen
{
	shouldTime = NO;
}

- (void) greystripeDisplayWillClose
{
	if (which == YES)
	{
		[self initPuzzle];
	}
}
//--------------------------------------- End Greystripe------------------------------------//


//---------------------------------------State Saving/Restoring Functions----------------------------//
-(NSString *)stateString
{
	return stateString;
}

-(void)setStateString:(NSString *)state
{
	stateString = state;
}

//---This function is creates a mailto: for sending a game url:
-(void)emailChallenge
{
	
	  NSLog(@"3.0");
	  NSArray *times = [timeField.text componentsSeparatedByString:@":"];

	  /*
	  NSMutableString *mailBody = [[NSMutableString alloc] initWithString:@"I%20solved%20this%20iVexed%20puzzle%20in%20just%20" ];
	  [mailBody appendString:[times objectAtIndex:0] ];
	  [mailBody appendString:@"minutes%20and%20"];
	  [mailBody appendString:[times objectAtIndex:1] ];
	  [mailBody appendString:@"%20seconds.%20Can you?%20Give it a shot with the link below:%0D%0A%3Ca%20href%3D%22"];
      [mailBody appendString:[stateString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding] ];
	  [mailBody appendString:@"%22/%3EBeat%20my%20score%21%3C/a%3E"];
	  */ 
	   
	   
	NSString *mailto = [ [NSString alloc] initWithFormat:@"mailto:?subject=Try%20to%20beat%20me%20at%20iVexed!"];
	[ [UIApplication sharedApplication] openURL:[NSURL URLWithString:mailto]];

	/*
	if ( [[ UIDevice currentDevice ].systemVersion characterAtIndex:0] == '3'  ) 
	  {

	  if (stateString)
	  {
		 
		  NSArray *times = [timeField.text componentsSeparatedByString:@":"];
		  //Test email sending and set up the message body:
		  if([MFMailComposeViewController canSendMail] )
		  {
			  NSLog(@"Pre creation mail-sheet");
			  MFMailComposeViewController *mailSheet = [ [MFMailComposeViewController alloc] init];  
			  [mailSheet setSubject:@"Try to beat me at iVexed!"];
			  NSLog(@"Post-creation mail-sheet");
			
			  NSString *msgBody = [ [NSString alloc] initWithFormat:@"I solved this iVexed puzzle in just %@ minutes and %@ seconds. Can you? Give it a shot with the link below:<br /><a href='%@'>Beat my score</a><br />If you don't have iVexed, use the link below to get it for free!<br />",[times objectAtIndex:0],[times objectAtIndex:1],stateString]; 
			  
			 [mailSheet setMessageBody:msgBody isHTML:YES];
			 [mailSheet setDelegate:self];
			  
			 [self presentModalViewController:mailSheet animated:YES];
			  NSLog(@"presented mail sheet.");
			 //[msgBody release];
		  }
		  else
		  {
				 UIAlertView *failure = [ [UIAlertView alloc] initWithTitle:@"Error" message:@"You must have Mail setup properly to use this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				 [failure show];
				 [failure release];
		  }
			  
	  }
		  
	  
  }
  else
  {
	  NSLog(@"2.0");
	  NSMutableString *mailBody = [[NSMutableString alloc] initWithString:@"I%20solved%20this%20iVexed%20puzzle%20in%20just%20" ];
	  [mailBody appendString:[times objectAtIndex:0] ];
	  [mailBody appendString:@"minutes%20and%20"];
	  [mailBody appendString:[times objectAtIndex:1] ];
	  [mailBody appendString:@"%20seconds.%20Can you?%20Give it a shot with the link below:%0D%0A%3Ca%20href%3D%22"];
      [mailBody appendString:[stateString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding] ];
	  [mailBody appendString:@"%22/%3EBeat%20my%20score%21%3C/a%3E"];
	  NSString *mailto = [ [NSString alloc] initWithFormat:@"mailto:?subject=Try%20to%20beat%20me%20at%20iVexed!&body=%@",mailBody];
	  [ [UIApplication sharedApplication] openURL:mailto];
	  
  }
	  */
}

//newGameFromURL: This is like the newGame function, except it creates the new game from a url.
-(void)newGameFromURL:(NSString *)url
{
	//Stop the timer:
	
	if (shouldTime)
	{
		[gameTimer invalidate];
		[gameTimer release];
		shouldTime = NO;
    }
	
	//Remove the pieces:
	
	if (board[0] != nil)
	{	
		for (int i = 0; i < 9; i++)
		{
			[board[i] removeFromSuperview];
			[board[i] release];
			docked[i] = nil;
		}
	}	
	
	//Start the game over:
	[self initPuzzleWithURL:url];
	
	
}


//initPuzzleWithURL: Same as initPuzzle but the numbers come from a string.
-(void)initPuzzleWithURL: (NSString *)url
{
	hasWon = NO;
	
	srand(time(0));
	for (int i = 0; i < 9; i++)
	{
		//Create the puzzle places off screen and position them for slide in at the top
		//and bottom docks:
		board[i] = [ [GamePiece alloc] initWithFrame:CGRectMake(-70, (i < 4) ? 52 : 349 ,65,65) ];
		[board[i] setSequence:i];
		
		[board[i] retain];
		[self.view addSubview:board[i] ];
		
	}
	//[bgView setImage:[UIImage defaultDesktopImage]]; REMOVED
	
	/*Cannot drag pieces until the intro is over:*/
	canDrag = NO;
	
	/*Clear the timer & totalTime:*/
	[timeField setText:@"0:00"];
	totalTime = 0;
	//Set up the timer:
	gameTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
	[gameTimer retain];
	
	
	/*Generate the puzzle numbers: */
	int arbitrary[24];
	for(int i = 0; i < 24; i++)
	{
		char c = [url characterAtIndex:i];
		arbitrary[i] = atoi(&c);
	}
	[board[0] setLeft:arbitrary[0] ];
	[board[0] setTop:arbitrary[1] ];
	[board[0] setRight:arbitrary[2] ];
	[board[0] setBottom:arbitrary[8] ];
	
	[board[1] setLeft:arbitrary[2] ];
	[board[1] setTop:arbitrary[3] ];
	[board[1] setRight:arbitrary[4] ];
	[board[1] setBottom:arbitrary[10] ];
	
	[board[2] setLeft:arbitrary[4] ];
	[board[2] setRight:arbitrary[6] ];
	[board[2] setTop:arbitrary[5] ];
	[board[2] setBottom:arbitrary[12] ];
	
	[board[3] setLeft:arbitrary[7] ];
	[board[3] setRight:arbitrary[9] ];
	[board[3] setTop:arbitrary[8] ];
	[board[3] setBottom:arbitrary[15] ];
	
	[board[4] setLeft: arbitrary[9] ];
	[board[4] setRight:arbitrary[11] ];
	[board[4] setTop:arbitrary[10] ];
	[board[4] setBottom:arbitrary[18]];
	
	[board[5] setLeft:arbitrary[11] ];
	[board[5] setRight:arbitrary[13] ];
	[board[5] setTop:arbitrary[12]];
	[board[5] setBottom:arbitrary[21] ];
	
	[board[6] setLeft:arbitrary[14] ];
	[board[6] setRight:arbitrary[17] ];
	[board[6] setTop:arbitrary[15] ];
	[board[6] setBottom:arbitrary[16] ];
	
	[board[7] setLeft:arbitrary[17] ];
	[board[7] setRight:arbitrary[20] ];
	[board[7] setTop:arbitrary[18] ];
	[board[7] setBottom:arbitrary[19]];
	
	[board[8] setLeft:arbitrary[20] ];
	[board[8] setRight:arbitrary[23]];
	[board[8] setTop:arbitrary[21] ];
	[board[8] setBottom:arbitrary[22] ];
	
	
	/*permute the puzzle pieces:*/
	
	for (int i  = 0; i < 9; i++)
	{
		GamePiece *tmp;
		int swap = rand() % 9;
		int swap2 = rand() % 9;
		tmp = board[swap];
		board[swap] = board[swap2];
		board[swap2] = tmp;
		CGRect frame1 = CGRectMake(-70, (swap < 4) ? 52 : 349 ,65,65);
		CGRect frame2 = CGRectMake(-70, (swap2 < 4) ? 52 : 349 ,65,65);
		[board[swap] setFrame:frame1];
		[board[swap2] setFrame:frame2];
		
	}
	
	//Animate the pieces in:
	
	for (int i = 0; i < 9; i++)
	{
	    [UIView beginAnimations:nil	context:(void *)8787];
		[UIView setAnimationDelay:1.0*i];
		[UIView setAnimationDuration:0.2];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		
		//We need to know when the last animation ends:
		if (i == 8)
			[UIView setAnimationDelegate:self];
		
		CGRect frame = board[i].frame;
		
		frame.origin.x = xdocks[i];
		frame.origin.y = ydocks[i];
		[board[i] setFrame:frame];
		
		[UIView commitAnimations];
	}
	
}
//---------------------------------------End State Saving/Restoring Functions-----------------------//

//---------NEW 9/9/09 Ad Supporting Functions------------------------------------------------------//


//---------End Ad Supporting Functions------------------------------------------------------------//


@end
