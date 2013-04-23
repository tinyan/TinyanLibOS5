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
	ADBannerView* m_banner;
}

@end
