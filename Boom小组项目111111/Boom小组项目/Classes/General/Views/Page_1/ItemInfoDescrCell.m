//
//  ItemInfoDescrCell.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ItemInfoDescrCell.h"

@implementation ItemInfoDescrCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addAllViews];
        
    }
    
    return self;
}

- (void)addAllViews{

    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    self.nameLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.nameLabel];
    self.nameLabel.text = @"正在加载";
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, 35, 300, 30)];
    self.addressLabel.textColor = [UIColor grayColor];
    [self addSubview:self.addressLabel];
    self.addressLabel.text = @"正在加载";
    
    self.praceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.addressLabel.frame.origin.x, 60, 200, 30)];
    self.praceLabel.textColor = [UIColor grayColor];
    [self addSubview:self.praceLabel];
    self.praceLabel.text = @"正在加载";
    
}

// 赋值
-(void)setModel:(ItemInfoDescrModel *)model{
    
    self.nameLabel.text = model.name;
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@", model.area, model.address];
    self.praceLabel.text = [NSString stringWithFormat:@"人均 %@-%@", model.consumeMin, model.consumeMax];
    
}

@end
