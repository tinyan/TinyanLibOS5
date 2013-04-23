//
//  CCommonAppDelegate.h
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/06.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CCommonGame;

@interface CCommonAppDelegate : UIResponder <UIApplicationDelegate>
{
	//	CGame* m_game;
}

@property (strong, nonatomic) UIWindow *window;

+(void)setGame:(CCommonGame*)lpGame;


@end
