//
//  CMyMachineModel.h
//  TinyanLib
//
//  Created by たいにゃん on 10/09/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#define MY_MACHINE_IPOD 1
#define MY_MACHINE_IPHONE 2
#define MY_MACHINE_IPAD 3

#define MY_MODEL_IPOD1 1
#define MY_MODEL_IPOD2 2
#define MY_MODEL_IPOD3 3
#define MY_MODEL_IPOD4 4

#define MY_MODEL_IPAD1 3
#define MY_MODEL_IPAD2 4
#define MY_MODEL_IPADMINI 4
#define MY_MODEL_NEWIPAD 5
#define MY_MODEL_IPAD4 6

//unknown
#define MY_MODEL_IPADMINI 4

#define MY_MODEL_IPHONE3G 2
#define MY_MODEL_IPHONE3GS 3
#define MY_MODEL_IPHONE4 4
#define MY_MODEL_IPHONE4S 5
#define MY_MODEL_IPHONE5 6




@interface CMyMachineModel : NSObject 
{

}

+(int)getModel;
+(int)getMachine;
+(float)getMaxScaleFactor;

//inner
+(void)checkMachine;
@end
