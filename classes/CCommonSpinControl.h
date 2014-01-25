//
//  CCommonSpinControl.h
//  TinyanLibOS5
//
//  Created by たいにゃん on 2014/01/25.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCommonSpinControl : NSObject
{
	bool m_areaFlag;
	CGRect m_area;
	float m_max;
	int m_devide;
	float m_spin;
	float m_spinSpeed;
	float m_speedMin;
	float m_flickSpeed;
	float m_masatsu;
	float m_near;
	float m_autoSpeedLimitMin;
	
	
	bool m_tap;
	bool m_trig;
	bool m_click;
	bool m_flick;
	
	CGPoint m_startZahyo;
	CGPoint m_endZahyo;
	CGPoint m_flickStart;
	CGPoint m_flickEnd;
	CGPoint m_lastDragStart;
	CGPoint m_lastDragEnd;
	
}

-(id)initWithMax:(float)mx devide:(int)devide;
-(void)setArea:(CGRect)area;
-(void)setSpeedMin:(float)speedMin;
-(void)setFlickSpeed:(float)flickSpeed;
-(void)setMasatsu:(float)masatsu;
-(void)setNear:(float)near;
-(void)setAutoSpeedLimitMin:(float)autoMin;
-(void)setSpin:(float)spin;
-(void)setSpinSpeed:(float)spinSpeed;
-(void)limitSpin;

-(void)allClear;
-(void)startCalcu;
-(void)endCalcu;

-(float)getSpin;
-(void)onTouchBegin:(CGPoint)from;
-(void)onTouchMove:(CGPoint)from to:(CGPoint)to;
-(void)onTouchEnd:(CGPoint)from to:(CGPoint)to;

-(bool)checkTap;
-(bool)checkTrig;
-(bool)checkFlick;
-(bool)checkTapOrFlick;
-(CGPoint)getTapZahyo;




@end
