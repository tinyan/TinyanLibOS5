//
//  myRender.h
//  gerogger
//
//  Created by たいにゃん on 10/01/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

//#import <OpenGLES/ES1/gl.h>
//#import <OpenGLES/ES1/glext.h>

@interface CMyRender : NSObject 
{
	EAGLContext *context;
	
	// The pixel dimensions of the CAEAGLLayer
	GLint backingWidth;
	GLint backingHeight;
	
	GLuint defaultFramebuffer, colorRenderbuffer;
	GLuint depthRenderbuffer;

	float m_glVersion;
	int m_bufferFlag;
	
}

-(id)initWithVersion:(float)glVersion bufferFlag:(int)bufferFlag;
-(void)createFrameBuffer:(int)bufferFlag;
-(void)createFrameBuffer2:(int)bufferFlag;

//-(GLuint)createProgramWithShaderPairName:(NSString*)shaderName;
//-(GLuint)createProgramWithShaderName:(NSString*)vertexShaderName :(NSString*)fragmentShaderName;


//- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
//-(GLuint)compileShader:(GLenum)type file:(NSString *)file;


//- (BOOL)linkProgram:(GLuint)prog vertexShader:(GLuint)vertexShader fragmentShader:(GLuint)fragmentShader;

//- (BOOL)validateProgram:(GLuint)prog;


- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;
-(void)beginRender;
-(void)endRender;

-(void)SetDefaultFrameBuffer;



@end
