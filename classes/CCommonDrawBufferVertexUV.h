//
//  CDrawBuffer.h
//  nohint
//
//  Created by たいにゃん on 12/06/21.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCommonDrawBufferVertexUV : NSObject
{
    int m_drawNumber;
    int m_drawMode;
    
    float* m_vertex;
    float* m_uv;
    
    int m_drawMax;
    int m_workMax;
    int m_workMulti;
    int m_2D3D;
}

-(void)set2D3D:(int)md;
-(void)beginPrint:(int)md;
-(void)beginPrint;
-(void)addTriangle:(int)n vertex:(float*)lpVertex uv:(float*)lpUV;
-(void)addQuad:(float*)lpVertex uv:(float*)lpUV;
-(void)blt:(CGPoint)put size:(CGSize)size src:(CGPoint)src srcSize:(CGSize)srcSize;
-(void)turnBlt:(CGPoint)center size:(CGSize)size src:(CGPoint)src srcSize:(CGSize)srcSize angle:(float)angle;

-(void)endPrint;

-(void)dealloc;

@end
