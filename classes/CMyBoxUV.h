//
//  CMyBoxUV.h
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/01/04.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CMyBoxUV : NSObject
{
	int m_partsMax;
	float* m_uv;
	float m_textureSizeX;
	float m_textureSizeY;
	CGRect* m_org;
	CGRect* m_rect;
}

-(id)initByMax:(int)n textureSize:(int)textureSize;

-(BOOL)SetUV:(int)n point:(CGPoint)point size:(CGSize)size;



-(CGRect)GetOrg:(int)n;
-(CGRect)GetRect:(int)n;
-(float*)GetUVPointer:(int)n;
-(BOOL)CopyUV:(int)n buffer:(float*)buffer;

-(void)dealloc;


@end
