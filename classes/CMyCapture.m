//
//  myCapture.m
//  kaleidoScope3
//
//  Created by たいにゃん on 10/07/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CMyCapture.h"
#import "CMyMachineModel.h"






@implementation CMyCapture


-(id)initWithCallback:(id <CMyCaptureProtocol>) callbackObject
{
	
	if (self = [super init])
	{
		m_callbackObject = callbackObject;
		

		m_captureSession = [[AVCaptureSession alloc] init]; 
		
		
		m_captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
		AVCaptureDeviceInput* captureInput = [AVCaptureDeviceInput deviceInputWithDevice:m_captureDevice error:nil];
		AVCaptureVideoDataOutput* captureOutput = [[AVCaptureVideoDataOutput alloc]init];
	
//		m_inputDevice = captureInput;
		
//		dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
//		[captureOutput setSampleBufferDelegate:self queue:queue];
//		dispatch_release(queue);
	
	
		NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey; 
		NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA]; 
		NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key]; 

		[captureOutput setVideoSettings:videoSettings]; 		
		[captureOutput setAlwaysDiscardsLateVideoFrames:YES];
		[captureOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
		
		
		// Add to CaptureSession input and output 
//		[m_captureSession beginConfiguration]; 
		[m_captureSession addInput:captureInput]; 
		[m_captureSession addOutput:captureOutput]; 
//		[m_captureSession commitConfiguration]; 
		
		
//		[captureOutput release];
		
		/*
		// Configure CaptureSession 
		//        [m_captureSession setSessionPreset:AVCaptureSessionPresetHigh]; 
		//    [m_captureSession setSessionPreset:AVCaptureSessionPresetLow]; //192,144 ?
		[m_captureSession setSessionPreset:AVCaptureSessionPresetMedium]; //480,360 ?
		//        [m_captureSession setSessionPreset:AVCaptureSessionPreset640x480];
	
		//	m_captureSession.AVCaptureVideoOrientation=AVCaptureVideoOrientationPortrait;
		*/
		
		
	// Start the capture 
	//	[m_captureSession startRunning]; 
	
	}
	
	return self;
}

-(BOOL)setDefaultConfig
{
	int model = [CMyMachineModel getModel];
	BOOL flg = YES;
	
	if (model >= 4)
	{
		flg = [self changeConfig:2];
	}
	else 
	{
		flg = [self changeConfig:2];
	}
	
	return flg;
}

-(BOOL)changeConfig:(int)type
{
	[m_captureSession beginConfiguration]; 
	
	if (type == 1)
	{
		[m_captureSession setSessionPreset:AVCaptureSessionPresetLow]; 
	}
	else if (type == 2)
	{
		[m_captureSession setSessionPreset:AVCaptureSessionPresetMedium]; 
	}
	else if (type == 3)
	{
		[m_captureSession setSessionPreset:AVCaptureSessionPresetHigh]; 
	}
	else if (type == 4)
	{
		[m_captureSession setSessionPreset:AVCaptureSessionPreset640x480];
	}
	else if (type == 5)
	{
		[m_captureSession setSessionPreset:AVCaptureSessionPreset1280x720];
	}
	
	[m_captureSession commitConfiguration]; 
	
	m_captureConfig = type;
	
	return YES;
}

-(void)changeMode:(int)md
{
	m_mode = md;
}



-(void)startCapture
{
	NSLog(@"capture start" );
	
	if (m_captureConfig == 0)
	{
		[self setDefaultConfig];
	}
	
	[m_captureSession startRunning]; 
}

-(void)stopCapture
{
	NSLog(@"capture stop" );
	[m_captureSession stopRunning];
}

-(BOOL)stopCaptureAndWait:(int)wait
{
	[m_captureSession stopRunning];
	

	while (wait >= 0)
	{
		if (!m_captureSession.isRunning)
		{
			return YES;
		}
		
		[NSThread sleepForTimeInterval:1];
		
		
		wait--;
	}
	return NO;
}



// Create a UIImage from sample buffer data
- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer 
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer,0);
	
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer); 
    size_t height = CVPixelBufferGetHeight(imageBuffer); 
	
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
    if (!colorSpace) 
    {
        NSLog(@"CGColorSpaceCreateDeviceRGB failure");
        return nil;
    }
	
    // Get the base address of the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
	unsigned char* ptr = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
	
	int dt = (int)(*ptr);
	NSLog(@"data=%d",dt);
	
    // Get the data size for contiguous planes of the pixel buffer.
    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer); 
	
    // Create a Quartz direct-access data provider that uses data we supply
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize, 
															  NULL);
    // Create a bitmap image from data supplied by our data provider
    CGImageRef cgImage = 
	CGImageCreate(width,
				  height,
				  8,
				  32,
				  bytesPerRow,
				  colorSpace,
				  kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little,
				  provider,
				  NULL,
				  true,
				  kCGRenderingIntentDefault);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
	
    // Create and return an image object representing the specified Quartz image
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
	
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
	
    return image;
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection 
{ 
	
//	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
//	NSLog(@"capture session" );
	if (m_mode == MYCAPTURE_BINARY_MODE)
	{
		CGSize needSize = [m_callbackObject RequestBufferSize];
		int needSizeX = needSize.width;
		int needSizeY = needSize.height;
		
		
		 CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer); 
		 // Lock the image buffer 
		 CVPixelBufferLockBaseAddress(imageBuffer,0); 
		 // Get information of the image 
		 uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0); 
		 size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
		 size_t width = CVPixelBufferGetWidth(imageBuffer); 
		 size_t height = CVPixelBufferGetHeight(imageBuffer); 

	//	NSLog(@"org = %d %d %d",width,height,bytesPerRow);
		
		unsigned char* mImageData = (unsigned char*)malloc(640*480*sizeof(char)*4);
		
		unsigned char* src = baseAddress;
		unsigned char* dst = mImageData;
		
		int getSizeX = needSizeX;
		if (getSizeX > width)
		{
			getSizeX = (int)width;
		}
		int getStartX = (int)((width - getSizeX) / 2);
		
		int getSizeY = needSizeY;
		if (getSizeY > height)
		{
			getSizeY = (int)height;
		}
		int getStartY = (int)((height - getSizeY) / 2);
		
		src += 4 * getStartX;
		src += bytesPerRow * getStartY;
		
		for (int j=0;j<getSizeY;j++)
		{
			unsigned int* src1 = (unsigned int*)src;
			unsigned int* dst1 = (unsigned int*)dst;
			
			for (int i=0;i<getSizeX;i++)
			{
				int bgra = *(src1);
				int rgba = bgra & 0xff00ff00;
				rgba |= (bgra >> 16) & 0x000000ff;
				rgba |= (bgra << 16) & 0x00ff0000;
				
				rgba |= 0xff000000;
				
				*(dst1) = rgba;
				src1++;
				dst1++;
				/*
				unsigned char b = *(src+i*4+0);
				unsigned char g = *(src+i*4+1);
				unsigned char r = *(src+i*4+2);
				unsigned char a = 0xff;
				
				*(dst + i*4+0) = r;
				*(dst + i*4+1) = g;
				*(dst + i*4+2) = b;
				*(dst + i*4+3) = a;
				 */
			}
			
			//memcpy(dst,src,width*4);
			src += bytesPerRow;
			dst += getSizeX*4;
		}
		
		[m_callbackObject BinaryCallback:mImageData size:CGSizeMake(getSizeX,getSizeY)];

		//	 memcpy(mImageData, dataref, 640 * 480 * sizeof(char) * 4); 
		
		/*
		 // Create Colorspace 
		 CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
		 CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst); 
		 CGImageRef newImage = CGBitmapContextCreateImage(newContext); 
		 
		 // Release it 
		 CGContextRelease(newContext); 
		 CGColorSpaceRelease(colorSpace); 
		 
		 // Copy image data 
		 CFDataRef dataref = CGDataProviderCopyData(CGImageGetDataProvider(newImage)); 
	//	 memcpy(mImageData, dataref, 640 * 480 * sizeof(char) * 4); 
		 CFRelease(dataref); 
		 CGImageRelease(newImage); 
		 */
		
		
		 // Unlock the image buffer 
		 CVPixelBufferUnlockBaseAddress(imageBuffer,0); 
		 // CVBufferRelease(imageBuffer); 
		 
		
		
//		[m_callbackObject BinaryCallback:mImageData size:CGSizeMake(width,height)];
		free(mImageData);
		
	//	NSLog(@"capture session binary");
	}
	else if (m_mode == MYCAPTURE_IMAGE_MODE)
	{
		UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
	//	CGSize size = image.size;
	//	int sizeX = size.width;
	//	int sizeY = size.height;
		[m_callbackObject ImageCallback:image];
	//	NSLog(@"capture session type=image size= %d %d",sizeX,sizeY);
	}
	else if (m_mode == MYCAPTURE_POINTER_MODE)
	{
		
		CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer); 
		// Lock the image buffer 
		CVPixelBufferLockBaseAddress(imageBuffer,0); 

		// Get information of the image 
		uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0); 
		size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
		size_t width = CVPixelBufferGetWidth(imageBuffer); 
		size_t height = CVPixelBufferGetHeight(imageBuffer); 

		
		[m_callbackObject BinaryPointerCallback:baseAddress size:CGSizeMake(width,height) next:(int)bytesPerRow];
		
		CVPixelBufferUnlockBaseAddress(imageBuffer,0); 
		// CVBufferRelease(imageBuffer); 
	//	NSLog(@"capture session others");
	}
	
	
	
	/*
	 CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer); 
	 // Lock the image buffer 
	 CVPixelBufferLockBaseAddress(imageBuffer,0); 
	 // Get information of the image 
	 uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0); 
	 size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
	 size_t width = CVPixelBufferGetWidth(imageBuffer); 
	 size_t height = CVPixelBufferGetHeight(imageBuffer); 
	 
	 // Create Colorspace 
	 CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
	 CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst); 
	 CGImageRef newImage = CGBitmapContextCreateImage(newContext); 
	 
	 // Release it 
	 CGContextRelease(newContext); 
	 CGColorSpaceRelease(colorSpace); 
	 
	 // Copy image data 
	 CFDataRef dataref = CGDataProviderCopyData(CGImageGetDataProvider(newImage)); 
	 memcpy(mImageData, dataref, 640 * 480 * sizeof(char) * 4); 
	 CFRelease(dataref); 
	 CGImageRelease(newImage); 
	 
	 // Unlock the image buffer 
	 CVPixelBufferUnlockBaseAddress(imageBuffer,0); 
	 // CVBufferRelease(imageBuffer); 
	 */
	

	
} 


-(void)changeExposure:(CGPoint)pt
{
	NSArray* inputs = m_captureSession.inputs;
	NSLog(@"device number = %d",(int)(inputs.count));
	AVCaptureDeviceInput* inputDevice = (AVCaptureDeviceInput*)[inputs objectAtIndex:0];
	AVCaptureDevice* device = inputDevice.device;
	
	NSError* error = nil;
	if ([device lockForConfiguration:&error])
	{
		
		if (device.exposurePointOfInterestSupported)
		{
			//			m_captureDevice.exposureMode = AVCaptureExposureModeLocked;
			//			m_captureDevice.exposureMode = AVCaptureExposureModeAutoExpose;
			device.exposurePointOfInterest = pt;
			NSLog(@"exposure point changed");
		}

		/*
		if ([device isExposureModeSupported:AVCaptureExposureModeAutoExpose])
		{
			m_captureDevice.exposureMode = AVCaptureExposureModeAutoExpose;
			NSLog(@"setauto ok");
		}
		else 
		{
			NSLog(@"setauto bad");
		}
		*/
		
		
		if ([device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure])
		{
			m_captureDevice.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
			NSLog(@"set ok");
		}
		else 
		{
			NSLog(@"set bad");
		}
		
		
/*
		if ([device isExposureModeSupported:AVCaptureExposureModeLocked])
		{
			m_captureDevice.exposureMode = AVCaptureExposureModeLocked;
			NSLog(@"Lock");
		}
		else 
		{
			NSLog(@"cannot lock mode");
		}
*/
		
		
		
		[m_captureDevice unlockForConfiguration];
	}
	
}


-(void)dealloc
{
	[m_captureSession stopRunning];
//	[m_captureSession release];
//	[super dealloc];
}


@end
