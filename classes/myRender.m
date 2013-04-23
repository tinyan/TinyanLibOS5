//
//  myRender.m
//  gerogger
//
//  Created by たいにゃん on 10/01/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "myRender.h"
#import "CMyTexture.h"


@implementation CMyRender

-(id)initWithVersion:(float)glVersion bufferFlag:(int)bufferFlag
{
	m_glVersion = glVersion;
	m_bufferFlag = bufferFlag;
	
	if (self = [super init])
	{
		[CMyTexture setGLVersion:glVersion];
		
		if (glVersion >= 2.0)
		{
	//		NSLog(@"ccc");
			context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
			
			
	//		if (!context || ![EAGLContext setCurrentContext:context] || ![self loadShaders])
			if (!context || ![EAGLContext setCurrentContext:context])
			{
//				[self release];
				return nil;
			}
			
		//	NSLog(@"aaa");
			[self createFrameBuffer2:bufferFlag];
		//	NSLog(@"bbb");
		}
		else 
		{
			context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
			
			if (!context || ![EAGLContext setCurrentContext:context])
			{
				NSLog(@"Render init:setCurrentContext Error");
//				[self release];
				return nil;
			}
		
			[self createFrameBuffer:bufferFlag];
		}
		
//		float sf = context.contentScaleFactor;
//		NSLog(@"scale factor = %d",(int)(sf*100));
		
	}
	
	return self;
	
}

/*
-(void)fuqueRenderBuffer
{
	glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
	glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
}
*/

-(void)createFrameBuffer2:(int)bufferFlag
{
	if ((bufferFlag & 1) == 0)
	{
		glGenFramebuffers(1, &defaultFramebuffer);
		glGenRenderbuffers(1, &colorRenderbuffer);
		
		glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
		glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
		
		glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
	}
	else 
	{
		glGenFramebuffers(1, &defaultFramebuffer);
		glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
		
		glGenRenderbuffers(1, &colorRenderbuffer);
		glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
		glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
		
		glGenRenderbuffers(1, &depthRenderbuffer);
		glBindRenderbuffer(GL_RENDERBUFFER, depthRenderbuffer);
		glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthRenderbuffer);

	}
}

-(void)createFrameBuffer:(int)bufferFlag
{
	CGRect rc = [UIScreen mainScreen].bounds;
	int screenSizeX = rc.size.width;
	int screenSizeY = rc.size.height;
	
	if ((bufferFlag & 1) == 0)
	{
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
	}
	else 
	{
		// Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		glGenRenderbuffersOES(1,&depthRenderbuffer);
		
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
		
		glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_RGBA8_OES, screenSizeX,screenSizeY);
		glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, screenSizeX,screenSizeY);
		
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
	}
}
/*
-(GLuint)createProgramWithShaderPairName:(NSString*)shaderName
{
	return [self createProgramWithShaderName:vertexShaderName :fragmentShaderName];
}

-(GLuint)createProgramWithShaderName:(NSString*)vertexShaderName :(NSString*)fragmentShaderName
{
    NSString* vertShaderPathname;
    NSString* fragShaderPathname;
	GLuint vertexShader;
	GLuint fragmentShader;
	
    GLuint program = glCreateProgram();
	if (program == 0) return 0;
	
	
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:vertexShaderName ofType:@"vsh"];
	vertexShader = [self compileShader:GL_VERTEX_SHADER file:vertShaderPathname];
	if (vertexShader == 0)
    {
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }
	
    // Create and compile fragment shader
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:fragmentShaderName ofType:@"fsh"];
	fragmentShader = [self compileShader:GL_FRAGMENT_SHADER file:fragShaderPathname];
	if (fragmentShader == 0)
    {
		glDeleteShader(vertexShader);
		
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
    }
	
    // Attach vertex shader to program
    glAttachShader(program, vertexShader);
	
    // Attach fragment shader to program
    glAttachShader(program, fragmentShader);
	
    // Bind attribute locations
    // this needs to be done prior to linking
    glBindAttribLocation(program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(program, ATTRIB_COLOR, "color");
	
    // Link program
    if (![self linkProgram:program])
    {
        NSLog(@"Failed to link program: %d", program);
		
        if (vertShader)
        {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader)
        {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (program)
        {
            glDeleteProgram(program);
            program = 0;
        }
        
        return FALSE;
    }
	
    // Get uniform locations
    uniforms[UNIFORM_TRANSLATE] = glGetUniformLocation(program, "translate");
	
    // Release vertex and fragment shaders
    if (vertShader)
        glDeleteShader(vertShader);
    if (fragShader)
        glDeleteShader(fragShader);
	
	
}


-(GLuint)compileShader:(GLenum)type file:(NSString *)file;
//- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
	
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return 0;
    }
	
    GLuint shader = glCreateShader(type);
	if (shader == 0) return 0;
	
    glShaderSource(shader, 1, &source, NULL);
    glCompileShader(shader);
	
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
	
    glGetShaderiv(shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
    {
        glDeleteShader(shader);
        return 0;
    }
	
    return shader;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
	
    glLinkProgram(prog);
	
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
	
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0)
        return FALSE;
	
    return TRUE;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
	
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
	
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0)
        return FALSE;
	
    return TRUE;
}
*/

/*
- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
	
    // Create shader program
    program = glCreateProgram();
	
    // Create and compile vertex shader
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
    {
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }
	
    // Create and compile fragment shader
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])
    {
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
    }
	
    // Attach vertex shader to program
    glAttachShader(program, vertShader);
	
    // Attach fragment shader to program
    glAttachShader(program, fragShader);
	
    // Bind attribute locations
    // this needs to be done prior to linking
    glBindAttribLocation(program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(program, ATTRIB_COLOR, "color");
	
    // Link program
    if (![self linkProgram:program])
    {
        NSLog(@"Failed to link program: %d", program);
		
        if (vertShader)
        {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader)
        {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (program)
        {
            glDeleteProgram(program);
            program = 0;
        }
        
        return FALSE;
    }
	
    // Get uniform locations
    uniforms[UNIFORM_TRANSLATE] = glGetUniformLocation(program, "translate");
	
    // Release vertex and fragment shaders
    if (vertShader)
        glDeleteShader(vertShader);
    if (fragShader)
        glDeleteShader(fragShader);
	
    return TRUE;
}

*/

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer
{	
	if (m_glVersion < 2.0)
	{
		// Allocate color buffer backing based on the current layer size
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
		glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
		glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
		if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
		{
			NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
			return NO;
		}
	}
	else 
	{
		// Allocate color buffer backing based on the current layer size
		glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
		[context renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
		glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
		glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
		
		if ((m_bufferFlag & 1) == 1)
		{
			glBindRenderbuffer(GL_RENDERBUFFER, depthRenderbuffer);
			glRenderbufferStorage(GL_RENDERBUFFER,GL_DEPTH_COMPONENT16,backingWidth,backingHeight);
			
		}
		
		
		if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
		{
			NSLog(@"GL2.0 Failed to make complete framebuffer object %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
			return NO;
		}
		
	}
    
    return YES;
}

-(void)SetDefaultFrameBuffer
{
	if ((m_bufferFlag & 1) == 0)
	{
//		glGenFramebuffers(1, &defaultFramebuffer);
//		glGenRenderbuffers(1, &colorRenderbuffer);
		
//		glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
//		glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
		
//		glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
	}
	else 
	{
//		glGenFramebuffers(1, &defaultFramebuffer);
//		glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
		
//		glGenRenderbuffers(1, &colorRenderbuffer);
//		glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
//		glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
		
//		glGenRenderbuffers(1, &depthRenderbuffer);
//		glBindRenderbuffer(GL_RENDERBUFFER, depthRenderbuffer);
//		glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthRenderbuffer);
		
	}
	
	
	glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
}

-(void)beginRender
{
	// This application only creates a single context which is already set current at this point.
	// This call is redundant, but needed if dealing with multiple contexts.
    [EAGLContext setCurrentContext:context];
    
	// This application only creates a single default framebuffer which is already bound at this point.
	// This call is redundant, but needed if dealing with multiple framebuffers.
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
    glViewport(0, 0, backingWidth, backingHeight);
}

-(void)endRender
{
	// This application only creates a single color renderbuffer which is already bound at this point.
	// This call is redundant, but needed if dealing with multiple renderbuffers.
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

-(void)dealloc
{
	if (defaultFramebuffer)
	{
		glDeleteFramebuffersOES(1, &defaultFramebuffer);
		defaultFramebuffer = 0;
	}
	
	if (colorRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &colorRenderbuffer);
		colorRenderbuffer = 0;
	}
	
	// Tear down context
	if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
//	[context release];
//	context = nil;
	
//	[super dealloc];
	
}

@end
