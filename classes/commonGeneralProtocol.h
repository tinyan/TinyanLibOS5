//
//  commonGeneralProtocol.h
//  doroRunnerHD
//
//  Created by たいにゃん on 10/11/09.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol commonGeneralProtocol

@optional

-(void)Init;
-(int)Calcu;
-(void)Print;
-(void)FinalExitRoutine;


-(void)NNNTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint;
-(void)NNNTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint preGamePoint:(CGPoint*)gamePoint2;
-(void)NNNTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint;
-(void)NNNTtouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint;

@end
