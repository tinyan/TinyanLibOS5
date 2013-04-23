//
//  CTitle.h
//
//  Created by たいにゃん on 12/06/21.
//
//

#import <Foundation/Foundation.h>
//#import "commonGeneralProtocol.h"

@class CCommonGeneral;
@class CGame;

@interface CTitle :  CCommonGeneral <commonGeneralProtocol>
{
    bool m_clicked;
	CGame* m_game2;
}

-(id)init:(CGame*)lpGame;

-(void)Init;
-(int)Calcu;
-(void)Print;
-(void)FinalExitRoutine;

@end
