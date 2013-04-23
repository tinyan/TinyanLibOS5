//
//  playSound.h
//  TinyanLibPad
//
//  Created by たいにゃん on 10/04/06.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface CPlaySound : NSObject 
{
	int m_soundNumberMax;
	SystemSoundID* m_soundID;
}

-(id)init:(int)soundNumberMax;
-(BOOL)load:(int)n name:(CFStringRef)name type:(CFStringRef)type;
-(void)play:(int)n;

//-(void)release;

@end
