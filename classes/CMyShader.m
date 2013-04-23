//
//  CMyShader.m
//  TinyanLib
//
//  Created by たいにゃん on 10/08/31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CMyShader.h"


@implementation CMyShader


-(id)initWithPairName:(NSString*)shaderName
{
	if (self = [super init])
	{
		[self createProgramWithShaderName:shaderName :shaderName];
	}

	return self;
}

-(id)initWithShaderName:(NSString*)vertexShaderName :(NSString*)fragmentShaderName
{
	if (self = [super init])
	{
		[self createProgramWithShaderName:vertexShaderName :fragmentShaderName];
	}
	
	return self;
}


-(GLuint)getProgram
{
	return m_program;
}


-(GLuint)createProgramWithShaderName:(NSString*)vertexShaderName :(NSString*)fragmentShaderName
{
    m_vertexShaderName = vertexShaderName;
    m_fragmentShaderName = fragmentShaderName;
    
    NSString* vertShaderPathname;
    NSString* fragShaderPathname;
	
    m_program = glCreateProgram();
	if (m_program == 0)
    {
        NSLog(@"Failed create program error");
        return 0;
    }
	
	
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:vertexShaderName ofType:@"vsh"];
	m_vertexShader = [self compileShader:GL_VERTEX_SHADER file:vertShaderPathname];
	if (m_vertexShader == 0)
    {
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }
	
	
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:fragmentShaderName ofType:@"fsh"];
	m_fragmentShader = [self compileShader:GL_FRAGMENT_SHADER file:fragShaderPathname];
	if (m_fragmentShader == 0)
    {
		glDeleteShader(m_vertexShader);
		
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
    }
	
   
    // Attach vertex shader to program
    glAttachShader(m_program, m_vertexShader);
	
    // Attach fragment shader to program
    glAttachShader(m_program, m_fragmentShader);
	
//	glDeleteShader(m_vertexShader);
//	glDeleteShader(m_fragmentShader);
	
	
	
	/*
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
	*/
	
	return m_program;
}


-(GLuint)compileShader:(GLenum)type file:(NSString *)file;
//- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
	GLuint shader;
	
	//NSStringEncoding encoding;
//	NSError* error;
	NSString* str = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    source = (GLchar *)[str UTF8String];
//    source = (GLchar *)[[NSString stringWithContentsOfFile:file usedEncoding:&encoding error:nil] UTF8String];
    //source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSASCIIStringEncoding  error:nil] UTF8String];

	/*
	const char* filename = [file UTF8String];
	FILE* files = fopen(filename,"rb");
	if (files != NULL)
	{
		fseek(files,0,SEEK_END);
		int ln = ftell(files);
		fseek(files,0,SEEK_SET);
		source = (GLchar*)malloc(ln+1);
		fread(source,sizeof(char),ln,files);
		fclose(files);
		source[ln] = 0;
		NSLog(@"open file start size=%d %s",ln,filename);
	}
	else 
	{
		NSLog(@"open error %s",filename);
	}
*/
	
	
	
    if (!source)
    {
        NSLog(@"Failed to load shader");
        return 0;
    }

//	NSLog(@"source size = %d %s",strlen(source),source);
	
//	NSLog(@"encode = %d",encoding);
	
	
    shader = glCreateShader(type);
	if (shader == 0) return 0;

//	int ln = strlen(source) + 1;
    glShaderSource(shader, 1, &source, NULL);
	

    glCompileShader(shader);

//	free(source);
	
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
		
		GLint infoLen = 0;
		glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &infoLen);
		if (infoLen > 0)
		{
			char* infoLog = malloc(sizeof(char) * infoLen);
			glGetShaderInfoLog(shader, infoLen, NULL,infoLog);
			NSLog(@"Error compile shader:\n%s", infoLog);
			free(infoLog);
			
		}
		
		
		
        glDeleteShader(shader);
        return 0;
    }
	
    return shader;
}

- (GLuint)linkProgram;
{
    GLint status;
	
    glLinkProgram(m_program);
	
#if defined(DEBUG)
    /*
    GLint logLength;
    glGetProgramiv(m_program, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
     */
    
#endif
	
    glGetProgramiv(m_program, GL_LINK_STATUS, &status);
    if (status == 0)
        return 0;
	
    return m_program;
}

-(GLint)AddBindAttribLocation:(char*)name
{
    GLint prg = [self getProgram];
    if (prg < 0) return -1;
    
    glBindAttribLocation(prg, m_bindAttribLocationNumber, name);
    
    GLint k = m_bindAttribLocationNumber;
    m_bindAttribLocationNumber++;
    
    return k;
}

-(GLint)AddTextureUniformLocation:(char*)name
{
    if (m_textureUniformNumber >= 64) return -1;
    GLint prg = [self getProgram];
    if (prg < 0) return -1;
    
    GLint n = glGetUniformLocation(prg, name);
   // NSLog(@"uni:%d",n);
    if (n<0)
    {
        [self printErrorUniformLocation:name];
    
        return -1;
    }
    
    m_textureUniformData[m_textureUniformNumber] = n;
    GLint k = m_textureUniformNumber;
    m_textureUniformNumber++;
    
    return k;
}

-(GLint)AddFloatUniformLocation:(char*)name
{
    if (m_floatUniformNumber >= 64) return -1;
    GLint prg = [self getProgram];
    if (prg < 0) return -1;
    
    GLint n = glGetUniformLocation(prg, name);
    if (n<0)
    {
        [self printErrorUniformLocation:name];
        
        return -1;
    }
    
    m_floatUniformData[m_floatUniformNumber] = n;
    GLint k = m_floatUniformNumber;
    m_floatUniformNumber++;
    
    return k;
}

-(GLint)AddVectorUniformLocation:(char*)name
{
    if (m_vectorUniformNumber >= 64) return -1;
    if (m_vectorUniformNumber >= 64) return -1;
    GLint prg = [self getProgram];
    if (prg < 0) return -1;
    
    GLint n = glGetUniformLocation(prg, name);
    if (n<0)
    {
        [self printErrorUniformLocation:name];
        
        return -1;
    }
    
    m_vectorUniformData[m_vectorUniformNumber] = n;
    GLint k = m_vectorUniformNumber;
    m_vectorUniformNumber++;
    
    return k;
}

-(GLint)AddMatrixUniformLocation:(char*)name
{
    if (m_matrixUniformNumber >= 64) return -1;
    if (m_matrixUniformNumber >= 64) return -1;
    GLint prg = [self getProgram];
    if (prg < 0) return -1;
    
    GLint n = glGetUniformLocation(prg, name);
    if (n<0)
    {
        [self printErrorUniformLocation:name];
        
        return -1;
    }
    
    m_matrixUniformData[m_matrixUniformNumber] = n;
    GLint k = m_matrixUniformNumber;
    m_matrixUniformNumber++;
    
    return k;
}

-(GLint)getTextureUniformNumber:(int)n
{
    if ((n<0) || (n>=m_textureUniformNumber)) return 0;
    return m_textureUniformData[n];
}

-(GLint)getFloatUniformNumber:(int)n
{
    if ((n<0) || (n>=m_floatUniformNumber)) return 0;
    return m_floatUniformData[n];
}

-(GLint)getVectorUniformNumber:(int)n
{
    if ((n<0) || (n>=m_vectorUniformNumber)) return 0;
    return m_vectorUniformData[n];
}

-(GLint)getMatrixUniformNumber:(int)n
{
    if ((n<0) || (n>=m_matrixUniformNumber)) return 0;
    return m_matrixUniformData[n];
    
}


-(bool)useProgram
{
    int prg = [self getProgram];
    if (prg < 0) return NO;
    
    glUseProgram(prg);
    return YES;
}

-(bool)setMatrix:(GLfloat*)mat
{
    return [self setMatrix:0 mat:mat];
}

-(bool)setMatrix:(int)n mat:(GLfloat*)mat
{
    if (n >= m_matrixUniformNumber) return NO;
    GLuint u = [self getMatrixUniformNumber:n];
    glUniformMatrix4fv(u,  1, GL_FALSE, mat);
    return YES;
}

-(bool)setFloat:(GLfloat)f
{
    return [self setFloat:0 f:f];
}

-(bool)setFloat:(int)n f:(GLfloat)f
{
    if (n >= m_floatUniformNumber) return NO;
    GLuint u = [self getFloatUniformNumber:n];
    glUniform1f(u,f);
    return YES;
}

-(bool)setVector3:(GLfloat*)vec3
{
    return [self setVector3:0 vec3:vec3];
}

-(bool)setVector3:(int)n vec3:(GLfloat*)vec3
{
    if (n >= m_vectorUniformNumber) return NO;
   
    GLuint u = [self getVectorUniformNumber:n];
    glUniform3fv (u, 1, vec3);
    return YES;
}

-(bool)setVector4:(GLfloat*)vec4
{
    return [self setVector4:0 vec4:vec4];
}

-(bool)setVector4:(int)n vec4:(GLfloat*)vec4
{
    if (n >= m_vectorUniformNumber) return NO;
    
    GLuint u = [self getVectorUniformNumber:n];
    glUniform4fv (u, 1, vec4);
    return YES;
}

-(bool)setTexture:(int)tex
{
    return [self setTexture:0 tex:tex];
}

-(bool)setTexture:(int)n tex:(int)tex
{
    if (n >= m_textureUniformNumber) return NO;
    
    GLuint u = [self getTextureUniformNumber:n];
    glUniform1i (u, tex);
    return YES;
    
}


-(void)printErrorUniformLocation:(char*) name
{
    NSLog(@"name:%@ not found in %@ %@",[NSString stringWithUTF8String:name], m_vertexShaderName ,m_fragmentShaderName);
}

-(void)dealloc
{
	
	if (m_fragmentShader != 0)
	{
		glDeleteShader(m_fragmentShader);
	}
	
	if (m_vertexShader != 0)
	{
		glDeleteShader(m_vertexShader);
	}

	if (m_program != 0)
	{
		glDeleteProgram(m_program);
	}

//	[super dealloc];
}
	
@end
