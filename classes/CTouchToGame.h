//
//  CTouchToGame.h
//  nohint
//
//  Created by たいにゃん on 2012/11/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CTouchToGame : NSObject
{
	CGSize m_gameSize;
	CGSize m_screenSize;
	CGRect m_gameAtScreenRect;
	
	float m_touchAngle;
	float m_touchCos;
	float m_touchSin;
	float m_touchCenterX;
	float m_touchCenterY;
	float m_scaleFactor;//dont use?
}


-(id)init;
-(void)setGameSize:(CGSize) size;
-(void)setScreenSize:(CGSize)size;
-(void)setGameAtScreenAspect;
-(void)setGameAtScreenFull;
-(void)setGameAtScreen:(CGRect)rect;
-(void)setScaleFactor:(float)factor;
-(void)setTouchAngle:(float)angle;

-(CGSize)getGameSize;
-(CGSize)getScreenSize;
-(CGRect)getGameAtScreen;
-(float)getScaleFactor;
-(float)getTouchAngle;

-(CGPoint)screenToGame:(CGPoint)point;

@end
