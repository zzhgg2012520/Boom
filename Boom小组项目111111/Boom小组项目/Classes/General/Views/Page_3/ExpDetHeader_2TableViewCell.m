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

@end
