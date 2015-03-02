//
//  GamePiece.h
//  iVexed
//
//  Created by Michael Colson on 7/16/08.
//  Copyright 2008 Thetalogik. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GamePiece : UIImageView 
{

	int top,bottom,left,right;
	UILabel* topLbl,*leftLbl,*rightLbl,*btmLbl;
	BOOL docked;
	BOOL valid;
	int sequence;
}

-(void)setTop:(int)top;
-(void)setBottom:(int)bottom;
-(void)setLeft:(int)left;
-(void)setRight:(int)right;
-(void)setDocked:(BOOL)docked;


//JOSH'S IDEA: Use the correct sequence to determine the winner
-(void)setSequence:(int)s;
-(int)getSequence;

-(int)getLeft;
-(int)getTop;
-(int)getRight;
-(int)getBottom;

-(BOOL)isDocked;

-(void)setDocked:(BOOL)dock;

@end
