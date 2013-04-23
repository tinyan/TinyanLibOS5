//
//  CMyBoxUV.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/01/04.
//
//

#import "CMyBoxUV.h"

@implementation CMyBoxUV


-(id)initByMax:(int)n textureSize:(int)textureSize
{
	self = [super init];
	if (self)
	{
		m_partsMax = n;
		m_textureSizeX = (float)textureSize;
		m_textureSizeY = (float)textureSize;
		m_uv = (float*)malloc(n * sizeof(float) * 3 * 2 * 2);
		m_org = (CGRect*)malloc(n * sizeof(CGRect));
		m_rect = (CGRect*)malloc(n * sizeof(CGRect));
	}
	
	return self;
}

-(BOOL)SetUV:(int)n point:(CGPoint)point size:(CGSize)size
{
	if ((n>=0) || (n<m_partsMax))
	{
		m_org[n] = CGRectMake(point.x,point.y,size.width,size.height);
		float mulDivX = 1.0f / m_textureSizeX;
		float mulDivY = 1.0f / m_textureSizeY;
		
		float x1 = point.x * mulDivX;
		float y1 = point.y * mulDivY;
		float x2 = (point.x + size.width) * mulDivX;
		float y2 = (point.y + size.height) * mulDivY;
		
		m_rect[n] = CGRectMake(x1,y1,x2-x1,y2-y1);
		
		float* dst = [self GetUVPointer:n];
		dst[0] = x1;
		dst[1] = y1;
		dst[2] = x1;
		dst[3] = y2;
		dst[4] = x2;
		dst[5] = y1;
		
		dst[6] = x2;
		dst[7] = y1;
		dst[8] = x1;
		dst[9] = y2;
		dst[10] = x2;
		dst[11] = y2;

		return YES;
	}
	
	
	
	return NO;
}



-(CGRect)GetOrg:(int)n
 {
	 CGRect rect = CGRectMake(0,0,1,1);
	 
	 if ((n>=0) && (n < m_partsMax))
	 {
		 rect = m_org[n];
	 }
	 return rect;
 }

-(CGRect)GetRect:(int)n
{
	CGRect rect = CGRectMake(0,0,1,1);
	
	if ((n>=0) && (n < m_partsMax))
	{
		rect = m_rect[n];
	}
	return rect;
}

-(float*)GetUVPointer:(int)n
{
	if ((n>=0) && (n < m_partsMax))
	{
		return &(m_uv[n * 3 * 2 * 2]);
	}
	
	return &(m_uv[0 * 3 * 2 * 2]);//wazato error ha kaesanai 
}

-(BOOL)CopyUV:(int)n buffer:(float*)buffer
{
	if ((n>=0) && (n < m_partsMax))
	{
		float* src = [self GetUVPointer:n];
		memcpy(buffer,src,sizeof(float) * 3 * 2 * 2);
		return YES;
	}
	
	return NO;
}


-(void)dealloc
{
	NSLog(@"BoxUV dealloc *****************");
	if (m_uv != NULL)
	{
		free(m_uv);
		m_uv = NULL;
	}
	
	if (m_org != NULL)
	{
		free(m_org);
		m_org = NULL;
	}
	
	if (m_rect != NULL)
	{
		free(m_rect);
		m_rect = NULL;
	}
}

@end
