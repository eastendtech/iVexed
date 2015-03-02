//ScoreController.m Author: Michael Colson
//This file manages the table view that gets presented when the score button is pressed and
//also manages the sorting and saving of the score database. If no score data base exists,
//the program creates the default score database and displays it.

//CHANGES: Added createDefaultScoreFile to restore initial scorefile if it is missing.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "FonicBuddy.h"

@interface ScoreController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	int usrScore;
	UIViewController *parent;
	NSMutableArray * scores;
	NSMutableArray * names;
	NSMutableDictionary* records;
	NSFileManager * fm;
	
	IBOutlet UITableView *scrView;
	UIView *adView;
	IBOutlet FonicBuddy *fonicBuddy;
	
}

-(IBAction)goBack;
-(BOOL)checkScore:(int)score;
-(void)newEntry:(NSString *)name withScore:(int)score;
-(BOOL)loadScores;
-(BOOL)writeScores;
-(void)createDefaultScoreFile;
-(void)insertAd;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tV;
-(NSInteger)tableView:(UITableView *)tV numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)tableView:(UITableView *)tV cellForRowAtIndexPath:(NSIndexPath *)index; 

@end
