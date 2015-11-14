//
//  FirstPageTableViewCell.m
//  Boom1.0
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "FirstPageTableViewCell.h"

@implementation FirstPageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    for(UIView * view in self.subviews){
        if([view isKindOfClass:[UIImageView class]])
        {
            [view removeFromSuperview];
        }
    }
    for(UIView * view in self.subviews){
        if([view isKindOfClass:[UILabel class]])
        {
            [view removeFromSuperview];
        }
    }
    
    // 背景图片
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5,  [UIScreen mainScreen].bounds.size.width - 20, 190)];
    [self addSubview:self.imgView];
    
    UIView * blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  self.imgView.frame.size.width, self.imgView.frame.size.height)];
#pragma mark 添加灰度，使背景变暗，文字清晰
    blackView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.2];
    [self.imgView addSubview:blackView];
    
    // 主标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgView.frame.size.height / 2 - 30, self.imgView.frame.size.width, 40)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:22];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.highlighted = YES;
    [blackView addSubview:self.titleLabel];
    
    // 子标题
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgView.frame.size.height / 2, self.imgView.frame.size.width, 40)];
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subTitleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    self.subTitleLabel.textColor = [UIColor whiteColor];
    self.subTitleLabel.highlighted = YES;
    [blackView addSubview:self.subTitleLabel];
    
    // 类型背景
    self.typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width - 60, 10, 60, 25)];
    [blackView addSubview:self.typeImageView];
    
    // 类型
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.textColor = [UIColor whiteColor];
    self.typeLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:12];
    [self.typeImageView addSubview:self.typeLabel];
    
}


@end

