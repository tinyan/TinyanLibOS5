//
//  CCommonFont64.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/25.
//
//

#import "CMyBoxUV.h"
#import "CCommonFont.h"
#import "CCommonFont64.h"

@implementation CCommonFont64

-(id)init
{
	self = [super initByMax:64 textureSize:512];
	if (self)
	{
		m_textureSize = 512;
		for (int j=0;j<8;j++)
		{
			for (int i=0;i<8;i++)
			{
				int n = i + j * 8;
				CGPoint point = CGPointMake(i* 64, j * 64);
				CGSize size = CGSizeMake(64,64);
				
				[self SetUV:n point:point size:size];
			}
		}
		
		for (int i=0;i<32;i++)
		{
			m_table[i] = 0;
		}
		
		for (int i=32;i<96;i++)
		{
			m_table[i] = i-32;
		}

		for (int i=96;i<128;i++)
		{
			m_table[i] = i-64;
		}
	}
	
	return self;
}



-(void)dealloc
{
}



@end
