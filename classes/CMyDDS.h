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
	BOOL m_loadFlag;
	char* m_ddsHeader;
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

-(void)dealloc;

@end
