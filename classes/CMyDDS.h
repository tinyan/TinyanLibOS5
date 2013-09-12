//
//  CMyDDS.h
//  TinyanLibPad
//
//  Created by たいにゃん on 10/05/31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <zlib.h>


@interface CMyDDS : NSObject 
{

	CGSize m_size;
	CGSize m_bufferSizeMax;
	BOOL m_loadFlag;
	int* m_ddsHeader;
	int* m_data;
}

-(id)init;
-(id)initByDDSFile:(char*)filenameonly;
-(id)initByDDSZFile:(char*)filenameonly;
-(id)initByDDSZFile:(char*)filenameonly dir:(char*)dir;

-(BOOL)loadDDS:(char*)filenameonly;
-(BOOL)loadDDSZ:(char*)filenameonly;
-(BOOL)loadDDSZ:(char*)filenameonly dir:(char*)dir;

-(CGSize)getSize;
-(int*)getData;
-(int*)getHeader;

-(void)dealloc;

//inner
-(void)checkBufferSize:(int)sizex :(int)sizey;
@end
