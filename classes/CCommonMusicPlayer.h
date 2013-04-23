//
//  CCommonMusicPlayer.h
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/27.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define MY_BGM_MAX 16

@interface CCommonMusicPlayer : NSObject
{
	AVAudioPlayer* m_player[MY_BGM_MAX];
	int m_musicMax;
	int m_lastMusic;
	BOOL m_multiMode;
}

-(id)init;
-(int)setMP3:(NSString*)filename;
-(int)setMusic:(NSString*)filename ofType:(NSString*)ofType;


-(void)setMultiMode:(BOOL)flag;
-(void)stop;

-(void)play:(int)n;
-(void)stop:(int)n;
-(void)setVolume:(int)n volume:(float)volume;
-(void)setLoops:(int)n loops:(int)loops;


-(void)dealloc;

@end
