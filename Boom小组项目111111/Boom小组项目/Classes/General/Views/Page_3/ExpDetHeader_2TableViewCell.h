//
//  ExpDetHeader_2TableViewCell.h
//  Boom小组项目
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExpDetails;
@interface ExpDetHeader_2TableViewCell : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLbl;
@property (weak, nonatomic) IBOutlet UIButton *shopNameBtn;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *imgsView;
@property (weak, nonatomic) IBOutlet UIView *ExpContentView;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic,strong) ExpDetails * ExpDetails;

- (void)setExpDetails:(ExpDetails *)ExpDetails;

@end
