//
//  ListItemTableViewCell.h
//  Boom小组项目
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListItemTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * descrLabel;

@property (nonatomic, strong) ModelForContents * model;

+ (CGFloat)calcHeightForCellWithModelForContents:(ModelForContents *)modelForContents;

@end
