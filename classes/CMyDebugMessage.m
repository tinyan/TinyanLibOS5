//
//  CMyDebugMessage.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/04/23.
//
//

#import "CMyDebugMessage.h"

@implementation CMyDebugMessage

bool m_myDebugOk = NO;

+(void)debugOK
{
	m_myDebugOk = YES;
}

+(void)debugEnd
{
	m_myDebugOk = NO;
}

+(void)OutputDebugMessage:(NSString*)message
{
	if (m_myDebugOk)
	{
		NSLog(@"%@",message);
	}
}

@end
