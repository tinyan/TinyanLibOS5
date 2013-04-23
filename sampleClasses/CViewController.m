//
//  CViewController.m
//  ginhagashi
//
//  Created by たいにゃん on 2013/01/02.
//  Copyright (c) 2013年 bugnekosoft. All rights reserved.
//

#import "../../TinyanLibOS5/classes/CCommonGame.h"
#import "CGame.h"


#import "../../TinyanLibOS5/classes/CCommonViewController.h"
#import "CViewController.h"




@implementation CViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
    
	[self MyCreateGL:2.0f];
	
/*
	ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
	adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
	adView.hidden = YES;
	[self.view addSubview:adView];
	[adView setDelegate:self];
*/	
    
    m_game = [[CGame alloc]init];

}


@end
