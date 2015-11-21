//
//  FirstPageListTableViewCell.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "FirstPageListTableViewCell.h"

@implementation FirstPageListTableViewCell

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
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    [self addSubview:self.backImageView];
    
    
    
    
    // 毛玻璃
    UIVisualEffectView *visualView  = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualView.frame = self.backImageView.frame;
    visualView.alpha = 0.9;
    [self.backImageView addSubview:visualView];
    
    // 主标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.backImageView.frame.size.height / 2 - 40, self.backImageView.frame.size.width, 40)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:22];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.highlighted = YES;
    [visualView addSubview:self.titleLabel];
    
    // 横线
    UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.backImageView.frame.size.width / 2 - 75, self.backImageView.frame.size.height / 2 - 3, 150, 6)];
    lineImage.image = [UIImage imageNamed:@"中间的横线"];
    [visualView addSubview:lineImage];
    
    // 子标题
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.backImageView.frame.size.height / 2, self.backImageView.frame.size.width, 40)];
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subTitleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
    self.subTitleLabel.textColor = [UIColor whiteColor];
    self.subTitleLabel.highlighted = YES;
    [visualView addSubview:self.subTitleLabel];
    
    // 简介
    self.descrLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.backImageView.frame.size.height + 15, self.backImageView.frame.size.width - 30, 0)];
    self.descrLabel.numberOfLines = 0;
    [self addSubview:self.descrLabel];
    
}

// 重写 modelForListCell setter方法
- (void)setModelForListCell:(ModelForListCell *)modelForListCell{
    
    // 获取值，放到控件上显示
    _titleLabel.text = modelForListCell.title;
    _subTitleLabel.text = modelForListCell.subTitle;
    _descrLabel.text = modelForListCell.descr;
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:modelForListCell.image]];
    
    CGFloat height = [self calcHeightWithModelForListCell:modelForListCell];
    CGRect frame = _descrLabel.frame;
    frame.size.height = height;
    _descrLabel.frame = frame;
    
}

// 计算文字高度
- (CGFloat)calcHeightWithModelForListCell:(ModelForListCell *)modelForListCell{
    
    // 最大范围
    CGSize maxSize = CGSizeMake(_descrLabel.frame.size.width, 1000);
    // 字典
    NSDictionary * dict = @{NSFontAttributeName:_descrLabel.font};
    // 获取frame的方法
    CGRect frame = [modelForListCell.descr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height;
    
}

// 计算cell高度
+ (CGFloat)calcHeightForCellWithModelForListCell:(ModelForListCell *)modelForListCell{
    
    // 创建一个对象，接收label的高度
    CGFloat labelHeigjt = [[FirstPageListTableViewCell new] calcHeightWithModelForListCell:modelForListCell];
    return labelHeigjt + 150 + 30;
    
}

@end
