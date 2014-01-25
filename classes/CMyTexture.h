//
//  CMyTexture.h
//  TinyanGraphicsFramework
//
//  Created by たいにゃん on 09/10/29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>


//#import <zlib.h>

//#import <OpenGLES/ES2/gl.h>
//#import <OpenGLES/ES2/glext.h>




@interface CMyTexture : NSObject 
{
	int m_textureSize;
	GLuint m_textureNumber;
	
	float m_divmulX;
	float m_divmulY;
	
	GLenum m_format;
	CGSize m_screenSize;
}

+(void)setGLVersion:(float)ver;

-(id)initBySize:(int)size;
-(id)initBySize:(int)sizeX :(int)sizeY;
-(id)initByPVR:(char*)filename;

-(int)LoadDDSZ:(char*)filename;
-(int)LoadDDSZ:(char*)filename atPoint:(CGPoint)setPoint;
-(int)LoadDDSZ:(char*)filename dir:(char*)dir;
-(int)LoadDDSZ:(char*)filename atPoint:(CGPoint)setPoint dir:(char*)dir;
-(int)LoadMipmapDDSZ:(char*)filename;

-(int)LoadDDS:(char*)filename;
-(int)LoadDDS:(char*)filename atPoint:(CGPoint)setPoint;

-(int)LoadPng:(char*)filename;
-(int)LoadPng:(char*)filename atPoint:(CGPoint)setPoint;
-(int)fromImage:(UIImage*)image atPoint:(CGPoint)setPoint;
-(int)LoadPngAutoMask:(char*)filename atPoint:(CGPoint)setPoint maskColor:(int)maskColor;


-(int)LoadPngRoutine:(char*)filename atPoint:(CGPoint)setPoint maskFlag:(BOOL)maskFlag maskColor:(int)maskColor;
-(int)fromImageRoutine:(UIImage*)image atPoint:(CGPoint)setPoint maskFlag:(BOOL)maskFlag maskColor:(int)maskColor;


-(void)replaceRect:(CGRect)rect data:(void*)data;
-(GLfloat)x2u:(int)x;
-(GLfloat)y2v:(int)y;
-(CGPoint) xy2uv:(CGPoint)pt;

-(void)bindTexture;
-(void)bindTexture:(int)n;
-(void)activeTexture;
-(void)activeTexture:(int)n;
-(GLuint)getTextureNumber;

-(void)setScreenSize:(CGSize)size;

-(void)stretchBlt:(CGPoint)dst src:(CGPoint)src size:(CGSize)size srcSize:(CGSize)srcSize;
-(void)polygon:(int)n vertex:(float*)vertex tex:(float*)tex;


-(void)dealloc;

@end
