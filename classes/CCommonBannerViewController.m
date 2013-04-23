//
//  CCommonBannerViewController.m
//  TinyanLibOS5
//
//  Created by たいにゃん on 2013/02/06.
//
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import <iAd/iAd.h>

#import "CCommonViewController.h"
#import "CCommonBannerViewController.h"

#import "CCommonGame.h"



@implementation CCommonBannerViewController

-(void)viewDidLoad
{
	[super viewDidLoad];
	
	m_banner = [[ADBannerView alloc] initWithFrame:CGRectZero];
	//	adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
	
	m_banner.hidden = YES;
	[self.view addSubview:m_banner];
	[m_banner setDelegate:self];

}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	NSLog(@"banner fail rec error");
	
	banner.hidden = YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
	NSLog(@"banner action finish");
	[m_game oniAd:NO];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
	NSLog(@"banner should begin");
	[m_game oniAd:YES];
	return YES;
}


-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	int width = 768;
	if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) width = 1024;
	if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) width = 1024;
	
	m_banner.frame = CGRectMake(0,768-66,width,m_banner.frame.size.height);
	[m_game willRotate:self.interfaceOrientation to:toInterfaceOrientation duration:duration];
}


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
	banner.hidden = NO;
	
	[UIView beginAnimations:NULL context:NULL];
	
	
	banner.frame = CGRectMake(0,768-66,banner.frame.size.width,banner.frame.size.height);
	//	 banner.frame = CGRectOffset(banner.frame,0,[self.view frame].size.height  -  banner.frame.size.height);
	//	 banner.frame = CGRectMake(0,768-66,1024,banner.frame.size.height);
	[UIView commitAnimations];
	
	NSLog(@"banner loaded");
}

- (void)bannerViewWillLoadAd:(ADBannerView *)banner
{
	NSLog(@"banner will load");
}

@end
