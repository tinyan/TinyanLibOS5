//
//  CMyDebugMessage.h
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/04/23.
//
//

#import <Foundation/Foundation.h>

@interface CMyDebugMessage : NSObject
{
	
}

+(void)debugOK;
+(void)debugEnd;
+(void)OutputDebugMessage:(NSString*)message;

@end
