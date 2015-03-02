//
//  GamePiece.m
//  iVexed
//
//  Created by Michael Colson on 7/16/08.
//  Copyright 2008 Thetalogik. All rights reserved.
//

#import "GamePiece.h"


@implementation GamePiece


- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
		[self setImage:[UIImage imageNamed:@"piece.png"] ];
		topLbl = [ [UILabel alloc] initWithFrame:CGRectMake(27, 0, 16, 21) ];
		topLbl.text = @"0";
		[topLbl setBackgroundColor: [UIColor clearColor] ];
		
		
		leftLbl = [ [UILabel alloc] initWithFrame:CGRectMake(5, 20, 16, 21) ];
		leftLbl.text = @"0";
		[leftLbl setBackgroundColor:[UIColor clearColor] ];
		rightLbl = [ [UILabel alloc] initWithFrame:CGRectMake(49, 20, 16, 21) ];
		rightLbl.text = @"0";
		[rightLbl setBackgroundColor:[UIColor clearColor] ];
		
		btmLbl = [ [UILabel alloc] initWithFrame:CGRectMake(27, 40, 16, 21) ];
		btmLbl.text = @"0";
		[btmLbl setBackgroundColor:[UIColor clearColor] ];
		
		/*Add Labels:*/
		[self addSubview:topLbl];
		[self addSubview:leftLbl];
		[self addSubview:rightLbl];
		[self addSubview:btmLbl];
		
		//Game Pieces recieve events:
		self.userInteractionEnabled = YES;
		
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	// Drawing code
}


- (void)dealloc {
	[topLbl dealloc];
	[btmLbl dealloc];
	[rightLbl dealloc];		
	[leftLbl dealloc];
			
	[super dealloc];
}

-(void)setTop:(int)t
{
 	top = t;
	NSNumber* n = [NSNumber numberWithInt:t];
	
	
	[ topLbl setText: [n stringValue] ];
}

-(void)setBottom:(int)b
{
	bottom = b;
	
	NSNumber* n = [NSNumber numberWithInt:b];
	
	
	[ btmLbl setText: [n stringValue] ];
}

-(void)setLeft:(int)l
{
	left = l;
	
	NSNumber* n = [NSNumber numberWithInt:l];
	
	
	[ leftLbl setText: [n stringValue] ];
}

-(void)setRight:(int)r
{
	right = r;	
	
	NSNumber* n = [NSNumber numberWithInt:r];
	
	
	[ rightLbl setText: [n stringValue] ];
}

-(int)getRight 
{
	return right;	
}

-(int)getLeft
{
	return left;
}

-(int)getTop
{
	return top;
}

-(int)getBottom
{
	return bottom;
}

-(BOOL) isDocked
{
	return docked; 	
}

-(void)setDocked:(BOOL)dock
{
	docked = dock;
}

-(void)setSequence:(int)s;
{
	sequence = s;
}
-(int)getSequence
{
	return sequence;
}


@end
