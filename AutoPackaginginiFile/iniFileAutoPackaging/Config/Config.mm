//
//  Config.m
//  
//
//  Created by 马 涛 on 13-5-31.
//  Copyright (c) 2013年 matao.ct@gmail.com. All rights reserved.
//

#import "Config.h"
#import "SimpleIni.h"

@implementation Config

static CSimpleIniA ini;


static Config *config;

+(Config *)shareConfig
{//单例
    @synchronized(self)
    {
        if (config == nil) {
            config = [[Config alloc] init] ;
            
            NSString *lrcPath = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"ini"];
            ini.SetUnicode();
            NSLog(@"lrcPath %@",lrcPath);
            ini.LoadFile([lrcPath UTF8String]);
        }
        
        return config;
    }
}


-(NSString *)channelString
{
    const char * pVal = ini.GetValue("Channel", "channel");
    return [NSString stringWithCString:pVal encoding:NSUTF8StringEncoding];
}

-(NSString *)serverString
{
    const char * pVal = ini.GetValue("Address", "server");
    return [NSString stringWithCString:pVal encoding:NSUTF8StringEncoding];
}

-(NSString *)heartString
{
    const char * pVal = ini.GetValue("Address", "heart");
    return [NSString stringWithCString:pVal encoding:NSUTF8StringEncoding];
}


@end
