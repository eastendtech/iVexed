#import "ScoreController.h"

@implementation ScoreController

//Perform Initialization such as creating or loading score plist:
+ (id)alloc
{
	self = [super alloc];
	if (self)
    {		
   	
	//Setup the file manager:
	if (!fm)
	{
	 fm = [[NSFileManager alloc] retain];
	}
	
	if (! [self loadScores] )
	{
		[self createDefaultScoreFile];
	}
		
	}
	
	return self;	
}

-(void)viewDidLoad
{
	/*
	NSLog(@"View did load.");
	adView = [[TapjoyConnect requestTapjoyConnectWithDelegate:nil] 
					  showAdBox:1 rect:CGRectMake(0, 410, 320, 90)]; 
	[self.view addSubview:adView];
    [self.view bringSubviewToFront:adView];
	 */
}

-(void)dealloc
{
	[fm release];
	[records release];
	[names release];
	[scores release];
	[super dealloc];
}

-(void)setScore:(int)score
{
	usrScore = score;
}

-(int)getScore
{
	return usrScore;
}


-(IBAction)goBack
{
	if (adView)
	{
		[adView removeFromSuperview];
		adView = nil;
	}
	
	if (fonicBuddy)
	{
		[fonicBuddy stopTimer];
	}
	
	
	[self dismissModalViewControllerAnimated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tV
{ 
	return 1;
}

-(NSInteger)tableView:(UITableView *)tV numberOfRowsInSection:(NSInteger)section 
{

	//Count of data
	return 10;
	
}

-(UITableViewCell *)tableView:(UITableView *)tV cellForRowAtIndexPath:(NSIndexPath *)index
{
	UITableViewCell *cell = [tV dequeueReusableCellWithIdentifier:@"ScoreCell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(0,0,0,0) reuseIdentifier:@"ScoreCell"] autorelease];
    }
	
	NSArray *nameArray = [records objectForKey:@"Names"];
	NSArray *scoresArray = [records objectForKey:@"Scores"];
	NSString *name = [nameArray objectAtIndex:index.row];
	NSUInteger intscore = [ [scoresArray objectAtIndex:index.row] integerValue];
	NSString * score = [NSString stringWithFormat:( ( (intscore % 60) < 10) ?  @"%d:0%d" : @"%d:%2d" ),(intscore / 60),(intscore % 60) ];
	
	cell.text = [ [NSString stringWithFormat: @"%s, %s",[name cString], [score cString] ] retain ];
	
	return cell;
}

//Adds a new score to the list and re-sorts the list
-(void)newEntry:(NSString *)name withScore:(int)score;
{
	if (records)
	{
		NSMutableArray *scoresArray = [records objectForKey:@"Scores"];
	    NSMutableArray *namesArray  = [records objectForKey:@"Names"];
		
		if (scoresArray)
		{
			int i = 0;
			int len = [scoresArray count];
			
			//Find where in the score array the number fits:
			while (i < len)
			{
				if ( [ [scoresArray objectAtIndex:i] integerValue]  >= score )
				{
					//[scoresArray replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:score] ];
					//[namesArray replaceObjectAtIndex:i withObject:name];
					
					[scoresArray insertObject:[NSNumber numberWithInt:score] atIndex:i];
					[namesArray insertObject:name atIndex:i];
					
					if ( [scoresArray count] < 10 )
					{
						[scoresArray removeLastObject];
						[namesArray removeLastObject];
					}	
						
					[records setObject:scoresArray forKey:@"Scores"];
					[records setObject:namesArray forKey:@"Names"];
					
					
					[scrView reloadData];
					
					break;
				}
				i++;
			}
			
			
		}
		
	}
	
	//Save the new scores:
	[self writeScores];
	
}

//Checks to see if score is new high score
-(BOOL)checkScore:(int)score
{
	BOOL newHigh = NO;
	if (records)
	{
		NSMutableArray *scoresArray = [records objectForKey:@"Scores"];
		if (scoresArray)
		{
			int last = 9;   //[scoresArray count] - 1;
			NSLog(@"Last: %i",[[scoresArray objectAtIndex:last] integerValue] );
			NSLog(@"Score: %i",score);
			
			if (score <= [ [scoresArray objectAtIndex:last] integerValue ] )
				newHigh = YES;
		}
		
	}
	return newHigh;
}

-(BOOL)loadScores
{
	BOOL success;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *scoresFile = [NSMutableString stringWithFormat:@"%s/Scores.plist",[documentsDirectory cString] ];
   if ([fm fileExistsAtPath:scoresFile])
	{
		success = YES;	
		NSLog(@"Success");
		
		records =  [ [ NSMutableDictionary dictionaryWithContentsOfFile:scoresFile] retain];
		
	}
	else
	{
		success = NO;
		NSLog(@"Failure");
	}
	
	return success;
}

-(BOOL)writeScores
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *scoresFile = [NSMutableString stringWithFormat:@"%s/Scores.plist",[documentsDirectory cString] ];
	
	if ([records writeToFile:scoresFile atomically:YES])
		return YES;
	else
		return NO;

}

-(void)createDefaultScoreFile
{
	scores = [[NSMutableArray arrayWithCapacity:10] retain];
	names  = [ [NSMutableArray arrayWithCapacity:10] retain];
	NSLog(@"createDefaultScoreFile recieved.");
	
	/*
	[names addObject: @"Michael"];	
    [names addObject: @"Barbara"];
	[names addObject: @"Josh"];
	[names addObject: @"Vivian"];
	[names addObject: @"John"];

	[names addObject: @"Ray"];
	[names addObject: @"DeeDee"]; 
	[names addObject: @"Michelle"]; 
	[names addObject: @"Samantha"]; 
	[names addObject: @"Sarah"]; 
	[names addObject: @"Lizzie"];
	*/
	for (int i = 0; i <= 10; i++)
    {
		[ names addObject:@"iPhone Whiz" ];
	}
	 
	for (int i = 1; i <= 10; i++)
    {
		[scores addObject: [NSNumber numberWithInt: 60*i] ];
	}
	
	records = [ [NSMutableDictionary  dictionaryWithCapacity:2] retain];
    [records setObject:names forKey:@"Names"];			   
	[records setObject:scores forKey:@"Scores"];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *scoresFile = [NSMutableString stringWithFormat:@"%s/Scores.plist",[documentsDirectory cString] ];
	
	[records writeToFile:scoresFile atomically:YES];
}

//NEW 9/9-TapJoy Ad Support
//NEW 10/12-AdFonic Support.
-(void)insertAd
{
	NSLog(@"insertAd:");
	[fonicBuddy startTimer];
	//[self.view bringSubviewToFront:fonicBuddy.view];
}



@end

