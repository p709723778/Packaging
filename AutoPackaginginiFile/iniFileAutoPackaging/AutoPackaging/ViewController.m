//
//  ViewController.m
//  AutoPackaging
//
//  Created by Gary on 13-8-19.
//  Copyright (c) 2013年 Gary. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *content = [[NSString alloc] initWithContentsOfFile:@"channelID.dat" encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"content ======%@",content);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
