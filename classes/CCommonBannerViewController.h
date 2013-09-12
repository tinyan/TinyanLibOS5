//
//  CCommonBannerViewController.h
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/06.
//
//

//#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import "CCommonViewController.h"

//@class CCommonViewController;
@class CCommonGame;
//@class ADBannerView;

@interface CCommonBannerViewController : CCommonViewController <ADBannerViewDelegate>
{
	int m_type;
	ADBannerView* m_banner;
}
-(void)viewDidLoadWithType:(int)type;

-(void)mySetup;

@end
