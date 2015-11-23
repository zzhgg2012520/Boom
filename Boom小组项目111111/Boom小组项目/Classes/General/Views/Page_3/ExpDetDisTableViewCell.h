//
//  ExpDetDisTableViewCell.h
//  Boom小组项目
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Experience;
@interface ExpDetDisTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *disLbl;
@property (nonatomic,strong) Experience * experience;

- (void)setExperience:(Experience *)experience;

@end
