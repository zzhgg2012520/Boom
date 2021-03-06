//
//  TabBarController.m
//  Boom1.0
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBar"];
    
    // 添加所有TabBar页面
    [self addAllChildViewController];
    
}

// 添加所有TabBar页面
- (void)addAllChildViewController{
    
    [self addFirstPage];
    [self addSecondPage];
    [self addThirdPage];
    [self addForthPage];
    
}

// 首页
- (void)addFirstPage{
    
    FirstPageTableViewController * firstPageVC = [FirstPageTableViewController new];
    UINavigationController * firstPageNC = [[UINavigationController alloc] initWithRootViewController:firstPageVC];
    [self addChildViewController:firstPageNC];
    
    // 设置navigationBar
    [self setupNavigationBarWithNC:firstPageNC];
    
    // tabBar标题
    firstPageNC.tabBarItem.title = @"首页";
    // tabBar图片
    firstPageNC.tabBarItem.image = [UIImage imageNamed:@"main_tab_home"];
    firstPageNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_tab_home_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

// 查找
- (void)addSecondPage{
    
    SearchViewController * searchVC = [SearchViewController new];
    UINavigationController * searchNC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self addChildViewController:searchNC];
    
    // 设置navigationBar
    [self setupNavigationBarWithNC:searchNC];
    
    // tabBar标题
    searchNC.tabBarItem.title = @"查找";
    // tabBar图片
    searchNC.tabBarItem.image = [UIImage imageNamed:@"main_tab_search"];
    searchNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_tab_search_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

// 发现
- (void)addThirdPage{
    
    FindViewController * findVC = [FindViewController new];
    UINavigationController * findNC = [[UINavigationController alloc] initWithRootViewController:findVC];
    [self addChildViewController:findNC];
    
    // 设置navigationBar
    [self setupNavigationBarWithNC:findNC];
    
    // tabBar标题
    findNC.tabBarItem.title = @"发现";
    // tabBar图片
    findNC.tabBarItem.image = [UIImage imageNamed:@"main_tab_discover"];
    findNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_tab_discover_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

- (void)addForthPage{
    
    MineTableViewController * mineTVC = [MineTableViewController new];
    UINavigationController * mineNC = [[UINavigationController alloc] initWithRootViewController:mineTVC];
    [self addChildViewController:mineNC];
    
    // 设置navigationBar
    [self setupNavigationBarWithNC:mineNC];
    
    // tabBar标题
    mineNC.tabBarItem.title = @"我的";
    // tabBar图片
    mineNC.tabBarItem.image = [UIImage imageNamed:@"main_tab_my"];
    mineNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_tab_my_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

// navigationBar的统一设置
- (void)setupNavigationBarWithNC:(UINavigationController *)NC{
    
    // navigationBar背景图片
    [NC.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];
    // title颜色
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    NC.navigationBar.titleTextAttributes = dict;
    // title字体
    dict = [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"TrebuchetMS-Bold" size:20] forKey:NSFontAttributeName];
    NC.navigationBar.titleTextAttributes = dict;
    // navigayionBar按钮着色
    NC.navigationBar.tintColor = [UIColor whiteColor];
    // 设置navigationBar样式为黑色(系统栏文字会相应改变成白色)
    [NC.navigationBar setBarStyle:UIBarStyleBlack];
    
}

@end
