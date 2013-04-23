//
//  CCommonFont.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/26.
//
//

#import "CCommonFont.h"

@implementation CCommonFont


-(id)initByMax:(int)n textureSize:(int)textureSize
{
	self = [super initByMax:n textureSize:textureSize];
	if (self)
	{
		m_fontMax = 128;
		m_table = (int*)malloc(sizeof(int)*m_fontMax);
		
	}
	
	
	return self;
}

-(CGRect)GetFontOrg:(int)n
{
	int font = [self fontToPic:n];
	return [self GetOrg:font];
}

-(CGRect)GetFontRect:(int)n
{
	int font = [self fontToPic:n];
	return [self GetRect:font];
}

-(float*)GetFontUVPointer:(int)n
{
	int font = [self fontToPic:n];
	return [self GetUVPointer:font];
}

-(BOOL)CopyFontUV:(int)n buffer:(float*)buffer
{
	int font = [self fontToPic:n];
	return [self CopyUV:font buffer:buffer];
}


-(int)fontToPic:(int)n
{
	if ((n<0) || (n>=m_fontMax)) return 0;
	return m_table[n];
}


-(void)dealloc
{
	if (m_table != NULL)
	{
		free(m_table);
		m_table = NULL;
	}
}


@end
