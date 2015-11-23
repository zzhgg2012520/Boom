//
//  FindViewController.m
//  Boom1.0
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController () <UIScrollViewDelegate>

//实现不同控制器通过 SegmentedControl切换
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
//实现不同控制器的左右滑动切换
@property (nonatomic, strong) UIScrollView *scrollView;
//控制器数组
@property (nonatomic, strong) NSArray *ControllerArray;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"发现";
#pragma mark - 添加子控制器
    
    ExperienceTableViewController *ExpVC = [ExperienceTableViewController new];
    ActivityTableViewController *ActVC = [ActivityTableViewController new];
    NewestTableViewController *NewVC = [NewestTableViewController new];
    
    [self addChildViewController: ExpVC];
    [self addChildViewController: ActVC];
    [self addChildViewController: NewVC];
    
    // 控制器数组
    self.ControllerArray = @[ExpVC,ActVC,NewVC];
    
#pragma mark - scrollView的设置
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49)];
    //scrollView左右滑动
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    //关闭回弹
    _scrollView.bounces = NO;
    //设置是否允许滚动
    _scrollView.scrollEnabled = YES;
    //设置代理
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
    // 设置scrollView的内容
    for (int i = 0; i < 3; i++) {
        [self.ControllerArray[i] view].frame = CGRectMake(i * SCROLLWIDTH_3, 0, SCROLLWIDTH_3, SCROLLHEIGHT_3 - 113);
        [_scrollView addSubview:[self.ControllerArray[i] view]];
    }
    
#pragma mark - SegmentedControl的设置
    
    //设置segmentedControl的标题
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"体验",@"活动",@"最新"]];
    _segmentedControl.frame = CGRectMake(-12, 0, SCROLLWIDTH_3 + 8, 44);
    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCROLLHEIGHT_3 + 8, 2)];
//    view.backgroundColor = [UIColor blackColor];
//    [self.segmentedControl addSubview:view];
    
    _segmentedControl.backgroundColor = [UIColor whiteColor];
    _segmentedControl.tintColor = [UIColor blackColor];
    
    //设置默认显示的控制器
    _segmentedControl.selectedSegmentIndex = 0;
    
    //添加 segmentedControl的点击事件
    [_segmentedControl addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventValueChanged];
    
    //将 segmentedControl添加到导航栏控制器
    UIView *findView = [[UIView alloc] initWithFrame:CGRectMake(-8, 0, SCROLLWIDTH_3, 44)];
    [findView addSubview:_segmentedControl];
    self.navigationItem.titleView = findView;
}

#pragma mark - segmentedControl的点击事件：

- (void)selectAction:(UISegmentedControl *)Seg
{
    //点击切换控制器
    NSInteger num = _segmentedControl.selectedSegmentIndex;
    
    _scrollView.contentOffset = CGPointMake(self.view.frame.size.width * num,0);
}

#pragma mark - 重写----scrollViewDelegate中的代理方法 实现滑动

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 计算偏移量
    int index = fabs(scrollView.contentOffset.x / SCROLLWIDTH_3);
    
    // 根据偏移量来设置segmentedControl
    _segmentedControl.selectedSegmentIndex = index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end