//
//  sceneCollectionViewCell.m
//  Boom
//
//  Created by superGuest on 15/11/9.
//  Copyright © 2015年 wgw. All rights reserved.
//

#import "sceneCollectionViewCell.h"

@implementation sceneCollectionViewCell

- (void)setScene:(scene *)scene
{
    self.nameLabel.text = scene.name;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:scene.img]];
}

@end
