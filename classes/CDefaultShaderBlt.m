//
//  CShaderBlt.m
//  katanuki
//
//  Created by たいにゃん on 2014/01/09.
//  Copyright (c) 2014年 bugnekosoft. All rights reserved.
//

#import "CDefaultShaderBlt.h"

@implementation CDefaultShaderBlt

static char vshader[] =
"attribute vec4 a_position;"
"attribute vec2 a_textureCoord;"
"uniform mat4 u_matrix;"
"varying vec2 v_textureCoord;"
"void main()"
"{"
"	v_textureCoord = a_textureCoord;"
"	gl_Position = u_matrix * a_position;"
"}"
;



static char fshader[]=
"precision mediump float;"
"varying vec2 v_textureCoord;"
"uniform sampler2D s_texture;"
//"uniform vec4 u_color;"


"void main()"
"{"
"	vec4 col = texture2D(s_texture,v_textureCoord);"
//"	col.r = 1.0;"
//"	col.a = 1.0;"
"    gl_FragColor = col;"
"}"
;

-(id)init
{
	self = [super initWithShaderNumber:0 vshader:vshader fshader:fshader];
	if (self)
	{
		
		
		[self AddBindAttribLocation:"a_position"];
		[self AddBindAttribLocation:"a_textureCoord"];
		[self linkProgram];
		[self AddMatrixUniformLocation:"u_matrix"];
		//		[self AddVectorUniformLocation:"u_color"];
		[self AddTextureUniformLocation:"s_texture"];
		
	}
	
	return self;
}


-(void)afterProgram
{
	//	glEnable(GL_TEXTURE_2D);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
}

@end
