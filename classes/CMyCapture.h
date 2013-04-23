//
//  myCapture.h
//  kaleidoScope2
//
//  Created by たいにゃん on 10/07/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

#import "CMyCaptureProtocol.h"

#define MYCAPTURE_BINARY_MODE 0
#define MYCAPTURE_IMAGE_MODE 1
#define MYCAPTURE_POINTER_MODE 2

@interface CMyCapture : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>
{

	id <CMyCaptureProtocol> m_callbackObject;
	int m_mode;
	
	AVCaptureSession* m_captureSession;

	AVCaptureDevice* m_captureDevice;
	BOOL m_captureConfig;
}

-(id)initWithCallback:(id <CMyCaptureProtocol>)callbackObject;
-(BOOL)changeConfig:(int)type;
-(BOOL)setDefaultConfig;

-(void)changeMode:(int)md;
-(void)startCapture;
-(void)stopCapture;
-(BOOL)stopCaptureAndWait:(int)wait;

-(void)changeExposure:(CGPoint)pt;


- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer ;

-(void)dealloc;

@end
