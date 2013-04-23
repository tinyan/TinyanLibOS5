//
//  CCommonSoundControl.h
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/05.
//
//

#import <Foundation/Foundation.h>
@class OALControl;
@class OALData;

#define MY_OAL_SOUND_MAX 256

@interface CCommonSoundControl : NSObject
{
	int m_soundMax;
	OALControl* m_openALControl;
	OALData* m_openALData[MY_OAL_SOUND_MAX];
	
}

-(id)init;
-(BOOL)loadAiff:(int)n name:(NSString*)name;

-(void)setVolume:(int)n volume:(float)volume;
-(void)play:(int)n;
-(void)stop:(int)n;


@end
