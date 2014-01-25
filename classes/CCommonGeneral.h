//
//  CCommonGeneral.h
//  nohint
//
//  Created by たいにゃん on 12/06/21.
//
//

#import <Foundation/Foundation.h>
#import "commonGeneralProtocol.h"

@class CCommonGame;
@class CTouchBuffer;
@class CMyShader;
@class CTouchToGame;
@class CCreateGLMatrix;
@class CCommonPrintFont;

@interface CCommonGeneraliOS : NSObject <commonGeneralProtocol>
{
    CCommonGame* m_game;
    CTouchBuffer* m_touchBuffer;
	CTouchToGame* m_touchToGame;
	CCreateGLMatrix* m_createGLMatrix;
	CCommonPrintFont* m_printFont;

}

-(id)init:(CCommonGame*)lpGame;
-(void)GeneralInit;
-(int)GeneralCalcu;
-(void)GeneralPrint;
-(void)GeneralFinalExitRoutine;


//-(void)Init;
//-(int)Calcu;
//-(void)Print;
//-(void)FinalExitRoutine;


@end
