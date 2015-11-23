//
//  ExpDetDisTableViewCell.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ExpDetDisTableViewCell.h"

@implementation ExpDetDisTableViewCell

- (void)setExperience:(Experience *)experience
{
    self.userNameLbl.text = experience.userName;
    self.disLbl.text = experience.desc;
    self.creatTimeLbl.text = experience.createTime;
    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:experience.userImg]];
}

@end
