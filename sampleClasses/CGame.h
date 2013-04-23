//
//  CGame.h
//  comike2011win
//
//  Created by 山口 慎治 on 12/01/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "../../TinyanLibOS5/classes/CMyCaptureProtocol.h"
#import "../../TinyanLibOS5/classes/CMyTexture.h"

#import "mode.h"

#import "../../TinyanLibOS5/classes/commonGeneralProtocol.h"
#import "../../TinyanLibOS5/classes/CCommonGeneral.h"

//#import "CDrawBuffer.h"

//#import "CTouchToGame.h"
//#import "CTouchBuffer.h"

@class CPutBuffer;
//@class CMyCapture;
@class CMyShader;
@class CCommonGame;

@interface CGame  : CCommonGame //<CMyCaptureProtocol>
{
//    CMyCapture* m_capture;
//    id <CSystemNNN> m_general[100];


//	CMyTexture* m_texture;

    
  //  CDrawBuffer* m_drawBuffer;
    
}

//-(void)test:(char*)aaa,...;

-(id)init;

//-(CMyTexture*)getMyTexture:(int)n;
//-(CMyShader*)getMyShader:(int)n;
//-(CDrawBuffer*)getDrawBuffer;
//-(CPartsPic*)getFontPic;
//-(CMessage*)getMessage;
//-(CPartsPic*)getPanelPic;
//-(CTouchBuffer*)getTouchBuffer;

//-(void)onTimer;
//-(void)onDraw:(UIView *)view drawInRect:(CGRect)rect;


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;
//-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view;

//-(void) BinaryPointerCallback:(unsigned char*)buffer size:(CGSize)size next:(int)bytesPerRow;

-(void)createMyShader;


@end
