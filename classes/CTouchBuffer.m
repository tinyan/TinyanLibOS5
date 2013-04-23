//
//  CTouchBuffer.m
//  nohint
//
//  Created by たいにゃん on 12/07/10.
//
//

#import "CTouchBuffer.h"

@implementation CTouchBuffer

-(id)init
{
    self = [super init];
    if (self)
    {
        m_number = 0;
        m_numberMax = 10;
        m_point = (CGPoint*)malloc(sizeof(CGPoint) * m_numberMax);
    }
    
    
    return self;
}

-(void)clear
{
    m_number = 0;
}

-(void)addTouchStart:(CGPoint)point
{
    if (m_number >= m_numberMax)
    {
        //shift
        for (int i=0;i<m_numberMax-1;i++)
        {
            m_point[i] = m_point[i+1];
        }
        
        m_number--;
    }
    m_point[m_number] = point;
    m_number++;
}



-(int)getNumber
{
    return m_number;
}

-(CGPoint)getPoint:(int)n
{
    CGPoint pt = CGPointMake(-1,-1);
    if (n < m_number)
    {
        pt = m_point[n];
    }
    
    return pt;
}


-(void)dealloc
{
    free(m_point);
}


@end
