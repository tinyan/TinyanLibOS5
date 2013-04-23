//
//  CTouchBuffer.h
//  nohint
//
//  Created by たいにゃん on 12/07/10.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CTouchBuffer : NSObject
{
    int m_number;
    int m_numberMax;
    CGPoint* m_point;
}

-(id)init;

-(void)clear;
-(void)addTouchStart:(CGPoint)point;
-(int)getNumber;
-(CGPoint)getPoint:(int)n;

-(void)dealloc;


@end
