//
//  CGame.m
//  comike2011win
//
//  Created by 山口 慎治 on 12/01/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//#import "CPutBuffer.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import <sys/utsname.h>



#import "../../TinyanLibOS5/classes/CMyShader.h"



#import "../../TinyanLibOS5/classes/CCommonGeneral.h"
//#import "CTitle.h"
//#import "CPlay.h"


#import "../../TinyanLibOS5/classes/CCommonGame.h"
#import "CGame.h"




@implementation CGame

-(id)init
{
    self = [super init];
    if (self)
    {
		struct utsname u;
        uname(&u);
        NSLog(@"machine = %s",u.machine);        
        
        GLint maxsize;
        glGetIntegerv(GL_MAX_RENDERBUFFER_SIZE,&maxsize);
        NSLog(@"max render size = %d",maxsize);

//        glGenFramebuffers(1,&m_frameBuffer);
//        glGenRenderbuffers(1, &m_renderBuffer);
//        glGenTextures(3,m_texture);

//        NSLog(@"frameBufNum=%d rendBufNum=%d",m_frameBuffer,m_renderBuffer);
        
//        m_captureBuffer = (char*)malloc(1024*1024*4);
//        memset(m_captureBuffer, 0, 1024*1024*4);
        
//        glEnable(GL_TEXTURE_2D);
//        NSLog(@"forst enable error=%d",glGetError());
//        glActiveTexture(GL_TEXTURE0);
//        NSLog(@"forst active error=%d",glGetError());
//        for (int i=0;i<3;i++)
//        {
//            glActiveTexture(GL_TEXTURE0);
//            glBindTexture(GL_TEXTURE_2D, m_texture[i]);
//            NSLog(@"tex error=%d",glGetError());
//            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 1024, 1024, 0, GL_RGBA, GL_UNSIGNED_BYTE, m_captureBuffer);
//            NSLog(@"tex error=%d",glGetError());
//            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
//            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
            
//        }
        
//        glBindRenderbuffer(GL_RENDERBUFFER, m_renderBuffer);
//        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, 1024, 1024);
        

 //       m_drawBuffer = [[CDrawBuffer alloc] init];
        
		m_texture = [[CMyTexture alloc]initBySize:1024];
		[m_texture LoadDDSZ:"cm1"];

//        m_touchToGame = [[CTouchToGame alloc] init];
//		[m_touchToGame setScreenSize:CGSizeMake(1024,768)];
//		[m_touchToGame setGameSize:CGSizeMake(1000,700)];
//		[m_touchToGame setGameAtScreenAspect];
		
		
        
        
        
//        m_general[TITLE_MODE] = [[CTitle alloc ]init:self];
//        m_general[PLAY_MODE] = [[CPlay alloc ]init:self];
        
//        m_gameMode = TITLE_MODE;
//        [m_general[m_gameMode] Init];
        
//        m_capture = [[CMyCapture alloc] initWithCallback:self];
//        [m_capture changeMode:MYCAPTURE_POINTER_MODE];
//        [m_capture changeConfig:5];//5:1280x720

//        [m_capture startCapture];
        
//        m_putBuffer = [[CPutBuffer alloc] init];
//        m_general[1] = [[CTitle alloc] initWithCGame:self];
    }
    
    
    return self;
}

-(void)createMyShader
{
	
    m_shader[0] = [[CMyShader alloc]initWithPairName:@"Shader"];
    [m_shader[0] AddBindAttribLocation:"a_position"];
    [m_shader[0] AddBindAttribLocation:"a_texCoord"];
    [m_shader[0] linkProgram];
	[m_shader[0] AddTextureUniformLocation:"s_texture"];
	[m_shader[0] AddMatrixUniformLocation:"u_matrix"];
	
    m_shader[1] = [[CMyShader alloc]initWithPairName:@"ColorShader"];
    [m_shader[1] AddBindAttribLocation:"a_position"];
    [m_shader[1] linkProgram];
	[m_shader[1] AddVectorUniformLocation:"u_color"];
	[m_shader[1] AddMatrixUniformLocation:"u_matrix"];
     
//    u_matrix = glGetUniformLocation(prg,"u_matrix");
    
//    NSLog(@"shader0 tex:%d mat:%d",s_texture,u_matrix);
    
//    m_shader[1] = [[CMyShader alloc]initWithPairName:@"maxShader"];
//	prg = [m_shader[1] getProgram];
//    glBindAttribLocation(prg, 0, "a_positonm");
//    glBindAttribLocation(prg, 1, "a_texCoordm");
//    [m_shader[1] linkProgram];
//    s_texture0 = glGetUniformLocation(prg,"s_texture0");
//    s_texture1 = glGetUniformLocation(prg,"s_texture1");
//    u_matrixm = glGetUniformLocation(prg,"u_matrixm");

//    NSLog(@"shader1 tex:%d tex:%d mat:%d",s_texture0,s_texture1,u_matrixm);
    
}

//-(CMyTexture*)getMyTexture:(int)n
//{
//    return m_texture;
//}


-(CDrawBuffer*)getDrawBuffer
{
    return m_drawBuffer;
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
    
    NSLog(@"called CGame dealloc");
}



@end
