//
//  CCommonSoundControl.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/05.
//
//

#import "OALControl.h"
#import "OALData.h"

#import "CCommonSoundControl.h"

@implementation CCommonSoundControl

-(id)init
{
	self = [super init];
	if (self)
	{
		m_soundMax = MY_OAL_SOUND_MAX;
		m_openALControl = [[OALControl alloc]init];
	}
	return self;
}

-(BOOL)loadAiff:(int)n name:(NSString*)name
{
	if ((n<0) || (n>=m_soundMax)) return NO;
	
	if (m_openALData[n] != Nil)
	{
		return NO;//???
	}
	
	m_openALData[n] = [[OALData alloc]initWithFile:name ofType:@"aiff"];
	
	return YES;
}


-(void)setVolume:(int)n volume:(float)volume
{
	if ((n>=0) && (n<m_soundMax))
	{
		[m_openALData[n] setVolume:volume];
	}
}

-(void)play:(int)n
{
	if ((n>=0) && (n<m_soundMax))
	{
		[m_openALData[n] play];
	}
}

-(void)stop:(int)n
{
	if ((n>=0) && (n<m_soundMax))
	{
		[m_openALData[n] stop];
	}
}

@end
