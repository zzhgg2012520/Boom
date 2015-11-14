//
//  BusinessCell.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/10.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "BusinessCell.h"

@implementation BusinessCell

- (void)setBusiness:(Business *)business
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:business.img]];
    self.nameLabel.text = business.name;
}

@end