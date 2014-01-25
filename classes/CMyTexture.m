//
//  CMyTexture.m
//  TinyanGraphicsFramework
//
//  Created by たいにゃん on 09/10/29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CMyTexture.h"
#import "CMyDDS.h"
#import "CMyPVR.h"

/*
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
*/

float m_glVersion = 2.0;

GLuint m_textureUnitTable[]=
{
	GL_TEXTURE0,GL_TEXTURE1,GL_TEXTURE2,GL_TEXTURE3,GL_TEXTURE4,GL_TEXTURE5,GL_TEXTURE6,GL_TEXTURE7,
	GL_TEXTURE8,GL_TEXTURE9,GL_TEXTURE10,GL_TEXTURE11,GL_TEXTURE12,GL_TEXTURE13,GL_TEXTURE14,GL_TEXTURE15
};

@implementation CMyTexture



-(id)initBySize:(int)size
{
	if (self = [super init])
	{
		m_textureSize = size;

		m_divmulX = 1.0f / (float)m_textureSize;
		m_divmulY = 1.0f / (float)m_textureSize;
	
		CGRect rc = [UIScreen mainScreen].bounds;
		int screenSizeX = rc.size.width;
		int screenSizeY = rc.size.height;
	
		m_screenSize.width = screenSizeX;
		m_screenSize.height = screenSizeY;
	
		m_format = GL_RGBA;
		GLenum srcFormat = GL_RGBA;

		glGenTextures(1,&m_textureNumber);
	
//		printf("[genTex:%d]",m_textureNumber);
	
		glBindTexture(GL_TEXTURE_2D, m_textureNumber);
	
		unsigned char* buf = (unsigned char*)malloc(size*size*4);
//	for (int i=0;i<size*size*4;i++)
//	{
//		buf[i] = i;
//	}
	
		glTexImage2D(GL_TEXTURE_2D,0,m_format,size,size,0,srcFormat,GL_UNSIGNED_BYTE,buf);
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER,GL_NEAREST);
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,GL_NEAREST);
	
		free(buf);
	
//	printf("abcde-Debug");
//	printf("abcde-Release");
	
	}
	
	return self;
}

-(id)initBySize:(int)sizeX :(int)sizeY
{
	if (self = [super init])
	{
		m_textureSize = sizeY;
	
		m_divmulX = 1.0f / (float)sizeX;
		m_divmulY = 1.0f / (float)sizeY;
	
		CGRect rc = [UIScreen mainScreen].bounds;
		int screenSizeX = rc.size.width;
		int screenSizeY = rc.size.height;
	
		m_screenSize.width = screenSizeX;
		m_screenSize.height = screenSizeY;
	
		m_format = GL_RGB;
		GLenum srcFormat = GL_RGB;
	
		glGenTextures(1,&m_textureNumber);
	
//		printf("[genTex:%d]",m_textureNumber);
	
		glBindTexture(GL_TEXTURE_2D, m_textureNumber);
	
		unsigned char* buf = (unsigned char*)malloc(sizeX*sizeY*4);
	//	for (int i=0;i<size*size*4;i++)
	//	{
	//		buf[i] = i;
	//	}
	
		glTexImage2D(GL_TEXTURE_2D,0,m_format,sizeX,sizeY,0,srcFormat,GL_UNSIGNED_BYTE,buf);
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER,GL_NEAREST);
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,GL_NEAREST);
	
		free(buf);
	
	//	printf("abcde-Debug");
	//	printf("abcde-Release");
	
	}
	
	return self;
}


-(id)initByPVR:(char*)filename
{
	if (self = [super init])
	{
		CMyPVR* pvr = [[CMyPVR alloc]init];

		[pvr loadPVR:filename];
		m_textureSize = [pvr getSize];
			
		m_divmulX = 1.0f / (float)m_textureSize;
		m_divmulY = 1.0f / (float)m_textureSize;
	
		CGRect rc = [UIScreen mainScreen].bounds;
		int screenSizeX = rc.size.width;
		int screenSizeY = rc.size.height;
	
		m_screenSize.width = screenSizeX;
		m_screenSize.height = screenSizeY;
	
		glGenTextures(1,&m_textureNumber);
		if ([pvr setTexture:m_textureNumber])
		{
//			NSLog(@"pvr tecture set ok...");
		}
	
		//??
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER,GL_NEAREST);
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,GL_NEAREST);
	
//		[pvr release];
	}
	
	return self;
}


+(void)setGLVersion:(float)ver
{
	m_glVersion = ver;
}

-(int)LoadMipmapDDSZ:(char*)filename
{
	CMyDDS* dds = [[CMyDDS alloc]initByDDSZFile:filename];
	CGSize ddsSize = [dds getSize];
	glBindTexture(GL_TEXTURE_2D,m_textureNumber);
	
	GLenum srcFormat = GL_RGBA;
	
	int* ddsBuffer = [dds getData];
	int sizeX = ddsSize.width;
	int sizeY = ddsSize.height;

	glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA,sizeX,sizeY,0,srcFormat,GL_UNSIGNED_BYTE,ddsBuffer);

	
	//check size 2^n
	int checkX = sizeX;
	int checkY = sizeY;
	BOOL flg = YES;
	
	while ((checkX > 1) || (checkY > 1))
	{
		if ((checkX > 1) && ((checkX & 1) != 0))
		{
			flg = NO;
			break;
		}
		
		if ((checkY > 1) && ((checkY & 1) != 0))
		{
			flg = NO;
			break;
		}
		
		checkX >>= 1;
		checkY >>= 1;
	}

	if (flg == NO)
	{
		NSLog(@"bad mipmap texture size not 2 power n sizeX=%d sizeY=%d",sizeX,sizeY);
//		[dds release];
		return m_textureNumber;
	}
	
	
	int mipmapLevel = 1;
	int* tmp1 = ddsBuffer;
	int* tmp2 = NULL;
	
	while ((sizeX > 1) || (sizeY > 1))
	{
		int nextSizeX = sizeX / 2;
		int nextSizeY = sizeY / 2;
		int mulX = 2;
		int mulY = 2;
		
		if (nextSizeX <= 0)
		{
			mulX = 1;
			nextSizeX = 1;
		}
		
		if (nextSizeY <= 0)
		{
			mulY = 1;
			nextSizeY = 1;
		}
		
		tmp2 = (int*)malloc(nextSizeX*nextSizeY*sizeof(int));
		//tmp1->tmp2
		for (int j=0;j<nextSizeY;j++)
		{
			for (int i=0;i<nextSizeX;i++)
			{
				int a = 0;
				int r = 0;
				int g = 0;
				int b = 0;
				int k = 0;
				
				
				for (int jj=0;jj<mulY;jj++)
				{
					for (int ii=0;ii<mulX;ii++)
					{
						
						int d = *(tmp1+i*mulX+ii + (j*mulY+jj) * sizeX);
						int aa = (d >> 24) & 0xff;
						int bb = (d >> 16) & 0xff;
						int gg = (d >> 8) & 0xff;
						int rr = (d) & 0xff;
						
//						if (mipmapLevel == 1)
//						{
//							if ((i==120) && (j==120))
//							{
//								NSLog(@"%d %d %d %d %d",d,rr,gg,bb,aa);
//							}
//						}
//
						if (aa > 0)
						{
							r += rr*aa;
							g += gg*aa;
							b += bb*aa;
							a += aa;
							
							k++;
						}
					}
				}
				
				if (k>0)
				{
					r /= a;
					g /= a;
					b /= a;
					a /= (mulX*mulY);
				}

				int col = (a << 24) | (b << 16) | (g << 8) | r;
				*(tmp2 + i + j * nextSizeX) = col;
			}
		}
		
		
		
		
		if (mipmapLevel > 1)
		{
			free(tmp1);
		}
		tmp1 = tmp2;

		glTexImage2D(GL_TEXTURE_2D,mipmapLevel,GL_RGBA,nextSizeX,nextSizeY,0,srcFormat,GL_UNSIGNED_BYTE,tmp1);
		
		sizeX /= 2;
		sizeY /= 2;
		mipmapLevel++;
	}
	
	if (tmp2 != NULL)
	{
		free(tmp2);
	}
		
//	[dds release];
	return m_textureNumber;
}


-(int)LoadDDSZ:(char*)filename dir:(char*)dir
{
	CGPoint setPoint = CGPointMake(0,0);
	return [self LoadDDSZ:filename atPoint:setPoint dir:dir];
}

-(int)LoadDDSZ:(char*)filename atPoint:(CGPoint)setPoint
{
	return [self  LoadDDSZ:filename atPoint:setPoint dir:NULL];
}

-(int)LoadDDSZ:(char*)filename
{
	CGPoint setPoint = CGPointMake(0,0);
	return [self LoadDDSZ:filename atPoint:setPoint dir:NULL];
}

#define INBUFSIZ 4096

-(int)LoadDDSZ:(char*)filename atPoint:(CGPoint)setPoint dir:(char*)dir;
{
	

	CMyDDS* dds = [[CMyDDS alloc]initByDDSZFile:filename dir:dir];
	CGSize ddsSize = [dds getSize];
	glBindTexture(GL_TEXTURE_2D,m_textureNumber);
	CGRect rc = CGRectMake(setPoint.x,setPoint.y,ddsSize.width,ddsSize.height);
	int* ddsBuffer = [dds getData];
	[self replaceRect:rc data:ddsBuffer];
//	[dds release];
	return m_textureNumber;
	
	
	/*
	 
	NSString* realfilename = [NSString stringWithFormat:@"%s",filename];
	
	NSString* path		= [[NSBundle mainBundle] pathForResource: realfilename ofType: @"dds.gz"];
	const char *fpath	= [path cStringUsingEncoding: NSUTF8StringEncoding];
	
	char inbuf[INBUFSIZ];
	
	z_stream z; 	
	
    z.zalloc = Z_NULL;
    z.zfree = Z_NULL;
    z.opaque = Z_NULL;	
	
    z.next_in = Z_NULL;
    z.avail_in = 0;	
	
    if (inflateInit(&z) != Z_OK) 
	{
		return m_textureNumber;//error!!
    }
	
	FILE* file = NULL;
	file = fopen(fpath,"rb");

	int width = 1;
	int height = 1;
	int* buf = NULL;
	
	int count,status;
	if (file != NULL)
	{
	
	
		MYDDS ddsHeader;
		z.next_out = (Bytef*)&ddsHeader;
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
//				fprintf(stderr, "inflate: %s¥n", (z.msg) ? z.msg : "???");
//				exit(1);
				break;//error
			}
			
			if (z.avail_out == 0)
			{
				if (!headerLoadFlag)
				{
					width = ddsHeader.dwWidth;
					height = ddsHeader.dwHeight;
					buf = (int*)malloc(width*height*sizeof(int)+128);
					
					z.next_out = (Bytef*)buf;
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
		
		glBindTexture(GL_TEXTURE_2D,m_textureNumber);
		CGRect rc = CGRectMake(setPoint.x,setPoint.y,width,height);
		[self replaceRect:rc data:buf];
		
		free(buf);
		
	}
	
	return m_textureNumber;
	*/
}


-(int)LoadDDS:(char*)filename
{
	CGPoint setPoint = CGPointMake(0,0);
	return [self LoadDDS:filename atPoint:setPoint];
}

-(int)LoadDDS:(char*)filename atPoint:(CGPoint)setPoint
{
	CMyDDS* dds = [[CMyDDS alloc]initByDDSFile:filename];
	CGSize ddsSize = [dds getSize];
	glBindTexture(GL_TEXTURE_2D,m_textureNumber);
	CGRect rc = CGRectMake(setPoint.x,setPoint.y,ddsSize.width,ddsSize.height);
	int* ddsBuffer = [dds getData];
	[self replaceRect:rc data:ddsBuffer];
//	[dds release];
	return m_textureNumber;

	/*
	NSString* realfilename = [NSString stringWithFormat:@"%s",filename];

	NSString* path		= [[NSBundle mainBundle] pathForResource: realfilename ofType: @"dds"];
	const char *fpath	= [path cStringUsingEncoding: NSUTF8StringEncoding];

	FILE* file = NULL;
	file = fopen(fpath,"rb");
	if (file != NULL)
	{
		NSLog(@"-------------open dds ok--------------");
		MYDDS ddsHeader;
		fread(&ddsHeader,sizeof(MYDDS),1,file);
		int width = ddsHeader.dwWidth;
		int height = ddsHeader.dwHeight;
		int* buf = (int*)malloc(width*height*sizeof(int));
		fread(buf,sizeof(int),width*height,file);
		fclose(file);
		
		glBindTexture(GL_TEXTURE_2D,m_textureNumber);
		CGRect rc = CGRectMake(setPoint.x,setPoint.y,width,height);
		[self replaceRect:rc data:buf];
		
		free(buf);
		
		
	}
	else 
	{
		NSLog(@"open dds error");
	}
	
//	CFURLRef fileURL	= CFURLCreateFromFileSystemRepresentation (NULL, (const UInt8 *)fpath, strlen(fpath), false);
//	/alBuffer = GetOpenALAudioData(fileURL, extension,&alBufferLen, &alFormatBuffer, &alFreqBuffer);
//	CFRelease(fileURL);

	return m_textureNumber;
//	return 1;
	 */
	
}

-(int)LoadPng:(char*)filename
{
	CGPoint setPoint = CGPointMake(0,0);
	return [self LoadPng:filename atPoint:setPoint];
}




-(int)LoadPng:(char*)filename atPoint:(CGPoint)setPoint
{
	return [self LoadPngRoutine:filename atPoint:setPoint maskFlag:NO maskColor:0];
	/*
	return [self LoadPngAutoMask:filename atPoint:setPoint ma
	NSString* realfilename = [NSString stringWithFormat:@"%s",filename];
	UIImage* image = [UIImage imageNamed:realfilename];
//	int rt = [self fromImage:image atPoint:setPoint];
	int rt [self fromImageRoutine image atPoint:setPoint maskFlag:NO maskColor:0];
	

	[image release];
	return rt;
	 */
	
}

-(int)fromImage:(UIImage*)image atPoint:(CGPoint)setPoint
{
	return [self fromImageRoutine:image  atPoint:setPoint maskFlag:NO maskColor:0];
}

-(int)LoadPngAutoMask:(char*)filename atPoint:(CGPoint)setPoint maskColor:(int)maskColor
{
	return [self LoadPngRoutine:filename atPoint:setPoint maskFlag:YES maskColor:maskColor];
}

			
-(int)LoadPngRoutine:(char*)filename atPoint:(CGPoint)setPoint maskFlag:(BOOL)maskFlag maskColor:(int)maskColor
{
	NSString* realfilename = [NSString stringWithFormat:@"%s",filename];
	UIImage* image = [UIImage imageNamed:realfilename];
	//	int rt = [self fromImage:image atPoint:setPoint];
	int rt = [self fromImageRoutine:image atPoint:setPoint maskFlag:maskFlag maskColor:maskColor];
	
	
//	[image release];
	return rt;

}

-(int)fromImageRoutine:(UIImage*)image atPoint:(CGPoint)setPoint maskFlag:(BOOL)maskFlag maskColor:(int)maskColor
{
	glBindTexture(GL_TEXTURE_2D,m_textureNumber);
	
//	NSString* realfilename = [NSString stringWithFormat:@"%s",filename];
//	UIImage* image = [UIImage imageNamed:realfilename];
	CGImageRef inputImage = [image CGImage];	
	CFDataRef inputData = CGDataProviderCopyData(CGImageGetDataProvider(inputImage));
	unsigned char* ptr = (unsigned char*)CFDataGetBytePtr(inputData);
	
	//size_t bitsPerComponet = CGImageGetBitsPerComponent(inputImage);
	size_t bitsPerPixel = CGImageGetBitsPerPixel(inputImage);
	size_t bytesPerRow = CGImageGetBytesPerRow(inputImage);
	//	CGColorSpaceRef colorSpace = CGImageGetColorSpace(inputImage);
	CGBitmapInfo bmi = CGImageGetBitmapInfo(inputImage);
	//CGImageAlphaInfo alfa = CGImageGetAlphaInfo(inputImage);
	
	
	int width = (int)CGImageGetWidth(inputImage);
	int height = (int)CGImageGetHeight(inputImage);
	
	unsigned char* buf = (unsigned char*)malloc(width * height * 4);
	
//	printf("[fromImage bits:%d x:%d y:%d]",(int)bitsPerPixel,width,height);
	
	
	int srcMulti = 4;
	if (bitsPerPixel == 24)
	{	
		srcMulti = 3;
//		printf("[srcMulti = 3");
	}


	unsigned char maskR = (unsigned char)((maskColor >> 16) & 0xff);
	unsigned char maskG = (unsigned char)((maskColor >> 8) & 0xff);
	unsigned char maskB = (unsigned char)((maskColor ) & 0xff);
	
	
//	GLenum srcFormat = GL_RGBA;
	
	
	int byte0 = 0;
	int byte1 = 1;
	int byte2 = 2;
	int byte3 = 3;
	
	int alfaEnable = 1;
	
	if ((bmi & kCGBitmapByteOrderMask) == kCGBitmapByteOrder32Little)
	{
//		printf("[byteOrder32Little]");

		byte0 = 3;
		byte1 = 2;
		byte2 = 1;
		byte3 = 0;
	}
	
	int rOffset = byte0;
	int gOffset = byte1;
	int bOffset = byte2;
	int aOffset = byte3;
	
	
	if ((bmi & kCGBitmapAlphaInfoMask) == kCGImageAlphaNone)
	{
		printf("[bmi=RGB]");
		rOffset = byte0;
		gOffset = byte1;
		bOffset = byte2;
		alfaEnable = 0;
		
//		aOffset = 3;
	}
	
	if ((bmi & kCGBitmapAlphaInfoMask) == kCGImageAlphaPremultipliedLast)
	{
//		printf("[bmi=pmRGBA]");
		rOffset = byte0;
		gOffset = byte1;
		bOffset = byte2;
		aOffset = byte3;
	}
	
	if ((bmi & kCGBitmapAlphaInfoMask) == kCGImageAlphaPremultipliedFirst)
	{
//		printf("[bmi=pmARGB]");
		rOffset = byte1;
		gOffset = byte2;
		bOffset = byte3;
		aOffset = byte0;
		
	}
	
	if ((bmi & kCGBitmapAlphaInfoMask) ==kCGImageAlphaLast)
	{
//		printf("[bmi=RGBA]");
		rOffset = byte0;
		gOffset = byte1;
		bOffset = byte2;
		aOffset = byte3;
		
	}
	
	if ((bmi & kCGBitmapAlphaInfoMask) == kCGImageAlphaFirst)
	{
//		printf("[bmi=ARGB]");
		rOffset = byte1;
		gOffset = byte2;
		bOffset = byte3;
		aOffset = byte0;
		
	}
	
	if ((bmi & kCGBitmapAlphaInfoMask) == kCGImageAlphaNoneSkipLast)
	{
//		printf("[bmi=RGBX]");
		rOffset = byte0;
		gOffset = byte1;
		bOffset = byte2;
		alfaEnable = 0;
		
//		aOffset = 3;
		
	}
	
	if ((bmi & kCGBitmapAlphaInfoMask) == kCGImageAlphaNoneSkipFirst)
	{
//		printf("[bmi=XRGB]");
		rOffset = byte1;
		gOffset = byte2;
		bOffset = byte3;
		alfaEnable = 0;
		
//		aOffset = 3;
		
	}
	
	if ((bmi & kCGBitmapAlphaInfoMask) == kCGImageAlphaOnly)
	{
//		printf("[bmi=alfa]");
		aOffset = byte0;
	}
	
	
	
	//	srcMulti = 3;	
//	int textureWidth = m_textureSize;
	
	//@@	int dstOffset = (pt.x + pt.y * textureWidth) * 4;
	
	int setX = (int)(setPoint.x + 0.1f);
	int setY = (int)(setPoint.y + 0.1f);
	
	for (int j=0;j<height;j++)
	{
		int dstY = j ;
//		printf("*");
		for (int i=0;i<width;i++)
		{
			int dstX = i;
			
			unsigned char r = ptr[(i*srcMulti+j*bytesPerRow)+rOffset];
			unsigned char g = ptr[(i*srcMulti+j*bytesPerRow)+gOffset];
			unsigned char b = ptr[(i*srcMulti+j*bytesPerRow)+bOffset];
			
			//			int dst = (dstX + dstY * textureWidth)*4 + dstOffset;
			int dst = (dstX  + dstY * width)*4;
			

			unsigned char alfa = 255;
			if ((srcMulti == 3) || (alfaEnable == 0))
			{
				//
			}
			else 
			{
				alfa = ptr[(i*srcMulti+j*bytesPerRow)+aOffset];
			}
	
			if (maskFlag)
			{
				
				if ((maskR == r) && (maskG == g) && (maskB == b))
				{
					alfa = 0;
				}
			}

			if (alfa > 0)
			{
				unsigned int r2 = (unsigned int)r;
				unsigned int g2 = (unsigned int)g;
				unsigned int b2 = (unsigned int)b;
				
				r2 *= 255;
				r2 /= alfa;
				g2 *= 255;
				g2 /= alfa;
				b2 *= 255;
				b2 /= alfa;
				
				r = r2;
				g = g2;
				b = b2;
			}
			buf[dst + 0] = r;
			buf[dst + 1] = g;
			buf[dst + 2] = b;
			
			buf[dst+3] = alfa;
		}
	}
	
//	printf("[loadpng]");
	
	
	CGRect rc = CGRectMake(setX,setY,width,height);
	
//	printf("[replace]");
	[self replaceRect:rc data:buf];
	

//	printf("[free]");
	free(buf);

//	printf("[cfrelease]");
	CFRelease(inputData);
	
	
	return m_textureNumber;
}


-(void)replaceRect:(CGRect)rect data:(void*)data
{
	glTexSubImage2D(GL_TEXTURE_2D,0, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height,m_format,GL_UNSIGNED_BYTE,data);
}

-(GLfloat)x2u:(int)x
{
	GLfloat u = (GLfloat)x;
	u *= m_divmulX;
	return u;
}

-(GLfloat)y2v:(int)y
{
	GLfloat v = (GLfloat)y;
	v *= m_divmulY;
	return v;
}


-(CGPoint) xy2uv:(CGPoint)pt
{
	CGPoint pt2;
	
	pt2.x = pt.x * m_divmulX;
	pt2.y = pt.y * m_divmulY;
	
	return pt2;
}

-(void)bindTexture
{
	glBindTexture(GL_TEXTURE_2D, m_textureNumber);
	glEnable(GL_TEXTURE_2D);
}

-(void)bindTexture:(int)n
{
	[self activeTexture:n];
	glBindTexture(GL_TEXTURE_2D, m_textureNumber);
	glEnable(GL_TEXTURE_2D);
}

-(void)activeTexture
{
	[self activeTexture:0];
}

-(void)activeTexture:(int)n
{
	glActiveTexture(m_textureUnitTable[n]);
}


-(void)stretchBlt:(CGPoint)dst src:(CGPoint)src size:(CGSize)size srcSize:(CGSize)srcSize
{
	float uv[8];
	float xy[8];
	
	float yy = m_screenSize.height;
	
	float uvSizeX = srcSize.width / m_textureSize;
	float uvSizeY = srcSize.height / m_textureSize;
	
	float sizeX = size.width / (m_screenSize.width / 2);
//	float sizeY = size.height / (m_screenSize.width / 2);
	float sizeY = size.height / (yy / 2);
	
	float putX = dst.x - m_screenSize.width / 2;
	float putY = -(dst.y - (yy/2));
	putX /= (m_screenSize.width / 2);
	putY /= (yy / 2);
	
	xy[0] = putX;
	xy[1] = putY;
	xy[2] = putX + sizeX;
	xy[3] = putY;
	xy[4] = putX;
	xy[5] = putY - sizeY;
	xy[6] = putX + sizeX;
	xy[7] = putY - sizeY;
	
	float u1 = src.x / m_textureSize;
	float u2 = u1 + uvSizeX;
	float v1 = src.y / m_textureSize;
	float v2 = v1 + uvSizeY;
	
	uv[0] = u1;
	uv[1] = v1;
	uv[2] = u2;
	uv[3] = v1;
	uv[4] = u1;
	uv[5] = v2;
	uv[6] = u2;
	uv[7] = v2;

	if (m_glVersion < 2.0)
	{
		glVertexPointer(2, GL_FLOAT, 0, xy);
		glEnableClientState(GL_VERTEX_ARRAY);
		
		glTexCoordPointer(2,GL_FLOAT,0,uv);
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	}
	else 
	{
		/*
		static int aaa = 0;
		if (aaa == 0)
		{
			aaa = 1;
			for (int i=0;i<8;i++)
			{
				NSLog(@"texuv %d = %f",i,uv[i]);
			}
			NSLog(@"texsize = %d screenSize=%d %d",m_textureSize,(int)m_screenSize.width,(int)m_screenSize.height);
		}
		 */
		
		
		glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, xy);
		glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, uv);
		
		glEnableVertexAttribArray(0);
		glEnableVertexAttribArray(1);
		
	}

	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	
}

-(void)polygon:(int)n vertex:(float*)vertex tex:(float*)tex
{
	float xy[16*2];
	float uv[16*2];
	
	float xx = m_screenSize.width;
	float yy = m_screenSize.height;
	
	float uvDivMulX = 1.0f / m_textureSize;
	float uvDivMulY = 1.0f / m_textureSize;
	
	float divmulxx2 = 2.0f / xx;
	float divmulyy2 = 2.0f / yy;
	
	float centerX = xx * 0.5f;
	float centerY = yy * 0.5f;
	if (n>16)
	{
		n = 16;
	}
	if (n < 3) return;
	
	for (int i=0;i<n;i++)
	{
		xy[i*2] = (vertex[i*2] - centerX) * divmulxx2;
		xy[i*2+1] = -(vertex[i*2+1] - centerY) * divmulyy2;
		uv[i*2] = tex[i*2] * uvDivMulX;
		uv[i*2+1] = tex[i*2+1] * uvDivMulY;
		
	}
	
	glVertexPointer(2, GL_FLOAT, 0, xy);
	glEnableClientState(GL_VERTEX_ARRAY);
	
	glTexCoordPointer(2,GL_FLOAT,0,uv);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glDrawArrays(GL_TRIANGLE_FAN, 0, n);
}


-(void)setScreenSize:(CGSize)size
{
	m_screenSize = size;
}

-(GLuint)getTextureNumber
{
	return m_textureNumber;
}

-(void)dealloc
{
	
//	[super dealloc];
}

@end
