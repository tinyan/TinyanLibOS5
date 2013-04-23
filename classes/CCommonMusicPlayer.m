//
//  CCommonMusicPlayer.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/27.
//
//

#import "CCommonMusicPlayer.h"

@implementation CCommonMusicPlayer


-(id)init
{
	self = [super init];
	if (self)
	{
		m_musicMax = 0;
		m_lastMusic = -1;
	}
	return self;
}

-(int)setMP3:(NSString*)filename
{
	return [self setMusic:filename ofType:@"mp3"];
}

-(int)setMusic:(NSString*)filename ofType:(NSString*)ofType
{
	if (m_musicMax >= MY_BGM_MAX) return -1;//error
	
	NSString* bgmPath = [[NSBundle mainBundle] pathForResource:filename ofType:ofType];
	NSURL* bgmURL = [NSURL fileURLWithPath:bgmPath];
	
	m_player[m_musicMax] = [[AVAudioPlayer alloc]initWithContentsOfURL:bgmURL error:nil];
	
	int n = m_musicMax;
	m_musicMax++;
	[self setLoops:n loops:-1];
	
	return n;
}


-(void)setMultiMode:(BOOL)flag
{
	m_multiMode = flag;
}

-(void)stop
{
	if (m_lastMusic != -1)
	{
		[self stop:m_lastMusic];
	}
}

-(void)play:(int)n
{
	if ((n>=0) && (n<m_musicMax))
	{
		if (!m_multiMode)
		{
			[self stop];
		}
		
		[m_player[n] play];
	}
}

-(void)stop:(int)n
{
	if ((n>=0) && (n<m_musicMax))
	{
		[m_player[n] stop];
		m_lastMusic = -1;
	}
}

-(void)setVolume:(int)n volume:(float)volume
{
	if ((n>=0) && (n<m_musicMax))
	{
		[m_player[n] setVolume:volume];
	}
}

-(void)setLoops:(int)n loops:(int)loops
{
	if ((n>=0) && (n<m_musicMax))
	{
		[m_player[n] setNumberOfLoops:loops];
	}
}


-(void)dealloc
{
}


@end
