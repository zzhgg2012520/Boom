//
//  ActDetDisTableViewCell.h
//  Boom小组项目
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Activity;

@interface ActDetDisTableViewCell : UITableViewCell

@property (strong,nonatomic)UILabel *actDetDisLbl;

// 为了方便外界给内部赋值
@property (nonatomic, strong) Activity * activity;
- (void)setActivity:(Activity *)activity;

- (CGFloat)calcHightWithActivity:(Activity *)activity;
+ (CGFloat)calcHeightForCellWithActivity:(Activity *)activity;

@end
