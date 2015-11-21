//
//  ListItemTableViewCell.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ListItemTableViewCell.h"

@implementation ListItemTableViewCell

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
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10,  [UIScreen mainScreen].bounds.size.width - 20, 200)];
    [self addSubview:self.backImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, self.backImageView.frame.origin.y + self.backImageView.frame.size.height, self.backImageView.frame.size.width, 40)];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.titleLabel];
    
    self.descrLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height - 2, self.backImageView.frame.size.width, 0)];
    self.descrLabel.textColor = [UIColor grayColor];
    self.descrLabel.numberOfLines = 0;
    [self addSubview:self.descrLabel];
    
}

// 重写 modelForContents setter方法
-(void)setModel:(ModelForContents *)model{
    
    // 获取值，放到控件上显示
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    _titleLabel.text = model.title;
    _descrLabel.text = model.descr;
    
    CGFloat height = [self calcHeightWithModelForContents:model];
    CGRect frame = _descrLabel.frame;
    frame.size.height = height;
    _descrLabel.frame = frame;
    
}

// 计算文字高度
- (CGFloat)calcHeightWithModelForContents:(ModelForContents *)modelForContents{
    
    // 最大范围
    CGSize maxSize = CGSizeMake(_descrLabel.frame.size.width, 1000);
    // 字典
    NSDictionary * dict = @{NSFontAttributeName:_descrLabel.font};
    // 获取frame的方法
    CGRect frame = [modelForContents.descr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height;
    
}

// 计算cell高度
+ (CGFloat)calcHeightForCellWithModelForContents:(ModelForContents *)modelForContents{
    
    // 创建一个对象，接收label的高度
    CGFloat labelHeigjt = [[ListItemTableViewCell new] calcHeightWithModelForContents:modelForContents];
    return labelHeigjt + 10 + 200  + 40  + 15;
    
}

@end
