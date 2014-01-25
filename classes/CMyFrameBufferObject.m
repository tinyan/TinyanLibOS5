//
//  CMyFrameBufferObject.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/11/29.
//
//

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

#import "CMyFrameBufferObject.h"




@implementation CMyFrameBufferObject

-(id)initWithSize:(CGSize)size
{
	self = [super init];
	if (self)
	{
		m_textureCreateFlag = YES;
		glGenTextures(1,&m_texture);
		m_size = size;
		[self createFBO];
	}
	
	return self;
}

-(id)initWithTextureAndSize:(GLuint)texture size:(CGSize)size
{
	self = [super init];
	if (self)
	{
		m_texture = texture;
		m_size = size;
		[self createFBO];
	}
	
	return self;
}

-(void)createFBO
{
	GLuint width  = (GLuint)m_size.width;
	GLuint height = (GLuint)m_size.height;
		
	GLint old;
	glGetIntegerv(GL_FRAMEBUFFER_BINDING,&old);
		
	glGenFramebuffers(1,&m_frameBufferObject);
	glBindFramebuffer(GL_FRAMEBUFFER,m_frameBufferObject);
		
//		glGenTextures(1,&m_texture);
	glBindTexture(GL_TEXTURE_2D,m_texture);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height,0,GL_RGBA,GL_UNSIGNED_BYTE,NULL);
	glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, m_texture, 0);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		
	glGenRenderbuffers(1, &m_depth);
	glBindRenderbuffer(1,m_depth);
		
	glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, width,height);
	glFramebufferRenderbuffer(GL_FRAMEBUFFER,  GL_DEPTH_ATTACHMENT,GL_RENDERBUFFER,m_depth);
		
		
		//	glBindTexture(GL_TEXTURE_2D,m_texture);
		//	glTexImage2D(GL_TEXTURE_2D, 0, GL_DEPTH_COMPONENT, width, height,0,GL_DEPTH_COMPONENT,GL_UNSIGNED_SHORT,NULL);
		//	glFramebufferTexture2D(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_TEXTURE_2D, m_depth, 0);
		//	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
		//	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
		//	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		//	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		
	if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
	{
		NSLog(@"**************************");
		NSLog(@" framebuffer create error");
	}
		
	glBindFramebuffer(GL_FRAMEBUFFER,old);
}



-(void)BeginRender
{
	glGetIntegerv(GL_FRAMEBUFFER_BINDING, &m_oldFrameBufferObject);
	glBindFramebuffer(GL_FRAMEBUFFER, m_frameBufferObject);
	
	GLuint width  = (GLuint)m_size.width;
	GLuint height = (GLuint)m_size.height;
	
	glViewport(0,0,width,height);
}


-(void)EndRender
{
	if (m_oldFrameBufferObject != 0)
	{
		glBindFramebuffer(GL_FRAMEBUFFER,m_oldFrameBufferObject);
		
		m_oldFrameBufferObject = 0;
	}
}


-(GLuint)GetFramebufferTexture
{
	return m_texture;
}


-(void)dealloc
{
	//youjin
	if (m_oldFrameBufferObject != 0)
	{
		glBindFramebuffer(GL_FRAMEBUFFER,m_oldFrameBufferObject);
		m_oldFrameBufferObject = 0;
	}
	
	if (m_depth != 0)
	{
		glDeleteRenderbuffers(1,&m_depth);
		m_depth = 0;
	}
	

	if (m_textureCreateFlag)
	{
		if (m_texture != 0)
		{
			glDeleteBuffers(1,&m_texture);
			m_texture = 0;
		}
		m_textureCreateFlag = NO;
	}
	
	if (m_frameBufferObject != 0)
	{
		glDeleteFramebuffers(1, &m_frameBufferObject);
		m_frameBufferObject = 0;
	}
}



@end
