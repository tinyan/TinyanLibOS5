//
//  CMyDDS.m
//  TinyanLibPad
//
//  Created by たいにゃん on 10/05/31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <zlib.h>
#import "CMyDDS.h"

typedef int DWORD;
typedef struct _iDDSHEAD 
{
	DWORD	dwMagic;	// == 0x20534444  ' SDD'
	DWORD	dwSize;		// == 124
	DWORD	dwFlags;	
	DWORD	dwHeight;	//
	DWORD	dwWidth;	//
	DWORD	dwPitchOrLinearSize;
	DWORD	dwDepth;
	DWORD	dwMipMapCount;
	DWORD	dwReserved1[11];
	DWORD	dwPfSize;	// == 32
	DWORD	dwPfFlags;	
	DWORD	dwFourCC;	
	DWORD	dwRGBBitCount;	
	DWORD	dwRBitMask;	// 
	DWORD	dwGBitMask;	// 
	DWORD	dwBBitMask;	// 
	DWORD	dwRGBAlphaBitMask;	
	DWORD	dwCaps;		// 
	DWORD	dwCaps2;	// 
	DWORD	dwReservedCaps[2];
	DWORD	dwReserved2;
} MYDDS;

#define DDSD_CAPS  0x00000001  
#define DDSD_HEIGHT  0x00000002  
#define DDSD_WIDTH  0x00000004  
#define DDSD_PITCH  0x00000008  
#define DDSD_PIXELFORMAT  0x00001000  
#define DDSD_MIPMAPCOUNT  0x00020000 
#define DDSD_LINEARSIZE  0x00080000  
#define DDSD_DEPTH  0x00800000  

#define DDPF_ALPHAPIXELS  0x00000001 
#define DDPF_RGB  0x00000040 


@implementation CMyDDS

-(id)init
{
	if (self = [super init])
	{
		m_loadFlag = NO;
		m_size.width = 0;
		m_size.height = 0;
		m_data = NULL;
		m_ddsHeader = malloc(128);
	}
	
	return self;
}

-(id)initByDDSFile:(char*)filenameonly
{
	if (self = [super init])
	{
		m_loadFlag = NO;
		m_size.width = 0;
		m_size.height = 0;
		m_data = NULL;
		m_ddsHeader = malloc(128);
		
		m_loadFlag = [self loadDDS:filenameonly];
	}
	
	return self;
}

-(id)initByDDSZFile:(char*)filenameonly
{
	if (self = [super init])
	{
		m_loadFlag = NO;
		m_size.width = 0;
		m_size.height = 0;
		m_data = NULL;
		m_ddsHeader = malloc(128);

		m_loadFlag = [self loadDDSZ:filenameonly];
	}
	
	return self;
}

-(id)initByDDSZFile:(char*)filenameonly dir:(char*)dir
{
	if (self = [super init])
	{
		m_loadFlag = NO;
		m_size.width = 0;
		m_size.height = 0;
		m_data = NULL;
		m_ddsHeader = malloc(128);
		
		m_loadFlag = [self loadDDSZ:filenameonly dir:dir];
	}
	
	return self;
}

-(BOOL)loadDDS:(char *)filenameonly
{
	NSString* realfilename = [NSString stringWithFormat:@"%s",filenameonly];
	
	NSString* path		= [[NSBundle mainBundle] pathForResource: realfilename ofType: @"dds"];
	const char *fpath	= [path cStringUsingEncoding: NSUTF8StringEncoding];
	
	FILE* file = NULL;
	file = fopen(fpath,"rb");
	if (file != NULL)
	{
//		NSLog(@"-------------open dds ok--------------");
		MYDDS* lpddsHeader = (MYDDS*)m_ddsHeader;
		
		fread(lpddsHeader,sizeof(MYDDS),1,file);
		int width = lpddsHeader->dwWidth;
		int height = lpddsHeader->dwHeight;
		if (m_data != NULL)
		{
			free(m_data);
			m_data = NULL;
		}
		m_size.width = width;
		m_size.height = height;
		m_data = (int*)malloc(width*height*sizeof(int));
		
		fread(m_data,sizeof(int),width*height,file);
		fclose(file);
	}
	else 
	{
		NSLog(@"open dds error");
		return NO;
	}
	
	return YES;
}

#define INBUFSIZ 4096


-(BOOL)loadDDSZ:(char *)filenameonly
{
	return [self loadDDSZ:filenameonly dir:NULL];
}

-(BOOL)loadDDSZ:(char*)filenameonly dir:(char*)dir
{
	NSString* realfilename = [NSString stringWithFormat:@"%s",filenameonly];
	NSString* path;
	
	if (dir == NULL)
	{
		path		= [[NSBundle mainBundle] pathForResource: realfilename ofType: @"dds.gz"];
	}
	else 
	{
		NSString* dirname =[NSString stringWithFormat:@"%s",dir];
		path		= [[NSBundle mainBundle] pathForResource: realfilename ofType: @"dds.gz" inDirectory:dirname];
		 
	}

	const char *fpath	= [path cStringUsingEncoding: NSUTF8StringEncoding];
	
//	char inbuf[INBUFSIZ];
//	NSLog(@"loaddds start!");
	
	
	gzFile gzInFile = gzopen(fpath,"rb");
	if (gzInFile == NULL) 
	{
		NSLog(@"loaddds not found %s",fpath);
		return NO;
	}
	
	MYDDS* lpddsHeader = (MYDDS*)m_ddsHeader;
	int readHeaderSize = gzread(gzInFile, lpddsHeader, 128);
	if (readHeaderSize < 128)
	{
		NSLog(@"loaddds bad dds %s",fpath);
		return NO;
	}
	
	
	int width = lpddsHeader->dwWidth;
	int height = lpddsHeader->dwHeight;
	if (m_data != NULL)
	{
		free(m_data);
		m_data = NULL;
	}
	m_size.width = width;
	m_size.height = height;
	
	m_data = (int*)malloc(width*height*sizeof(int)+128);
	gzread(gzInFile, m_data,width*height*sizeof(int));

	gzclose(gzInFile);
	
//	NSLog(@"LoadDDSZ:size= %d %d",width,height);
	return YES;
	
/*	
	
	
	
	z_stream z; 	
	
    z.zalloc = Z_NULL;
    z.zfree = Z_NULL;
    z.opaque = Z_NULL;	
	
    z.next_in = Z_NULL;
    z.avail_in = 0;	
	
	if (inflateInit(&z) != Z_OK) 
	{
		NSLog(@"zlib init error");
		return NO;
    
	}
	
	FILE* file = NULL;
	file = fopen(fpath,"rb");
	if (file == NULL)
	{
		NSLog(@"loadddsz file not found:%s",filenameonly);
		return NO;
	}
	
	int width = 1;
	int height = 1;
//	int* buf = NULL;
	
	int count,status;
	if (file != NULL)
	{
		
		
		MYDDS* lpddsHeader = (MYDDS*)m_ddsHeader;
		z.next_out = (Bytef*)lpddsHeader;
		z.avail_out = 128;
		status = Z_OK;
		
		BOOL headerLoadFlag = NO;
		
		while (status != Z_STREAM_END) 
		{
			if (z.avail_in == 0) 
			{
				z.next_in = (Bytef*)inbuf;
				z.avail_in = fread(inbuf, 1, INBUFSIZ, file);
			}
			
			status = inflate(&z, Z_NO_FLUSH);
			if (status == Z_STREAM_END) break;
			
			if (status != Z_OK)
			{
				NSLog(@"zlib status error != Z_OK");
				//				fprintf(stderr, "inflate: %s¥n", (z.msg) ? z.msg : "???");
				//				exit(1);
				break;//error
			}
			
			if (z.avail_out == 0)
			{
				if (!headerLoadFlag)
				{
					width = lpddsHeader->dwWidth;
					height = lpddsHeader->dwHeight;
					free(m_data);
					m_size.width = width;
					m_size.height = height;
					
					m_data = (int*)malloc(width*height*sizeof(int)+128);
					
					z.next_out = (Bytef*)m_data;
					z.avail_out = width * height * sizeof(int)+128;
					
					headerLoadFlag = YES;
				}
				else 
				{
					//next?
				}
			}
		}
		
		int sz = width * height * sizeof(int)+128;
		
		if ((count = sz - z.avail_out) != 0) 
		{
			//nokori?
		}
		
		if (inflateEnd(&z) != Z_OK) 
		{
			//error
			//fprintf(stderr, "inflateEnd: %s¥n", (z.msg) ? z.msg : "???");
			//			exit(1);
		}
		fclose(file);
	}
	
	return YES;
 */
	
}

-(CGSize)getSize
{
	return m_size;
}

-(int*)getData
{
	return m_data;
}


-(void)dealloc
{
	if (m_data != NULL)
	{
		free(m_data);
		m_data = NULL;
	}
	if (m_ddsHeader != NULL)
	{
		free(m_ddsHeader);
		m_ddsHeader = NULL;
	}
	
//	[super dealloc];
}

@end
