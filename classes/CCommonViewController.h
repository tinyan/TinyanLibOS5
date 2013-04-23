//
//  ViewController.h
//  lightline
//
//  Created by 山口 慎治 on 12/03/06.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <GLKit/GLKit.h>


@class CCommonGame;
//@class GLKViewController;

@interface CCommonViewController : GLKViewController
{
    CCommonGame* m_game;
}

-(void)MyCreateGL:(float)scaleFactor;



@end
