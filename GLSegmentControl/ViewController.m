//
//  ViewController.m
//  GLSegmentControl
//
//  Created by 高磊 on 2018/1/3.
//  Copyright © 2018年 高磊. All rights reserved.
//

#import "ViewController.h"
#import "MySegmentedControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MySegmentedControl *segmentedControl = [[MySegmentedControl alloc] initWithSectionTitles:@[@"首页",@"分类",@"作品",@"美食",@"电影",@"休闲",@"居家",@"娱乐"]];
    [segmentedControl setFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    [self.view addSubview:segmentedControl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
