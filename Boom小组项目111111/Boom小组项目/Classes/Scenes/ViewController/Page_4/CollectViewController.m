//
//  CollectViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "CollectViewController.h"


@interface CollectViewController () <HTHorizontalSelectionListDelegate, HTHorizontalSelectionListDataSource>

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSArray *carMakes;
@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation CollectViewController
{
    BOOL _changeFlag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的收藏";
    
    // scrollView
    [self setUpScrollView];
    
    // 分段选择控制器
    [self setUpSegment];
    
    // 页面
    ThemeForCollectTableViewController * themeTVC = [ThemeForCollectTableViewController new];
    themeTVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:themeTVC.view];
    [self addChildViewController:themeTVC];
    
    self.hidesBottomBarWhenPushed = YES;
    
}

// scrollView
- (void)setUpScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - 64 - 50)];
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, self.scrollView.frame.size.height);
    [self.view addSubview:self.scrollView];
    
    self.scrollView.scrollEnabled = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
 
}

// 分段选择控制器
- (void)setUpSegment{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    self.selectionList.delegate = self;
    self.selectionList.dataSource = self;
    
    self.carMakes = @[@"专题",
                      @"商户",
                      @"体验"];
    [self.view addSubview:self.selectionList];

}

// segment个数
- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    
    return self.carMakes.count;
}

// segment标题
- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {

    return self.carMakes[index];
}

// segment点击事件
- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {

    // 设置scroll偏移量
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.frame.size.width, 0) animated:YES];
    
}


@end
