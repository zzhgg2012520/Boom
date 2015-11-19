//
//  FirstItemInfoCell.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "FirstItemInfoCell.h"

@interface FirstItemInfoCell () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;

@end

@implementation FirstItemInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addAllViews];
        
    }
    
    return self;
}

- (void)addAllViews{
    

    // 创建轮播图
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220) imageURLStringsGroup:nil];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.infiniteLoop = YES;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.cycleScrollView.userInteractionEnabled = YES;
    [self addSubview:self.cycleScrollView];
    // 轮播时间间隔，默认1.0秒，可自定义
    self.cycleScrollView.autoScrollTimeInterval = 3.0;
    // 分页控件颜色
    self.cycleScrollView.dotColor = [UIColor whiteColor];
    
}

// 重写setter方法赋值
-(void)setArray:(NSMutableArray *)array{
    
    self.cycleScrollView.imageURLStringsGroup = array;
    
}

// 轮播图点击代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
  
    
}



@end
