//
//  ViewController.m
//  PulsingDemo
//
//  Created by BaiJiangzhou on 15/3/25.
//  Copyright (c) 2015年 jiangzhou. All rights reserved.
//

#import "ViewController.h"
#import "JZPulsingView.h"
#import "JZTagTextView.h"
#import "JZTagView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JZTagView * tag = [[JZTagView alloc]initWithFrame:CGRectMake(100, 100, 100, HEIGHT)];
    tag.backgroundColor = [UIColor clearColor];
    tag.text = @"Tag Demo";
    [self.view addSubview:tag];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
