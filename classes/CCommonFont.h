//
//  CCommonFont.h
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/26.
//
//

#import <Foundation/Foundation.h>
#import "CMyBoxUV.h"

@interface CCommonFont : CMyBoxUV
{
	int m_textureSize;//dummy=512
	int m_fontMax;//128
	int* m_table;
}

-(id)initByMax:(int)n textureSize:(int)textureSize;


-(CGRect)GetFontOrg:(int)n;
-(CGRect)GetFontRect:(int)n;
-(float*)GetFontUVPointer:(int)n;
-(BOOL)CopyFontUV:(int)n buffer:(float*)buffer;


-(int)fontToPic:(int)n;

-(void)dealloc;

@end
