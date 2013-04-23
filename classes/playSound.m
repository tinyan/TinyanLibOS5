//
//  playSound.m
//  TinyanLibPad
//
//  Created by たいにゃん on 10/04/06.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "playSound.h"


@implementation CPlaySound

-(id)init:(int)soundNumberMax
{
	if (self = [super init])
	{
		m_soundNumberMax = soundNumberMax;
		m_soundID = (SystemSoundID*)malloc(sizeof(SystemSoundID) * m_soundNumberMax);
		
	}
	
	return self;
}

-(BOOL)load:(int)n name:(CFStringRef)name type:(CFStringRef)type
{
	CFBundleRef mainBundle = CFBundleGetMainBundle();
	CFURLRef myURLRef = CFBundleCopyResourceURL(mainBundle,name,type,NULL);

	AudioServicesCreateSystemSoundID(myURLRef,&m_soundID[n]);
	CFRelease(myURLRef);
	
	return YES;
}

-(void)play:(int)n
{
	if ((n>=0) && (n<m_soundNumberMax))
	{
		int soundID = m_soundID[n];
		AudioServicesPlaySystemSound(soundID);		
		if (soundID != 0)
		{
			NSLog(@"sound ok");
		}
		else 
		{
			NSLog(@"sound error?");
		}
	}
	else
	{
		NSLog(@"sound bad number");
	}

}

//-(void)release
-(void)dealloc
{
	
	free(m_soundID);
//	[super dealloc];
}

@end
