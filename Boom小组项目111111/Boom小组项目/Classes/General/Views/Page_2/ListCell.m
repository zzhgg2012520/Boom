//
//  ListCell.m
//  Boom1.0
//
//  Created by superGuest on 15/11/10.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (void)setList:(List *)list
{
    self.descLabel.text = list.desc;
    self.nameAndAreaLabel.text = [NSString stringWithFormat:@"%@,%@",list.name,list.area];
    self.distanceLabel.text = [NSString stringWithFormat:@"距离%@km",list.distance];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:list.img]];
    
//    if ([list.services containsObject:@"card"] == YES) {
//        self.vipImgView.image = [UIImage imageNamed:@"img_sign_vipcard"];
//    }
//    
//    if ([list.services containsObject:@"treatment"] == YES) {
//        self.treatmentImgView.image = [UIImage imageNamed:@"img_sign_treatment"];
//    }
//    
//    if ([list.services containsObject:@"pay"] == YES) {
//        self.payImg.image = [UIImage imageNamed:@"img_sign_pay"];
//    }

    for (NSString *str in list.services) {
        if ([str isEqualToString:@"card"]) {
            self.vipImgView.image = [UIImage imageNamed:@"img_sign_vipcard"];
        }else if([str isEqualToString:@"treatment"]){
            self.treatmentImgView.image = [UIImage imageNamed:@"img_sign_treatment"];
        }else{
            self.payImg.image = [UIImage imageNamed:@"img_sign_pay"];
        }
    }
    
}

@end
