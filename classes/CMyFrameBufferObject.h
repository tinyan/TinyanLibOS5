//
//  CMyFrameBufferObject.h
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/11/29.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CMyFrameBufferObject : NSObject
{
	CGSize m_size;
	GLint m_oldFrameBufferObject;
	GLuint m_frameBufferObject;
	GLuint m_texture;
	GLuint m_depth;
	BOOL m_textureCreateFlag;
}

-(id)initWithSize:(CGSize)size;
-(id)initWithTextureAndSize:(GLuint)texture size:(CGSize)size;

-(void)BeginRender;
-(void)EndRender;
-(GLuint)GetFramebufferTexture;

-(void)createFBO;

@end
