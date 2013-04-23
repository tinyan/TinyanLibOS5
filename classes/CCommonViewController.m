//
//  ViewController.m
//  comike2011win
//
//  Created by 山口 慎治 on 11/12/04.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <GLKit/GLKit.h>

#import "CCommonGame.h"
//#import "CGame.h"

#import "CCommonViewController.h"


@interface CCommonViewController () {
}

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

//- (void)setupGL;
//- (void)tearDownGL;

@end


@implementation CCommonViewController

@synthesize context = _context;
@synthesize effect = _effect;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
	

	
//    [self setupGL];//kononakade context set shiteru
    
    
//    m_game = [[CGame alloc]init];
    
}

-(void)MyCreateGL:(float)scaleFactor
{
    self.view.contentScaleFactor = scaleFactor;
    
    //    self.context = [[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2] autorelease];
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [EAGLContext setCurrentContext:self.context];
    
//	ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
//	adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
//	adView.hidden = YES;
//	[self.view addSubview:adView];
//	[adView setDelegate:self];

}

- (void)viewDidUnload
{    
    [super viewDidUnload];
    
    [EAGLContext setCurrentContext:self.context];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[m_game onRotate:self.interfaceOrientation from:fromInterfaceOrientation];
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[m_game willRotate:self.interfaceOrientation to:toInterfaceOrientation duration:duration];
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    [m_game onTimer];
    return;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [m_game onDraw:view drawInRect:rect];
}

#pragma mark -  OpenGL ES 2 shader compilation


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [m_game touchesBegan:touches withEvent:event view:self.view];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [m_game touchesMoved:touches withEvent:event view:self.view];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [m_game touchesEnded:touches withEvent:event view:self.view];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [m_game touchesCancelled:touches withEvent:event view:self.view];
}

/*
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	NSLog(@"banner fail rec error");
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
	NSLog(@"banner action finish");
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
	NSLog(@"banner should begin");

	return YES;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
	banner.hidden = NO;
	NSLog(@"banner loaded");
}

- (void)bannerViewWillLoadAd:(ADBannerView *)banner
{
	NSLog(@"banner will load");
}

*/


- (void)dealloc
{
	
}


@end
