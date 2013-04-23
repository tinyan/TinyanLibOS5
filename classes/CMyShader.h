//
//  CMyShader.h
//  TinyanLib
//
//  Created by たいにゃん on 10/08/31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>

//#import <OpenGLES/ES1/gl.h>
//#import <OpenGLES/ES1/glext.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>


@interface CMyShader : NSObject 
{
	GLuint m_program;
	GLuint m_vertexShader;
	GLuint m_fragmentShader;
    int m_textureUniformNumber;
    int m_floatUniformNumber;
    int m_vectorUniformNumber;
    int m_matrixUniformNumber;
    GLuint m_textureUniformData[64];
    GLuint m_floatUniformData[64];
    GLuint m_vectorUniformData[64];
    GLuint m_matrixUniformData[64];
    NSString* m_vertexShaderName;
    NSString* m_fragmentShaderName;
    int m_bindAttribLocationNumber;
    
}

-(id)initWithShaderName:(NSString*)vertexShaderName :(NSString*)fragmentShaderName;
-(id)initWithPairName:(NSString*)shaderName;
-(GLuint)getProgram;
-(GLuint)linkProgram;

//
-(GLuint)compileShader:(GLenum)type file:(NSString *)file;
-(GLuint)createProgramWithShaderName:(NSString*)vertexShaderName :(NSString*)fragmentShaderName;

-(GLint)AddBindAttribLocation:(char*)name;

-(GLint)AddTextureUniformLocation:(char*)name;
-(GLint)AddFloatUniformLocation:(char*)name;
-(GLint)AddVectorUniformLocation:(char*)name;
-(GLint)AddMatrixUniformLocation:(char*)name;

-(GLint)getTextureUniformNumber:(int)n;
-(GLint)getFloatUniformNumber:(int)n;
-(GLint)getVectorUniformNumber:(int)n;
-(GLint)getMatrixUniformNumber:(int)n;

-(bool)useProgram;

-(bool)setMatrix:(GLfloat*)mat;
-(bool)setMatrix:(int)n mat:(GLfloat*)mat;
-(bool)setFloat:(GLfloat)f;
-(bool)setFloat:(int)n f:(GLfloat)f;
-(bool)setVector3:(GLfloat*)vec3;
-(bool)setVector3:(int)n vec3:(GLfloat*)vec3;
-(bool)setVector4:(GLfloat*)vec4;
-(bool)setVector4:(int)n vec4:(GLfloat*)vec4;
-(bool)setTexture:(int)tex;
-(bool)setTexture:(int)n tex:(int)tex;



-(void)printErrorUniformLocation:(char*) name;




@end
