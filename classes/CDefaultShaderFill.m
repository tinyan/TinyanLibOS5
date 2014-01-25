//
//  CShaderFill.m
//  katanuki
//
//  Created by たいにゃん on 2014/01/09.
//  Copyright (c) 2014年 bugnekosoft. All rights reserved.
//

#import "CDefaultShaderFill.h"

@implementation CDefaultShaderFill



static char vshader[] =
"attribute vec4 a_position;"
"uniform mat4 u_matrix;"
"void main()"
"{"
"	gl_Position = u_matrix * a_position;"
"}"
;


static char fshader[]=
"precision mediump float;"
"uniform vec4 u_color;"
"void main()"
"{"
"    gl_FragColor = u_color;"
"}"
;


-(id)init
{
	self = [super initWithShaderNumber:0 vshader:vshader fshader:fshader];
	if (self)
	{
		[self AddBindAttribLocation:"a_position"];
		[self linkProgram];
		[self AddMatrixUniformLocation:"u_matrix"];
		[self AddVectorUniformLocation:"u_color"];
		
	}
	
	return self;
}

-(void)afterProgram
{
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
}
@end
