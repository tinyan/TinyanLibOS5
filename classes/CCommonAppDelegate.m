//
//  CCommonAppDelegate.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/06.
//
//

#import "CCommonAppDelegate.h"
#import "CMyDebugMessage.h"

//
//  CAppDelegate.m
//  ginhagashi
//
//  Created by たいにゃん on 2013/01/02.
//  Copyright (c) 2013年 bugnekosoft. All rights reserved.
//

//#import "../../TinyanLibOS5/classes/CCommonViewController.h"
//#import "CViewController.h"

#import "CCommonGame.h"
//#import "CGame.h"

@implementation CCommonAppDelegate

static CCommonGame* m_game = nil;

+(void)setGame:(CCommonGame*)lpGame
{
	m_game = lpGame;
	[CMyDebugMessage OutputDebugMessage: @"appdelegate::setGame"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[CMyDebugMessage OutputDebugMessage:@"---did finish app launch---"];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	[m_game onActive:NO];
	[CMyDebugMessage OutputDebugMessage:@"resign active"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	[CMyDebugMessage OutputDebugMessage:@"back ground"];
	
	//	CViewController* controller = (CViewController*)([_window rootViewController]);
	//	[controller dmy];
//	[m_game dmy];
	
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	[CMyDebugMessage OutputDebugMessage:@"will fore ground"];
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	[CMyDebugMessage OutputDebugMessage:@"did become active"];
	[m_game onActive:YES];
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[CMyDebugMessage OutputDebugMessage:@"will term"];
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
