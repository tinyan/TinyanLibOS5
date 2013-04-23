//
//  CMyPVR.m
//  TinyanLib
//
//  Created by たいにゃん on 10/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//



#import "CMyPVR.h"

#define MY_PVR_FLAG_TYPE_PVRTC_2 24
#define MY_PVR_FLAG_TYPE_PVRTC_4 25
#define MY_PVR_FLAG_TYPE_MASK 0xff

#define MY_PVR_MAX_SURFACES 16

typedef struct _myPvrHeader
{
	uint32_t headerSize;
	uint32_t height;
	uint32_t width;
	uint32_t numMipmaps;
	uint32_t flags;
	uint32_t dataSize;
	uint32_t bpp;
	uint32_t bitmaskRed;
	uint32_t bitmaskGreen;
	uint32_t bitmaskBlue;
	uint32_t bitmaskAlpha;
	uint32_t tag;
	uint32_t numSurfaces;
} MY_PVR_HEADER;


@implementation CMyPVR

-(id)init
{
	self = [super init];
	if (self)
	{
		m_header = malloc(52);
		m_size = (GLuint*)malloc(sizeof(GLuint) * MY_PVR_MAX_SURFACES);
		m_offset = (int*)malloc(sizeof(int) * MY_PVR_MAX_SURFACES);
	}
	
	
	return self;
}

-(BOOL)loadPVR:(char *)filenameonly
{
	m_dataExistFlag = NO;
	
	NSString* realfilename = [NSString stringWithFormat:@"%s",filenameonly];
	
	NSString* path		= [[NSBundle mainBundle] pathForResource: realfilename ofType: @"pvr"];
	const char *fpath	= [path cStringUsingEncoding: NSUTF8StringEncoding];
	
	NSLog(@"loadPVR start!");
	
	
	FILE* file = fopen(fpath,"rb");
	if (file == NULL) 
	{
		NSLog(@"loadPVR not found %s",fpath);
		return NO;
	}
	
//	MY_PVR_HEADER header;
	
	int readHeaderSize = fread(m_header,sizeof(char),52,file);
	
	if (readHeaderSize < 52)
	{
		NSLog(@"loadPVR bad PVR %s",fpath);
		return NO;
	}
	
	fseek(file,0,SEEK_END);
	int fileSize = ftell(file);
	int dataSize = fileSize - 52;
	fseek(file,52,SEEK_SET);
	
	if (dataSize < 0) return NO;
	if (dataSize > m_bufferSizeMax)
	{
		free(m_buffer);
		m_buffer = malloc(dataSize);
		m_bufferSizeMax = dataSize;
	}
	m_bufferSize = dataSize;

	fread(m_buffer,sizeof(char),dataSize,file);
	
	fclose(file);

	//check header
	
	NSLog(@"PVR header tag check start ...");
	
	MY_PVR_HEADER* lpHeader = (MY_PVR_HEADER*)m_header;
	unsigned char* tag = (unsigned char*)(&(lpHeader->tag));
	if (tag[0] != 'P') return NO;
	if (tag[1] != 'V') return NO;
	if (tag[2] != 'R') return NO;
	if (tag[3] != '!') return NO;
	
	
	NSLog(@"PVR header tag check ok!");
	
	
	uint32_t flags       = OSSwapLittleToHostInt32(lpHeader->flags);
    uint32_t formatFlags = flags & MY_PVR_FLAG_TYPE_MASK;

    if((formatFlags != MY_PVR_FLAG_TYPE_PVRTC_4) && (formatFlags != MY_PVR_FLAG_TYPE_PVRTC_2)) return NO;
	NSLog(@"PVR flag is 2 or 4 ok!");

	GLuint bpp;
	
	
	
	int blockSizeX;
	int blockSizeY;
	
	if(formatFlags == MY_PVR_FLAG_TYPE_PVRTC_4)
	{
		m_format = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
		blockSizeX = 4;
		blockSizeY = 4;
		
		bpp = 4;
	}
	
	if(formatFlags == MY_PVR_FLAG_TYPE_PVRTC_2)
	{
		m_format = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
		blockSizeX = 8;
		blockSizeY = 4;
		
		bpp = 2;
	}
	
	int blockSize = blockSizeX * blockSizeY;
	

        
	m_width = OSSwapLittleToHostInt32(lpHeader->width);
	m_height = OSSwapLittleToHostInt32(lpHeader->height);
	
	if (OSSwapLittleToHostInt32(lpHeader->bitmaskAlpha))
	{
		m_alfaExistFlag = YES;
	}
	else 
	{
		m_alfaExistFlag = NO;
	}
	
	m_surfaceKosuu = 0;//start
        
	GLuint w = m_width;
	GLuint h = m_height;
	GLint offset = 0;
	GLuint size = OSSwapLittleToHostInt32(lpHeader->dataSize);

	
    while((offset < size) && (m_surfaceKosuu < MY_PVR_MAX_SURFACES))
	{
		GLuint   widthBlocks, heightBlocks;
		widthBlocks = w / blockSizeX;
		heightBlocks = h / blockSizeY;
            
		if (widthBlocks < 2) widthBlocks = 2;
		if (heightBlocks < 2) heightBlocks = 2;
		
		m_size[m_surfaceKosuu] = widthBlocks * heightBlocks * ((blockSize  * bpp) / 8);
		m_offset[m_surfaceKosuu] = offset;
            
//		w = (w >> 1) || 1;
//		h = (h >> 1) || 1;

		NSLog(@"texSize = %d x %d : %d bytes",w,h,m_size[m_surfaceKosuu]);
		
		w >>= 1;
		h >>= 1;
		if (w == 0) w = 1;
		if (h == 0) h = 1;
		
        offset += m_size[m_surfaceKosuu];

		m_surfaceKosuu++;
    }
	
	m_dataExistFlag = YES;

	return YES;
}

-(BOOL)setTexture:(GLuint)texture
{
	if (!m_dataExistFlag) return NO;

	glBindTexture(GL_TEXTURE_2D,texture);
	GLuint w = m_width;
	GLuint h = m_height;
	
	for (int i=0;i<m_surfaceKosuu;i++)
	{
		glCompressedTexImage2D(GL_TEXTURE_2D,i,m_format,w,h,0,m_size[i],m_buffer + m_offset[i]);
		
		w >>= 1;
		h >>= 1;
		if (w == 0) w = 1;
		if (h == 0) h = 1;
		
	}
	
	
	return YES;
}

-(BOOL)setNoMipmapTexture:(GLuint)texture
{
	if (!m_dataExistFlag) return NO;

	glBindTexture(GL_TEXTURE_2D,texture);
	glCompressedTexImage2D(GL_TEXTURE_2D,0,m_format,m_width,m_height,0,m_size[0],m_buffer);
	
	return YES;
}

			
-(int)getSize
{
	return m_width;
}


-(void)dealloc
{
	free(m_offset);
	free(m_size);
	free(m_header);
	free(m_buffer);
//	[super dealloc];
}

@end
