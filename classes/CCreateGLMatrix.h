//
//  CCreateGLMatrix.h
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/01/23.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CTouchToGame;

@interface CCreateGLMatrix : NSObject
{
	float m_matrix[16];
	CGSize m_screenSize;
	CGSize m_gameSize;
	CGRect m_gameAtScreen;
	float m_angle;
	float m_scaleFactor;
	
}

-(id)init;
-(float*)createByTouchToGame:(CTouchToGame*)touchToGame;
-(float*)createByData:(CGSize)screenSize gameSize:(CGSize)gameSize gameAtScreen:(CGRect)gameAtScreen angle:(float)angle scaleFactor:(float)scaleFactor;

@end
