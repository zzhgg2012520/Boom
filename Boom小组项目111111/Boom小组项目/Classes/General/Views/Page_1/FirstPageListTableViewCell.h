//
//  FirstPageListTableViewCell.h
//  Boom小组项目
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelForListCell;

@interface FirstPageListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * lineImageView;
@property (nonatomic, strong) UILabel * subTitleLabel;
@property (nonatomic, strong) UILabel * descrLabel;

// 为了方便外界给内部赋值
@property (nonatomic, strong) ModelForListCell * modelForListCell;

+ (CGFloat)calcHeightForCellWithModelForListCell:(ModelForListCell *)modelForListCell;

@end
