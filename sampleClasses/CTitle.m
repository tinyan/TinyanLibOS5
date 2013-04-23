//
//  CTitle.m
//
//  Created by たいにゃん on 12/06/21.
//
//

#import "../../TinyanLibOS5/classes/CMyTexture.h"
#import "../../TinyanLibOS5/classes/CMyShader.h"

#import "../../TinyanLibOS5/classes/CCommonGeneral.h"

#import "CTitle.h"
#import "../../TinyanLibOS5/classes/CCommonGame.h"
#import "CGame.h"

@implementation CTitle

-(id)init:(CGame*)lpGame
{
    self = [super init:lpGame];
    if (self)
    {
		m_game2 = lpGame;
        NSLog(@"title [self init]");
        
    }

        
        

    
    return self;
}


-(void)Init
{
    NSLog(@"CTitle::Init()");

//    CMyTexture* texture =[m_game2 getMyTexture:0];
//    [texture LoadDDSZ:"nohint_title"];
    
    
}

-(int)Calcu
{
//    if (m_clicked) return PLAY_MODE;
    
    return -1;
}

-(void)Print
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    
    CMyTexture* texture = [m_game2 getMyTexture:0];
    CMyShader* shader = [m_game2 getMyShader:0];
    CDrawBuffer* drawBuffer = [m_game2 getDrawBuffer];

    [drawBuffer set2D3D:2];
    
    GLuint activeTexture = 0;
    
	glActiveTexture(activeTexture);
	[texture bindTexture];
	
	[shader useProgram];
	
    
    static GLfloat mat[16] = {1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1};
	[shader setMatrix:mat];
	[shader setTexture:activeTexture];


	GLfloat vec0[8] = {-1.0,1.0, -1.0,-1.0, 1.0,1.0, 1.0,-1.0};
	GLfloat vec[8];
    float r = (rand() % 100);
    r += 1.0f;
    r /= 100.0f;
    
    r = 0.5f;
    
	for (int i=0;i<8;i++)
	{
		vec[i] = vec0[i] * r;
	}
	GLfloat uv[8] = {0,0, 0,0.75f, 1,0, 1,0.75f};

    [drawBuffer beginPrint];
    
    [drawBuffer addQuad:vec uv:uv];
    
    [drawBuffer endPrint];
}

-(void)FinalExitRoutine
{
}

-(void)NNNTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView*)view gamePoint:(CGPoint*)gamePoint
{
	NSLog(@"CTITLE:NNNTouchesBegin");
}

-(void)dummy
{
//    m_clicked = YES;
}


@end
