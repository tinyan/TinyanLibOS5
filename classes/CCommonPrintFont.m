//
//  CommonPrintFont.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/26.
//
//

#import "CCommonDrawBufferVertexUV.h"
#import "CCommonPrintFont.h"
#import "CCommonFont.h"
#import "CCommonFont64.h"

@implementation CCommonPrintFont

-(id)initWithFont:(CCommonFont *)font
{
	self = [super init];
	if (self)
	{
		m_font = font;
	}
	
	return self;
}

-(id)initFont64
{
	self = [super init];
	if (self)
	{
		m_font = [[CCommonFont64 alloc]init];
	}
	return self;
}

-(void)setBuffer:(CCommonDrawBufferVertexUV*)buffer
{
	m_buffer = buffer;
}

-(void)printMessage:(CGPoint)point size:(CGSize)size message:(char*)message
{
	int ln = (int)strlen(message);
	CGPoint pt = point;
	
	for (int i=0;i<ln;i++)
	{
		unsigned char c = message[i];
		int cc = (int)c;
		cc &= 0xff;
		
		CGRect rect = [m_font GetFontRect:cc];
		
		[m_buffer blt:pt size:size src:rect.origin srcSize:rect.size];
		
		pt.x += size.width;
	}
}

@end
