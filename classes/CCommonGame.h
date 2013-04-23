//
//  CGame.h
//  comike2011win
//
//  Created by 山口 慎治 on 12/01/19.
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

@class CCommonGeneral;


@interface CCommonGame  : NSObject //<CMyCaptureProtocol>
{
	CTouchToGame* m_touchToGame;
	CTouchBuffer* m_touchBuffer;
	CCreateGLMatrix* m_createGLMatrix;
	CGSize m_mainScreenSize;
	CGSize m_mainScreenSizeLandscape;
	CGSize m_gameSize;
	CGSize m_gameAtScreenSize;
	UIInterfaceOrientation m_rotationType[4];
	CGPoint m_gameAtScreenPoint[4];
	int m_atPointNumber;
	CCommonSoundControl* m_soundControl;
	CCommonPrintFont* m_printFont;
	
	int m_changeAutoRotateMode;
	
    CCommonGeneral* m_general[256];
    int m_gameMode;
	
    CMyShader* m_shader[256];
	int m_shaderMax;
	
	BOOL m_active;
	BOOL m_iad;
}


-(id)init;

-(CTouchBuffer*)getTouchBuffer;
-(CMyShader*)getMyShader:(int)n;
-(CTouchToGame*)getTouchToGame;
-(CCreateGLMatrix*)getCreateGLMatrix;
-(CCommonSoundControl*)getSoundControl;
-(CCommonPrintFont*)getPrintFont;


-(void)onTimer;
-(void)onDraw:(UIView *)view drawInRect:(CGRect)rect;


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;

-(void)onRotate:(UIInterfaceOrientation)fromInterfaceOrientation from:(UIInterfaceOrientation)fromInterfaceOrientation;
-(void)willRotate:(UIInterfaceOrientation)toInterfaceOrientation to:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
-(void)calcuNewMatrix:(UIInterfaceOrientation)toInterfaceOrientation;

-(void)createMyShader;

-(void)setGameAtPoint:(UIInterfaceOrientation)orientation atPoint:(CGPoint)atPoint;

-(void)onActive:(BOOL)flag;
-(void)oniAd:(BOOL)flag;

@end
