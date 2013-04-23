//
//  CommonPrintFont.h
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/26.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CCommonDrawBufferVertexUV;
@class CCommonFont;

@interface CCommonPrintFont : NSObject
{
	CCommonFont* m_font;
	CCommonDrawBufferVertexUV* m_buffer;
}

-(id)initWithFont:(CCommonFont*)font;
-(id)initFont64;

-(void)setBuffer:(CCommonDrawBufferVertexUV*)buffer;

-(void)printMessage:(CGPoint)point size:(CGSize)size message:(char*)message;

@end
