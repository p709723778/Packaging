//
//  ViewController.m
//  IniTestParser
//
//  Created by zhang on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "SimpleIni.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//  NSString *lrcPath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"ini"];
//    NSString * textContent = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"文件信息 = %@",textContent);
//    // 将字符串切割成数组
//    NSArray * tempArray=[textContent componentsSeparatedByString:@"\n"];
//       NSLog(@"tempArray========== %@",tempArray);
    
////读取
//    
//   NSString *lrcPath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"ini"];
//
//    CSimpleIniA ini;
//    
//    ini.SetUnicode();
//
//    ini.LoadFile([lrcPath UTF8String]);
//   
//    
//    const char * pVal = ini.GetValue("VersionSet", "Preview");
//    
//    NSLog(@"%@", [NSString stringWithCString:pVal encoding:NSUTF8StringEncoding]);
//    
//    ini.SetValue("section", "key", "newvalue");
// 
//
//     //获取所有的Section：
//    CSimpleIniA::TNamesDepend sections;  
//    ini.GetAllSections(sections);  
//    
//    
//   //获取Section下面的所有Keys：
//    CSimpleIniA::TNamesDepend keys;
//    ini.GetAllKeys("section-name", keys);
    
    
    
    
    
    //读取
    
    NSString *lrcPath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"ini"];
    
    CSimpleIniA ini;
    
    ini.SetUnicode();
    
    ini.LoadFile([lrcPath UTF8String]);
    
    
    const char * pVal = ini.GetValue("VersionSet", "Preview");
    
    NSLog(@"@@@@@@@@@@@@@@%@", [NSString stringWithCString:pVal encoding:NSUTF8StringEncoding]);
    
    ini.SetValue("section", "key", "newvalue");
    
    
    
    
    
    //获取所有的Section：
    CSimpleIniA::TNamesDepend sections;
    ini.GetAllSections(sections);
    
    CSimpleIniA::TNamesDepend::const_iterator i;
    for (i = sections.begin(); i != sections.end(); ++i) {
        printf("---------sections == '%s'\n", i->pItem);
        
        
        //获取Section下面的所有Keys：
        CSimpleIniA::TNamesDepend keys;
        ini.GetAllKeys(i->pItem, keys);
        
        CSimpleIniA::TNamesDepend::const_iterator j;
        for (j = keys.begin(); j != keys.end(); ++j) {
            printf("+++++++++++VersionSet的key-name = '%s'\n", j->pItem);
            
            //获取Section下面的所有values：
            CSimpleIniA::TNamesDepend values;
            ini.GetAllValues( i->pItem, j->pItem, values);
            
            CSimpleIniA::TNamesDepend::const_iterator k;
            for (k = values.begin(); k != values.end(); ++k) {
                printf("***********VersionSet的value-name = '%s'\n", k->pItem);
            }
        }
    }

        
        
      
        
        
            

    
   
    
}



  




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
