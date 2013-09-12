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

-(void)viewDidLoadWithType
{
	[super viewDidLoad];
	m_type = 0;//0:upper
	
}

-(void)viewDidLoadWithType:(int)type
{
	[super viewDidLoad];
	m_type = type;//0:upper
	
	[self mySetup];
	

}

-(void)mySetup
{
	//	m_banner = [[ADBannerView alloc] initWithFrame:CGRectZero];
	m_banner = [[ADBannerView alloc] init];
	
	CGRect frame = [[UIScreen mainScreen]applicationFrame];
	NSLog(@"uiscreen mainscreen %d %d",(int)frame.size.width,(int)frame.size.height);
	
	//	[[UIDevice currentDevice] orientation];
	//	[[UIScreen mainScreen]
	
	
	float height = m_banner.frame.size.height;
	float width = frame.size.width;
	if ((self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight))
	{
		width = frame.size.height;
	}
	m_banner.frame = CGRectMake(0,-height,frame.size.width,height);
	
	
	
	
	
	//m_banner.frame
	
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
	CGSize size = [m_game getDeviceScreenSize];
	int width = size.width;
	int height = size.height;
	
//	int width = 768;
	BOOL landScape = NO;
	if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) landScape = YES;
	if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) landScape = YES;
	if (landScape)
	{
		int tmp = width;
		width = height;
		height = tmp;
	}
	
	int bannerHeight = m_banner.frame.size.height;
	
	m_banner.frame = CGRectMake(0,height-bannerHeight,width,bannerHeight);
	[m_game willRotate:self.interfaceOrientation to:toInterfaceOrientation duration:duration];
}


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
//	CGSize bannerSize = banner.frame.size;

	CGSize size = [m_game getDeviceScreenSize];
	//float height = m_banner.frame.size.height;
	float height = banner.frame.size.height;
	float width = size.width;
	if ((self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight))
	{
		width = size.height;
	}
	
	NSLog(@"banner size = %d %d",(int)width,(int)height);
	banner.frame = CGRectMake(0,-height,width,height);
	banner.hidden = NO;
	
	[UIView beginAnimations:NULL context:NULL];
	
	
	banner.frame = CGRectMake(0,0,width,height);
//	banner.frame = CGRectMake(0,768-66,banner.frame.size.width,banner.frame.size.height);
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
