
//
//  ActDetDisTableViewCell.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ActDetDisTableViewCell.h"

@implementation ActDetDisTableViewCell

//// 计算文字高度
//- (CGFloat)calcHeightWithActivity:(Activity *)activity{
//    
//    // 最大范围
//    CGSize maxSize = CGSizeMake(self.actDetDisLbl.frame.size.width, 1000);
//    // 字典
//    NSDictionary * dict = @{NSFontAttributeName:self.actDetDisLbl.font};
//    // 获取frame的方法
//    CGRect frame = [activity.desc boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
//    return frame.size.height;
//    
//}
//
//// 计算cell高度
//+ (CGFloat)calcHeightForCellWithActivity:(Activity *)activity{
//    
//    // 创建一个对象，接收label的高度
//    CGFloat labelHeight = [[ActDetDisTableViewCell new] calcHeightWithActivity:activity];
//    return labelHeight;
//    
//}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
