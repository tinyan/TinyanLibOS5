//
//  CCommonGame.m
//
//  Created by Tinyan
//  Copyright (c) 2012年 Bugnekosoft All rights reserved.
//

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import <sys/utsname.h>

#import "CMyMachineModel.h"
#import "CMyTexture.h"
#import "CTouchToGame.h"
#import "CTouchBuffer.h"
#import "CCreateGLMatrix.h"

#import "CCommonSoundControl.h"

#import "commonGeneralProtocol.h"
#import "CCommonGeneral.h"
#import "CCommonGame.h"

#import "CMyShader.h"

@implementation CCommonGame

-(id)init
{
    self = [super init];
    if (self)
    {
		m_changeAutoRotateMode = 1;
		
		m_deviceScreenSize = [[UIScreen mainScreen]bounds].size;
		if (m_deviceScreenSize.width > m_deviceScreenSize.height)
		{
			float tmp = m_deviceScreenSize.width;
			m_deviceScreenSize.width = m_deviceScreenSize.height;
			m_deviceScreenSize.height = tmp;
		}
		
		m_deviceScreenSizeLandscape.width = m_deviceScreenSize.height;
		m_deviceScreenSizeLandscape.height = m_deviceScreenSize.width;
		
//		struct utsname u;
//        uname(&u);
//        NSLog(@"machine = %s",u.machine);
        
//        GLint maxsize;
//        glGetIntegerv(GL_MAX_RENDERBUFFER_SIZE,&maxsize);
//        NSLog(@"max render size = %d",maxsize);

        
        m_touchBuffer = [[CTouchBuffer alloc]init];

        [self createMyShader];

//        m_drawBuffer = [[CDrawBuffer alloc] init];

		//default
        m_touchToGame = [[CTouchToGame alloc] init];
		[m_touchToGame setScreenSize:CGSizeMake(1024,768)];
		[m_touchToGame setGameSize:CGSizeMake(1000,700)];
		[m_touchToGame setGameAtScreenAspect];
		[m_touchToGame setScaleFactor:2.0f];

        m_createGLMatrix = [[CCreateGLMatrix alloc] init];
		
		m_soundControl = [[CCommonSoundControl alloc]init];
		
        m_gameMode = 0;
    }
    
    
    return self;
}

//dummy rorutine
-(void)createMyShader
{
//    m_shader[0] = [[CMyShader alloc]initWithPairName:@"Shader"];
  //  [m_shader[0] AddBindAttribLocation:"a_position"];
//    [m_shader[0] AddBindAttribLocation:"a_texCoord"];
//    [m_shader[0] linkProgram];
//	[m_shader[0] AddTextureUniformLocation:"s_texture"];
//	[m_shader[0] AddMatrixUniformLocation:"u_matrix"];

}

-(CTouchBuffer*)getTouchBuffer
{
    return m_touchBuffer;
}

-(CTouchToGame*)getTouchToGame
{
	return m_touchToGame;
}

-(CMyShader*)getMyShader:(int)n
{
    return m_shader[n];
}

-(CCreateGLMatrix*)getCreateGLMatrix
{
	return m_createGLMatrix;
}

-(CCommonSoundControl*)getSoundControl
{
	return m_soundControl;
}

-(CCommonPrintFont*)getPrintFont
{
	return m_printFont;
}

-(void)onTimer
{
	if (m_iad) return;
	
    int rt = [m_general[m_gameMode] GeneralCalcu];
    if (rt != -1)
    {
        [m_general[m_gameMode] GeneralFinalExitRoutine];
        m_gameMode = rt;
        [m_general[m_gameMode] GeneralInit];
    }
}


-(void)onActive:(BOOL)flag
{
	m_active = flag;
}

-(void)oniAd:(BOOL)flag
{
	m_iad = flag;
}

-(void)onDraw:(UIView *)view drawInRect:(CGRect)rect
{
	if (!m_active) return;
	if (m_iad) return;
	
	
	
	
	//
	CGSize screenSize = [m_touchToGame getScreenSize];
	float factor = [m_touchToGame getScaleFactor];
	
    glViewport(0,0,screenSize.width * factor,screenSize.height*factor);
//	glViewport(0,0,2048,1536);
	

	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    
    [m_general[m_gameMode] GeneralPrint];
	[self afterPrintGame];
}

//virtual
-(void)afterPrintGame
{
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view
{
//    NSLog(@"touch in CGame¥n");

    NSArray* allTouch = [touches allObjects];
	if (allTouch.count > 0)
	{
		CGPoint* gamePoint = (CGPoint*)malloc(sizeof(CGPoint) * allTouch.count);
		for (int i=0;i<allTouch.count;i++)
		{
			UITouch* touch = [allTouch objectAtIndex:i];
			CGPoint pt = [touch locationInView:view];
			CGPoint pt2 = [m_touchToGame screenToGame:pt];
			*(gamePoint+i) = pt2;
		}

		if (![self NNNTouchesBeganGame:touches withEvent:event view:view gamePoint:gamePoint])
		{
			[m_general[m_gameMode] NNNTouchesBegan:touches withEvent:event view:view gamePoint:gamePoint];
		}
		
		free(gamePoint);
	}
	
	
	/*
    for (int i=0;i<allTouch.count;i++)
    {
        UITouch* touch = [allTouch objectAtIndex:i];
        CGPoint pt = [touch locationInView:view];
        [touch g]
        //
        NSLog(@"x= %d y=%d",(int)pt.x,(int)pt.y);
        [m_touchBuffer addTouchStart:pt];
        
        
        
        if (m_gameMode == TITLE_MODE)
        {
            [(CTitle*)m_general[TITLE_MODE] dummy];
        }
    }
	 */
    
//    m_clearCount = 2;
    
    
//    m_startFlag = YES;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view
{
    NSArray* allTouch = [touches allObjects];
	if (allTouch.count > 0)
	{
		CGPoint* gamePoint = (CGPoint*)malloc(sizeof(CGPoint) * allTouch.count);
		CGPoint* gamePoint2 = (CGPoint*)malloc(sizeof(CGPoint) * allTouch.count);
		for (int i=0;i<allTouch.count;i++)
		{
			UITouch* touch = [allTouch objectAtIndex:i];
			CGPoint pt = [touch locationInView:view];
			CGPoint pt2 = [m_touchToGame screenToGame:pt];
			*(gamePoint+i) = pt2;
			CGPoint pt3 = [touch previousLocationInView:view];
			CGPoint pt4 = [m_touchToGame screenToGame:pt3];
			*(gamePoint2 + i) = pt4;
			
		}
		
		if (![self NNNTouchesMovedGame:touches withEvent:event view:view gamePoint:gamePoint preGamePoint:gamePoint2])
		{
			[m_general[m_gameMode] NNNTouchesMoved:touches withEvent:event view:view gamePoint:gamePoint preGamePoint:gamePoint2];
		}
								
		free(gamePoint2);
		free(gamePoint);
	}

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view
{
    NSArray* allTouch = [touches allObjects];
	if (allTouch.count > 0)
	{
		CGPoint* gamePoint = (CGPoint*)malloc(sizeof(CGPoint) * allTouch.count);
		CGPoint* gamePoint2 = (CGPoint*)malloc(sizeof(CGPoint) * allTouch.count);
		
		for (int i=0;i<allTouch.count;i++)
		{
			UITouch* touch = [allTouch objectAtIndex:i];
			CGPoint pt = [touch locationInView:view];
			CGPoint pt2 = [m_touchToGame screenToGame:pt];
			*(gamePoint+i) = pt2;
			CGPoint pt3 = [touch previousLocationInView:view];
			CGPoint pt4 = [m_touchToGame screenToGame:pt3];
			*(gamePoint2 + i) = pt4;
			
		}
		
		if (![self NNNTouchesEndedGame:touches withEvent:event view:view gamePoint:gamePoint preGamePoint:gamePoint2])
		{
			[m_general[m_gameMode] NNNTouchesEnded:touches withEvent:event view:view gamePoint:gamePoint preGamePoint:gamePoint2];
		}
		
		free(gamePoint2);
		free(gamePoint);
	}

}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view
{
}


//if proceed return YES
-(bool)NNNTouchesBeganGame:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint
{
	return NO;
}

-(bool)NNNTouchesMovedGame:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint preGamePoint:(CGPoint*)gamePoint2
{
	return NO;
}

-(bool)NNNTouchesEndedGame:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint preGamePoint:(CGPoint*)gamePoint2
{
	return NO;
}

-(bool)NNNTtouchesCancelledGame:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint
{
	return NO;
}


-(void)willRotate:(UIInterfaceOrientation)fromInterfaceOrientation to:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	if (m_changeAutoRotateMode == 2)
	{
		[self calcuNewMatrix:toInterfaceOrientation];
	}
}

-(void)onRotate:(UIInterfaceOrientation)toInterfaceOrientation from:(UIInterfaceOrientation)fromInterfaceOrientation
{
	if (m_changeAutoRotateMode == 1)
	{
		[self calcuNewMatrix:toInterfaceOrientation];
	}
//	m_interfaceOrientation = toInterfaceOrientation;
}

-(void)calcuNewMatrix:(UIInterfaceOrientation)toInterfaceOrientation
{
	
	int type = -1;
	for (int i=0;i<4;i++)
	{
		if (toInterfaceOrientation == m_rotationType[i])
		{
			type = i;
			break;
		}
	}
	
	
	CGSize screenSize = m_deviceScreenSize;
	
	if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
	{
		screenSize = m_deviceScreenSizeLandscape;
	}
	else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		screenSize = m_deviceScreenSizeLandscape;
	}
	else if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
	{

	}
	else if (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{

	}
	
	if (type != -1)
	{
		//		CGSize screenSize;
//		CGSize gameSize = CGSizeMake(700,700);
		CGRect gameAtScreen;
		gameAtScreen.origin = m_gameAtScreenPoint[type];
		gameAtScreen.size = m_gameAtScreenSize;

		float scaleFactor = [CMyMachineModel getMaxScaleFactor];
		
		[m_touchToGame setScreenSize:screenSize];
		[m_touchToGame setGameSize:m_gameSize];
		[m_touchToGame setGameAtScreen:gameAtScreen];
		[m_touchToGame setScaleFactor:scaleFactor];
		
	}
	
}

-(void)setGameAtPointAll:(CGPoint)atPoint
{
	[self setGameAtPoint:UIInterfaceOrientationLandscapeLeft atPoint:atPoint];
	[self setGameAtPoint:UIInterfaceOrientationLandscapeRight atPoint:atPoint];
	[self setGameAtPoint:UIInterfaceOrientationPortrait atPoint:atPoint];
	[self setGameAtPoint:UIInterfaceOrientationPortraitUpsideDown atPoint:atPoint];
}


-(void)setGameAtPoint:(UIInterfaceOrientation)orientation atPoint:(CGPoint)atPoint
{
	if (m_atPointNumber < 4)
	{
		m_rotationType[m_atPointNumber] = orientation;
		m_gameAtScreenPoint[m_atPointNumber] = atPoint;
		m_atPointNumber++;
	}
}

-(CGSize)getDeviceScreenSize
{
	return m_deviceScreenSize;
}

//-(void) BinaryPointerCallback:(unsigned char*)buffer size:(CGSize)size next:(int)bytesPerRow
//{
//}


-(void)dealloc
{
//    [m_capture stopCapture];

  //  free(m_captureBuffer);

//    [m_shader[0] release];
    
//    glDeleteTextures(3,&m_texture[0]);
//    glDeleteRenderbuffers(1, &m_renderBuffer);
//    glDeleteFramebuffers(1, &m_frameBuffer);
    
//    NSLog(@"called CGame dealloc");
}



@end
