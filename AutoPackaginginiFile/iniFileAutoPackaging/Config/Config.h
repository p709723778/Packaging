//
//  Config.m
//
//
//  Created by 马 涛 on 13-5-31.
//  Copyright (c) 2013年 matao.ct@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject


+(Config *)shareConfig;

-(NSString *)channelString;
-(NSString *)heartString;
-(NSString *)serverString;

@end
