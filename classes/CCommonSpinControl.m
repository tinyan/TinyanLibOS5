//
//  CCommonSpinControl.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2014/01/25.
//
//

#import "CCommonSpinControl.h"

@implementation CCommonSpinControl


-(id)initWithMax:(float)mx devide:(int)devide
{
	self = [super init];
	if (self)
	{
		m_areaFlag = NO;
		m_max = mx;
		m_devide = devide;
		[self setSpin:0];
		[self setSpinSpeed:0];
		[self setSpeedMin:0.3];
		[self setFlickSpeed:0.8];
		[self setMasatsu:0.96];
		[self setNear:2.0];
		[self setAutoSpeedLimitMin:0.5];
	}
	return self;
}

-(void)setArea:(CGRect)area
{
	m_areaFlag = YES;
	m_area = area;
}

-(void)setSpeedMin:(float)speedMin
{
	m_speedMin = speedMin;
}

-(void)setFlickSpeed:(float)flickSpeed
{
	m_flickSpeed = flickSpeed;
}

-(void)setMasatsu:(float)masatsu
{
	m_masatsu = masatsu;
}

-(void)setNear:(float)near
{
	m_near = near;
}

-(void)setAutoSpeedLimitMin:(float)autoMin
{
	m_autoSpeedLimitMin = autoMin;
}

-(void)setSpin:(float)spin
{
	m_spin = spin;
	[self limitSpin];
}

-(void)setSpinSpeed:(float)spinSpeed
{
	m_spinSpeed = spinSpeed;
}

-(void)limitSpin
{
	for (int i=0;i<10;i++)
	{
		if (m_spin >= 1000.0)
		{
			m_spin -= 1000.0;
		}
		else
		{
			break;
		}
	}
	
	for (int i=0;i<10;i++)
	{
		if (m_spin < 0)
		{
			m_spin += 1000.0;
		}
		else
		{
			break;
		}
	}
	
}

-(void)allClear
{
	m_spin = 0;
	m_click = NO;
	m_trig = NO;
	m_tap = NO;
	m_flick = NO;
}

-(void)startCalcu
{
	if (m_trig)
	{
		m_spinSpeed = 0;
		float movex = m_endZahyo.x - m_startZahyo.x;
		m_spin -= movex;
		[self limitSpin];
	}
	
	if (m_flick)
	{
		float speed = m_flickEnd.x - m_flickStart.x;
		speed *= - m_flickSpeed;
		m_spinSpeed = speed;
	}
	
	
	m_spin += m_spinSpeed;
	[self limitSpin];
	
	
	//teisoku andfar
	if ((m_spinSpeed > m_speedMin) || (m_spinSpeed < -m_speedMin))
	{
		m_spinSpeed *= m_masatsu;
	}
	else
	{
		if (!m_trig)
		{
			//brake
			float dv = m_max / m_devide;
			
			float dx = m_spin - dv * (int)(m_spin / dv);
			if (dx > dv * 0.5)
			{
				dx -= dv;
			}
			
			if ((dx > -m_near) && (dx < m_near))
			{
				m_spin -= dx;
				m_spinSpeed = 0;
			}
			else
			{
				if (dx > 0)
				{
					if (m_spinSpeed < m_autoSpeedLimitMin)
					{
						m_spinSpeed = -m_speedMin;
					}
				}
				else if (dx < 0)
				{
					if (m_spinSpeed > -m_autoSpeedLimitMin)
					{
						m_spinSpeed = m_speedMin;
					}
				}
			}
		}
	}
	
}

-(void)endCalcu
{
	m_startZahyo = m_endZahyo;
	
	m_click = NO;
	m_flick = NO;
	m_tap = NO;
}

-(float)getSpin
{
	return m_spin;
}

-(void)onTouchBegin:(CGPoint)from
{
	m_startZahyo = from;
	m_endZahyo = m_startZahyo;
	
	m_lastDragStart = m_endZahyo;
	m_lastDragEnd = m_endZahyo;
	
	m_trig = YES;
	m_click = YES;
	
}

-(void)onTouchMove:(CGPoint)from to:(CGPoint)to
{
	m_lastDragStart = from;
	m_lastDragEnd = to;
	if (!m_trig)
	{
		m_trig = YES;
		m_startZahyo = from;
		m_endZahyo = to;
	}
	else
	{
		m_endZahyo = to;
	}
}

-(void)onTouchEnd:(CGPoint)from to:(CGPoint)to
{
	m_flickStart = from;
	m_flickEnd = to;
	
	float dx = m_flickStart.x - m_flickEnd.x;
	float dy = m_flickStart.y - m_flickEnd.y;
	float r = sqrt(dx*dx + dy*dy);
	if (r > 0)
	{
		NSLog(@"%f %f %f",m_flickStart.x,m_flickEnd.x,r);
		m_flickStart = m_lastDragStart;
		
		m_flick = YES;
	}
	else
	{
		if (m_trig)
		{
			m_tap = YES;
		}
	}
	
	m_trig = NO;
	
}

-(bool)checkTap
{
	return m_tap;
}
-(bool)checkTrig
{
	return m_trig;
}
-(bool)checkFlick
{
	return m_flick;
}
-(bool)checkTapOrFlick
{
	return [self checkTap] | [self checkFlick];
}


-(CGPoint)getTapZahyo
{
	return m_flickEnd;
}


@end
