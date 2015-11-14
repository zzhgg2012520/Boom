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

    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width, 40)];
    self.nameLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.nameLabel];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height, 300, 30)];
    [self addSubview:self.addressLabel];
    
    self.praceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.addressLabel.frame.origin.x, self.addressLabel.frame.origin.y + self.addressLabel.frame.size.height, 200, 30)];
    [self addSubview:self.praceLabel];
    
}

// 赋值
-(void)setModel:(ItemInfoDescrModel *)model{
    
    self.nameLabel.text = model.name;
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@", model.area, model.address];
    self.praceLabel.text = [NSString stringWithFormat:@"人均 %@-%@", model.consumeMin, model.consumeMax];
    
}

@end
