//
//  ExpDetHeader_2TableViewCell.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ExpDetHeader_2TableViewCell.h"
@interface ExpDetHeader_2TableViewCell ()<SDCycleScrollViewDelegate>
{
    
}
@end

@implementation ExpDetHeader_2TableViewCell

- (void)setExpDetails:(ExpDetails *)ExpDetails
{
    CGRect currentRect = [UIScreen mainScreen].applicationFrame;
    
    currentRect.origin.y = 0;
    self.ExpContentView.frame = currentRect;

    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:ExpDetails.userImg]];
    self.userNameLbl.text = ExpDetails.userName;
    self.creatTimeLbl.text = ExpDetails.createTime;
    [self.shopNameBtn setTitle:ExpDetails.shopName forState:UIControlStateNormal];
    self.descLabel.text = ExpDetails.desc;
    
    self.imgsView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.imgsView.delegate = self;
//    cycleScrollView2.titlesGroup = titles;
    self.imgsView.dotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.imgsView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    self.imgsView.imageURLStringsGroup = ExpDetails.imgs;
    
}

//在cell里面重写layoutSubviews这个方法时，需要调用[super layoutSubviews];
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    self.contentView.frame = [UIScreen mainScreen].bounds;
//    NSLog(@"self.content.frame.size.width>>>>>%f",self.contentView.frame.size.width);
//    NSLog(@"self.frame.size.width+++++%f",self.frame.size.width);
//}

@end
