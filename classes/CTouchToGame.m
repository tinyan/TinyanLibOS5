//
//  CTouchToGame.m
//  nohint
//
//  Created by たいにゃん on 2012/11/14.
//
//

#import "CTouchToGame.h"

@implementation CTouchToGame

-(id)init
{
	self = [super init];
	if (self)
	{
		
	}
	
	return self;
}


-(void)setGameSize:(CGSize)size
{
	m_gameSize = size;
}

-(void)setScreenSize:(CGSize)size
{
	m_screenSize = size;
}

-(void)setGameAtScreen:(CGRect)rect
{
	m_gameAtScreenRect = rect;
}

-(void)setScaleFactor:(float)factor
{
	m_scaleFactor = factor;
}

-(void)setGameAtScreenAspect
{
	float gameAspect = 1.0f;
	if (m_gameSize.width != 0) gameAspect = m_gameSize.height / m_gameSize.width;
	if (gameAspect == 0.0f) gameAspect = 1.0f;
	
	float screenAspect = 1.0f;
	if (m_screenSize.width != 0.0f) screenAspect = m_screenSize.height - m_screenSize.width;
	if (screenAspect == 0.0f) screenAspect = 1.0f;

	
	float width = m_screenSize.width;
	float height = m_screenSize.height;
	float startX = 0.0f;
	float startY = 0.0f;
	
	if (gameAspect >= screenAspect)
	{
		width = height / gameAspect;
		startX = (m_screenSize.width - width) / 2.0f;
		
	}
	else
	{
		height = width + gameAspect;
		startY = (m_screenSize.height - height) / 2.0f;
	}
	
	CGRect rect = CGRectMake(startX,startY,width,height);
	[self setGameAtScreen:rect];
}



-(void)setGameAtScreenFull
{
	CGRect rect = CGRectMake(0,0,m_screenSize.width,m_screenSize.height);
	[self setGameAtScreen:rect];
}

-(void)setTouchAngle:(float)angle
{
	m_touchAngle = angle;
	float pi = 3.14159f;
	float th = angle * pi / 180.0f;
	m_touchCos = cos(-th);
	m_touchSin = sin(-th);
	float x0 = -m_screenSize.width / 2.0f;
	float y0 = -m_screenSize.height / 2.0f;

	float xx = x0 * cos(th) - y0 * sin(th);
	float yy = x0 * sin(th) + y0 * cos(th);
	
	m_touchCenterX = -xx;
	m_touchCenterY = -yy;
}

-(CGSize)getGameSize
{
	return m_gameSize;
}

-(CGSize)getScreenSize
{
	return m_screenSize;
}

-(CGRect)getGameAtScreen
{
	return m_gameAtScreenRect;
}

-(float)getScaleFactor
{
	return m_scaleFactor;
}

-(float)getTouchAngle
{
	return m_touchAngle;
}

-(CGPoint)screenToGame:(CGPoint)point
{
	CGPoint pt;
	
	float touchX = point.x;
	float touchY = point.y;
//	printf("screen to game[%f %f]",touchX,touchY);
	if (m_touchAngle != 0.0f)
	{
		//turn
		float x = touchX - m_touchCenterX;
		float y = touchY - m_touchCenterY;
		
		float xx = x * m_touchCos - y * m_touchSin;
		float yy = x * m_touchSin + y * m_touchCos;
		
		touchX = xx + m_touchCenterX;
		touchY = yy + m_touchCenterY;
	}

//	printf("s[%f %f]",touchX,touchY);
	touchX -= m_gameAtScreenRect.origin.x;
	touchY -= m_gameAtScreenRect.origin.y;
//	printf("[%f %f]",touchX,touchY);

	touchX *= m_gameSize.width;
	touchX /= m_gameAtScreenRect.size.width;
	touchY *= m_gameSize.height;
	touchY /= m_gameAtScreenRect.size.height;
//	printf("[%f %f]¥n",touchX,touchY);

	pt.x = touchX;
	pt.y = touchY;
	
	return pt;
}

@end
