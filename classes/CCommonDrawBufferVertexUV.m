//
//  CDrawBuffer.m
//  nohint
//
//  Created by たいにゃん on 12/06/21.
//
//

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import "CCommonDrawBufferVertexUV.h"

@implementation CCommonDrawBufferVertexUV

-(id)init
{
    self = [super init];
    if (self)
    {
        m_drawMode = GL_TRIANGLES;
        m_workMax = 1024;
        m_2D3D = 2;
        m_vertex = (float*)malloc(sizeof(float) * 3 * m_workMax);
        m_uv= (float*)malloc(sizeof(float) * 2 * m_workMax);
    }
    
    return self;
}

-(void)set2D3D:(int)md
{
    m_2D3D = md;
}

-(void)beginPrint:(int)md
{
    m_drawMode = md;
    m_drawNumber = 0;
    m_workMulti = 3;
    
    if (m_drawMode == GL_TRIANGLES)
    {
        m_workMulti = 3;
    }
    
    m_drawMax = m_workMax / m_workMulti;
}

-(void)beginPrint
{
    [self beginPrint:m_drawMode];
}

-(void)addTriangle:(int)n vertex:(float*)lpVertex uv:(float*)lpUV
{
    if ((m_drawNumber+n) >= m_drawMax)
    {
        [self endPrint];
        [self beginPrint];
        m_drawNumber = 0;
    }
    
    memcpy(m_vertex + m_drawNumber * m_2D3D * m_workMulti,lpVertex,n*m_2D3D*m_workMulti*sizeof(float));
    memcpy(m_uv + m_drawNumber * 2 * m_workMulti,lpUV,n*2*m_workMulti*sizeof(float));
    
    m_drawNumber += n;
}


-(void)addQuad:(float*)lpVertex uv:(float*)lpUV
{
    float vertex1[9*2];
    float uv1[6*2];
    
    memcpy(vertex1,lpVertex,sizeof(float) * m_2D3D*3);
    memcpy(uv1,lpUV,sizeof(float) * 2*3);
    
    for (int i=0;i<m_2D3D;i++)
    {
        vertex1[3*m_2D3D+i] = lpVertex[2*m_2D3D+i];
        vertex1[4*m_2D3D+i] = lpVertex[1*m_2D3D+i];
        vertex1[5*m_2D3D+i] = lpVertex[3*m_2D3D+i];
    }
    
    for (int i=0;i<2;i++)
    {
        uv1[3*2+i] = lpUV[2*2+i];
        uv1[4*2+i] = lpUV[1*2+i];
        uv1[5*2+i] = lpUV[3*2+i];
    }
    
    [self addTriangle:2 vertex:vertex1 uv:uv1];
}

-(void)blt:(CGPoint)put size:(CGSize)size src:(CGPoint)src srcSize:(CGSize)srcSize
{
	float vertex[6*2];
	float uv[6*2];
	
	float x1 = put.x;
	float y1 = put.y;
	float x2 = x1 + size.width;
	float y2 = y1 + size.height;
	
	float u1 = src.x;
	float v1 = src.y;
	float u2 = u1 + srcSize.width;
	float v2 = v1 + srcSize.height;
	
	vertex[0] = x1;
	vertex[1] = y1;
	vertex[2] = x1;
	vertex[3] = y2;
	vertex[4] = x2;
	vertex[5] = y1;

	vertex[6] = x2;
	vertex[7] = y1;
	vertex[8] = x1;
	vertex[9] = y2;
	vertex[10] = x2;
	vertex[11] = y2;
	
	uv[0] = u1;
	uv[1] = v1;
	uv[2] = u1;
	uv[3] = v2;
	uv[4] = u2;
	uv[5] = v1;
	
	uv[6] = u2;
	uv[7] = v1;
	uv[8] = u1;
	uv[9] = v2;
	uv[10] = u2;
	uv[11] = v2;


    [self addTriangle:2 vertex:vertex uv:uv];
}

-(void)turnBlt:(CGPoint)center size:(CGSize)size src:(CGPoint)src srcSize:(CGSize)srcSize angle:(float)angle
{
	float vertex[6*2];
	float uv[6*2];
	
	float dx = size.width / 2.0f;
	float dy = size.height / 2.0f;
	
	float th = angle * 3.14159f / 180.0f;
	
	float cosTh = cos(th);
	float sinTh = sin(th);
	
	float dx1 = cosTh * (-dx) - sinTh * (-dy);
	float dy1 = sinTh * (-dx) + cosTh * (-dy);
	float dx2 = cosTh * (-dx) - sinTh * dy;
	float dy2 = sinTh * (-dx) + cosTh * dy;
	float dx3 = cosTh * dx    - sinTh * dy;
	float dy3 = sinTh * dx    + cosTh * dy;
	float dx4 = cosTh * dx    - sinTh * (-dy);
	float dy4 = sinTh * dx    + cosTh * (-dy);
	
	
	float x1 = center.x + dx1;
	float y1 = center.y + dy1;
	float x2 = center.x + dx2;
	float y2 = center.y + dy2;
	float x3 = center.x + dx3;
	float y3 = center.y + dy3;
	float x4 = center.x + dx4;
	float y4 = center.y + dy4;
	
	float u1 = src.x;
	float v1 = src.y;
	float u2 = u1 + srcSize.width;
	float v2 = v1 + srcSize.height;
	
	vertex[0] = x1;
	vertex[1] = y1;
	vertex[2] = x2;
	vertex[3] = y2;
	vertex[4] = x4;
	vertex[5] = y4;
	
	vertex[6] = x4;
	vertex[7] = y4;
	vertex[8] = x2;
	vertex[9] = y2;
	vertex[10] = x3;
	vertex[11] = y3;
	
	uv[0] = u1;
	uv[1] = v1;
	uv[2] = u1;
	uv[3] = v2;
	uv[4] = u2;
	uv[5] = v1;
	
	uv[6] = u2;
	uv[7] = v1;
	uv[8] = u1;
	uv[9] = v2;
	uv[10] = u2;
	uv[11] = v2;
	
	
    [self addTriangle:2 vertex:vertex uv:uv];
}

-(void)endPrint
{
    if (m_drawNumber > 0)
    {
        
        glVertexAttribPointer(0, m_2D3D, GL_FLOAT, GL_FALSE, 0, m_vertex);
        glEnableVertexAttribArray(0);
        glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, m_uv);
        glEnableVertexAttribArray(1);
        
        glDrawArrays(m_drawMode, 0, m_drawNumber*m_workMulti);
    }
    
    m_drawNumber = 0;
}


-(void)dealloc
{
    free(m_uv);
    free(m_vertex);
}

@end
