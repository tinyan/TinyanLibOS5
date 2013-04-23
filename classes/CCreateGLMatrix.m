//
//  CCreateGLMatrix.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/01/23.
//
//

#import "CCreateGLMatrix.h"
#import "CTouchToGame.h"

@implementation CCreateGLMatrix

-(id)init
{
	self = [super init];
	if (self)
	{
		for (int i=0;i<16;i++)
		{
			if ((i % 5) == 0)
			{
				m_matrix[i] = 1.0f;
			}
			else
			{
				m_matrix[i] = 0.0f;
			}
		}
	}
	return self;
}

-(float*)createByTouchToGame:(CTouchToGame*)touchToGame
{
	CGSize screenSize = [touchToGame getScreenSize];
	CGSize gameSize = [touchToGame getGameSize];
	CGRect gameAtScreen = [touchToGame getGameAtScreen];
	float angle = [touchToGame getTouchAngle];
	float factor = [touchToGame getScaleFactor];
	
	return [self createByData:screenSize gameSize:gameSize gameAtScreen:gameAtScreen angle:angle scaleFactor:factor];
}

-(float*)createByData:(CGSize)screenSize gameSize:(CGSize)gameSize gameAtScreen:(CGRect)gameAtScreen angle: (float)angle scaleFactor:(float)scaleFactor
{
	if (
		screenSize.width != m_screenSize.width ||
		screenSize.height != m_screenSize.height ||
		gameSize.width != m_gameSize.width ||
		gameSize.height != m_gameSize.height ||
		gameAtScreen.origin.x != m_gameAtScreen.origin.x ||
		gameAtScreen.origin.y != m_gameAtScreen.origin.y ||
		gameAtScreen.size.width != m_gameAtScreen.size.width ||
		gameAtScreen.size.height != m_gameAtScreen.size.height ||
		angle != m_angle ||
		scaleFactor != m_scaleFactor
		)
	{
		m_screenSize = screenSize;
		m_gameSize = gameSize;
		m_gameAtScreen = gameAtScreen;
		m_angle = angle;
		m_scaleFactor = scaleFactor;
		
		
		float mx = m_gameSize.width / m_gameAtScreen.size.width;
		float my = m_gameSize.height / m_gameAtScreen.size.height;
		
		float dx1 = (m_gameAtScreen.origin.x - 0.0f) * mx;
		float dy1 = (m_gameAtScreen.origin.y - 0.0f) * my;
		float dx2 = (m_screenSize.width - (m_gameAtScreen.origin.x + m_gameAtScreen.size.width)) * mx;
		float dy2 = (m_screenSize.height - (m_gameAtScreen.origin.y + m_gameAtScreen.size.height)) * my;
		float sx = 0.0f - dx1;
		float sy = 0.0f - dy1;
		float ex = m_gameSize.width + dx2;
		float ey = m_gameSize.height + dy2;
		
		float mulX = 2.0f / (ex - sx);
		float mulY = -2.0f / (ey - sy);
		float mulZ = 1.0f;
		
		float cx = (ex+sx) / 2.0f;
		float cy = (ey+sy) / 2.0f;
		float cz = 0.0f;
		

		
		m_matrix[0] = mulX;
		m_matrix[1] = 0.0f;
		m_matrix[2] = 0.0f;
		m_matrix[3] = 0.0f;
		
		m_matrix[4] = 0.0f;
		m_matrix[5] = mulY;
		m_matrix[6] = 0.0f;
		m_matrix[7] = 0.0f;
		
		m_matrix[8] = 0.0f;
		m_matrix[9] = 0.0f;
		m_matrix[10] = mulZ;
		m_matrix[11] = 0.0f;
		
		m_matrix[12] = -cx * mulX;
		m_matrix[13] = -cy * mulY;
		m_matrix[14] = -cz * mulZ;
		m_matrix[15] = 1.0f;
		
		
		
		
		
		
		
		
		
	}
	
	
	
	
	return m_matrix;
}

@end
