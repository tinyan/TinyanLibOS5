//
//  CMyMachineModel.m
//  TinyanLib
//
//  Created by たいにゃん on 10/09/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <sys/utsname.h>
#import "CMyMachineModel.h"

//
// 2,6 iPadMini(GSM)
// 2,7 iPadMini(CDMA)
// 3,5 iPad 4th (GSM)
// 3,6 iPad 4th (GSM)
//
int m_model = -1;
int m_machine = -1;
float m_maxScaleFactor = -1.0f;

@implementation CMyMachineModel


+(int)getModel
{
	if (m_model == -1)
	{
		[CMyMachineModel checkMachine];
	}
	
	return m_model;
}

+(int)getMachine
{
	if (m_machine == -1)
	{
		[CMyMachineModel checkMachine];
	}
	
	return m_machine;
}

+(float)getMaxScaleFactor
{
	if (m_maxScaleFactor == -1.0f)
	{
		[CMyMachineModel checkMachine];
	}
	
	return m_maxScaleFactor;
}

+(void)checkMachine
{

	struct utsname u;
	uname(&u);

	m_machine = MY_MACHINE_IPHONE;//ihpne
	
//	NSLog(@"machine = %s",u.machine);
	
	char check2[16];
	memcpy(check2,u.machine,4);
	check2[4] = 0;

	if (strcmp(check2,"iPod") == 0)
	{
		m_machine = MY_MACHINE_IPOD;//ipod
	}

	if (strcmp(check2,"iPad") == 0)
	{
		m_machine = MY_MACHINE_IPAD;//ipad
	}
			
	m_maxScaleFactor = 1.0f;
	
	if (m_machine == MY_MACHINE_IPOD)
	{
		if (strcmp(u.machine,"iPod4,1") >= 0)
		{
			m_model = MY_MODEL_IPOD4;
//			NSLog(@"routine:iPod4");
		}
		else if (strcmp(u.machine,"iPod3,1") >= 0)
		{
			m_model = MY_MODEL_IPOD3;
//			NSLog(@"routine:iPod3ed");
		}
		else if (strcmp(u.machine,"iPod2,1") >= 0)
		{
			m_model = MY_MODEL_IPOD2;
//			NSLog(@"routine:iPod2nd");
			
		}
		else 
		{
			m_model = MY_MODEL_IPOD1;
//			NSLog(@"routine:iPod");
		}
	
		if (m_model >= MY_MODEL_IPOD4)
		{
			m_maxScaleFactor = 2.0f;
		}
	}
	else if (m_machine == MY_MACHINE_IPHONE)
	{
		if (strcmp(u.machine,"iPhone2,1") >= 0)
		{
			if (strcmp(u.machine,"iPhone5,1") >= 0)
			{
//				NSLog(@"iPhone 5 over");
				m_model = MY_MODEL_IPHONE5;
			}
			else if (strcmp(u.machine,"iPhone4,1") >= 0)
			{
//				NSLog(@"iPhone 4S over");
				m_model = MY_MODEL_IPHONE4S;
			}
			else if (strcmp(u.machine,"iPhone3,1") >= 0)
			{
//				NSLog(@"iPhone 4 over");
				m_model = MY_MODEL_IPHONE4;
			}
			else 
			{
//				NSLog(@"iPhone 3GS");
				m_model = MY_MODEL_IPHONE3GS;
			}
		}
		else 
		{
			
			//1.2
//			NSLog(@"iPhone 3G");
			m_model = MY_MODEL_IPHONE3G;
		}
		
		if (m_model >= MY_MODEL_IPHONE4)
		{
			m_maxScaleFactor = 2.0f;
		}
	}
	else 
	{
		if (strcmp(u.machine,"iPad3,4") >= 0)
		{
            m_model= MY_MODEL_IPAD4;
//            NSLog(@"machine = retina ipad (4th)");
        }
		else if (strcmp(u.machine,"iPad3,1") >= 0)
		{
            m_model= MY_MODEL_NEWIPAD;
//            NSLog(@"machine = new iPad");
        }
        else if (strcmp(u.machine,"iPad2,1") >= 0)
        {
            m_model= MY_MODEL_IPAD2;
//            NSLog(@"machine = iPad2");
        }
        else
        {
            m_model = MY_MODEL_IPAD1;
//            NSLog(@"machine=iPad");
        }
        
		if (m_model >= MY_MODEL_NEWIPAD)
		{
			m_maxScaleFactor = 2.0f;
		}
	}
}


@end
