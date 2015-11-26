//
//  MyActivityViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/24.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "MyActivityViewController.h"

@interface MyActivityViewController ()

@end

@implementation MyActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的活动";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 150, 100, 300, 60)];
    label.text = @"你还没有活动哦";
    label.font = [UIFont systemFontOfSize:25];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
}


@end
