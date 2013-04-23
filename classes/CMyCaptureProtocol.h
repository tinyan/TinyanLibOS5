/*
 *  myCaptureProtocol.h
 *  kaleidoCamera3
 *
 *  Created by たいにゃん on 10/07/27.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */



//#import <QuartzCore/QuartzCore.h>

//#import <OpenGLES/EAGL.h>
//#import <OpenGLES/EAGLDrawable.h>

@protocol CMyCaptureProtocol <NSObject>

@optional
-(void) BinaryCallback:(unsigned char*)buffer size:(CGSize)size;
-(void) ImageCallback:(UIImage*)image;
-(void) BinaryPointerCallback:(unsigned char*)buffer size:(CGSize)size next:(int)bytesPerRow;

-(CGSize)RequestBufferSize;

@end
