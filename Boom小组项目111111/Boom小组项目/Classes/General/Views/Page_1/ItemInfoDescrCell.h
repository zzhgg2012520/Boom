//
//  ItemInfoDescrCell.h
//  Boom小组项目
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemInfoDescrModel;

@interface ItemInfoDescrCell : UITableViewCell

@property (nonatomic ,strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UILabel * praceLabel;

@property (nonatomic, strong) ItemInfoDescrModel * model;

@end
