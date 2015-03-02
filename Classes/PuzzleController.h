//
//  PuzzleController.h
//  iVexed
//
//  Created by Michael Colson on 7/15/08.
//  Copyright Thetalogik 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePiece.h"
#import "ScoreController.h"
#import "WebController.h"


@interface PuzzleController : UIViewController {
	//IBOutlet UIView *targetView;
	
	/*Variables related to the puzzle pieces & game board*/
	GamePiece *board[9]; //All 9 game pieces.
	GamePiece *activePiece; //The puzzle piece the user is currently dragging.
	
	//The x,y locations of the docking regions:
	/*0-8: The location of the top and bottom docks.
	  9-17: The location of the actual puzzle blocks.
	 */
	int xdocks[18];
	int ydocks[18];
	
	/*Variables to keep track of game progress*/
	GamePiece *docked[9];
	BOOL canDrag;
	ScoreController *scoreView;
	BOOL hasWon;
	
	/*Timer-related variables & objects*/
	NSTimer *gameTimer;
	int totalTime;
    IBOutlet UILabel *timeField;
    BOOL shouldTime; //BUGFIX: Timer would start on its own
	UITextField * scoreField;
	IBOutlet UIImageView *bgView;
	
	//NEW: For keeping track of the time interval between advertising
	NSDate *lastAdImpression;
	BOOL first,which; //which == YES for new game, NO for cool stuff button.
	
	
	
	//NEW: For game saving:
	NSMutableString *stateString;
	
}

-(void)initPuzzle;
-(void)initPuzzleWithURL:(NSString *)url;
-(void)newGameFromURL:(NSString *)url;
-(void)tick:(NSTimer *)t;
-(IBAction)newGame;


-(IBAction)showScores;
-(IBAction)hitSweepstakes;

-(void)validatePuzzle; //Validate at, sets index i of valid array if piece is valid.
-(void)emailChallenge;


//NEW: For game saving:
-(NSString *)stateString;
-(void)setStateString:(NSString *)state;

//NEW: For banner ad support:
-(void)showAd;
-(void)removeAd;


@end

