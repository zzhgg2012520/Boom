//
//  ListCell.h
//  Boom1.0
//
//  Created by superGuest on 15/11/10.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class List;
@interface ListCell : UITableViewCell
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *descLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *nameAndAreaLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *distanceLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic,strong) List *list;
@property (weak, nonatomic) IBOutlet UIImageView *payImg;
@property (weak, nonatomic) IBOutlet UIImageView *treatmentImgView;
@property (weak, nonatomic) IBOutlet UIImageView *vipImgView;

- (void)setList:(List *)list;

@end
