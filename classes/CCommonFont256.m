//
//  CCommonFont256.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/26.
//
//



#import "CMyBoxUV.h"
#import "CCommonFont.h"
#import "CCommonFont256.h"

@implementation CCommonFont256
//use 96 chara
-(id)init
{
	self = [super initByMax:256 textureSize:1024];
	if (self)
	{
		m_textureSize = 1024;
		for (int j=0;j<16;j++)
		{
			for (int i=0;i<16;i++)
			{
				int n = i + j * 16;
				CGPoint point = CGPointMake(i* 64, j * 64);
				CGSize size = CGSizeMake(64,64);
				
				[self SetUV:n point:point size:size];
			}
		}
		
		for (int i=0;i<32;i++)
		{
			m_table[i] = 0;
		}
		
		for (int i=32;i<128;i++)
		{
			m_table[i] = i-32;
		}
	}
	
	return self;
}



-(void)dealloc
{
}


@end
