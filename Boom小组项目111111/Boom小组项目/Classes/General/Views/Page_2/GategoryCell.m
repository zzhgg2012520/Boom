//
//  GategoryCell.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/15.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "GategoryCell.h"

@implementation GategoryCell

- (void)setScene:(scene *)scene
{
    self.nameLabel.text = scene.name;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:scene.img]];
}

@end
