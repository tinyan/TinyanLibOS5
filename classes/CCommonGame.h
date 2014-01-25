//
//  CGame.h
//  comike2011win
//
//  Created by たいにゃん on 12/01/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class CMyTexture;
@class CTouchBuffer;
@class CTouchToGame;
@class CCreateGLMatrix;
@class CMyShader;
@class CCreateGLMatrix;
@class CCommonPrintFont;

@class CCommonSoundControl;

@class CCommonGeneraliOS;


@interface CCommonGame  : NSObject //<CMyCaptureProtocol>
{
	CTouchToGame* m_touchToGame;
	CTouchBuffer* m_touchBuffer;
	CCreateGLMatrix* m_createGLMatrix;
	CGSize m_deviceScreenSize;
	CGSize m_deviceScreenSizeLandscape;
	CGSize m_gameSize;
	CGSize m_gameAtScreenSize;
	UIInterfaceOrientation m_rotationType[4];
	CGPoint m_gameAtScreenPoint[4];
	int m_atPointNumber;
	CCommonSoundControl* m_soundControl;
	CCommonPrintFont* m_printFont;
	
	int m_changeAutoRotateMode;
	
    CCommonGeneraliOS* m_general[256];
    int m_gameMode;
	
    CMyShader* m_shader[256];
	int m_shaderMax;
	
	BOOL m_active;
	BOOL m_iad;
	
//	UIInterfaceOrientation m_interfaceOrientation;
}


-(id)init;

-(CTouchBuffer*)getTouchBuffer;
-(CMyShader*)getMyShader:(int)n;
-(CTouchToGame*)getTouchToGame;
-(CCreateGLMatrix*)getCreateGLMatrix;
-(CCommonSoundControl*)getSoundControl;
-(CCommonPrintFont*)getPrintFont;

-(CGSize)getDeviceScreenSize;

-(void)onTimer;
-(void)onDraw:(UIView *)view drawInRect:(CGRect)rect;


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;


-(bool)NNNTouchesBeganGame:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint;
-(bool)NNNTouchesMovedGame:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint preGamePoint:(CGPoint*)gamePoint2;
-(bool)NNNTouchesEndedGame:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint preGamePoint:(CGPoint*)gamePoint2;
-(bool)NNNTtouchesCancelledGame:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint;


-(void)onRotate:(UIInterfaceOrientation)fromInterfaceOrientation from:(UIInterfaceOrientation)fromInterfaceOrientation;
-(void)willRotate:(UIInterfaceOrientation)toInterfaceOrientation to:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
-(void)calcuNewMatrix:(UIInterfaceOrientation)toInterfaceOrientation;

-(void)createMyShader;

-(void)setGameAtPoint:(UIInterfaceOrientation)orientation atPoint:(CGPoint)atPoint;
-(void)setGameAtPointAll:(CGPoint)atPoint;

-(void)onActive:(BOOL)flag;
-(void)oniAd:(BOOL)flag;

//virtual
-(void)afterPrintGame;
@end
