//
//  CCommonGeneral.m
//  nohint
//
//  Created by たいにゃん on 12/06/21.
//
//

#import "CTouchBuffer.h"
#import "CTouchToGame.h"
//#import "CDrawBuffer.h"
#import "CCommonGeneral.h"
#import "CCommonGame.h"
#import "CCommonFont.h"

@implementation CCommonGeneral

-(id)init:(CCommonGame*)lpGame
{
    self = [super init];
    if (self)
    {
//        NSLog(@"super init");
        
        m_game = lpGame;
        m_touchBuffer = [m_game getTouchBuffer];
		m_touchToGame = [m_game getTouchToGame];
		m_createGLMatrix = [m_game getCreateGLMatrix];
		m_printFont = [m_game getPrintFont];
    }
    
    return self;
}
-(void)GeneralInit
{
    [self Init];
}

 
-(int)GeneralCalcu
{
    int rt = [self Calcu];
    [m_touchBuffer clear];
    return rt;
}

-(void)GeneralPrint
{
    [self Print];
}

-(void)GeneralFinalExitRoutine
{
    [self FinalExitRoutine];
}


-(void)NNNTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint
{
//	NSLog(@"commongeneral:NNNTouchesBegin");
}

-(void)NNNTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint preGamePoint:(CGPoint*)gamePoint2
{
}

-(void)NNNTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint
{
}

-(void)NNNTtouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint
{
}


/*
-(void)Init
{
    NSLog(@"called super Init");
}
-(int)Calcu
{
    return -1;
}
-(void)Print
{
}
-(void)FinalExitRoutine
{
}
*/

@end
