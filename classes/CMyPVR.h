//
//  CMyPVR.h
//  TinyanLib
//
//  Created by たいにゃん on 10/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>


@interface CMyPVR : NSObject 
{

	int m_bufferSize;
	int m_bufferSizeMax;
	unsigned char* m_buffer;
	unsigned char* m_header;
	
	BOOL m_dataExistFlag;
	
	int m_surfaceKosuu;
	
	GLuint m_width;
	GLuint m_height;
	GLenum m_format;
	BOOL m_alfaExistFlag;

	
	int* m_offset;
	GLuint* m_size;
	
}

-(id)init;

-(BOOL)loadPVR:(char *)filenameonly;
-(BOOL)setTexture:(GLuint)texture;
-(BOOL)setNoMipmapTexture:(GLuint)texture;

-(int)getSize;



		
-(void)dealloc;

@end
