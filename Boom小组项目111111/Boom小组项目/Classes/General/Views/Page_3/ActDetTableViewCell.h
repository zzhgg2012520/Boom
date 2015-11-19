//
//  ActDetTableViewCell.h
//  Boom小组项目
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActDetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *actDetTitleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *actDetImgView;
@property (weak, nonatomic) IBOutlet UILabel *actDetTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *actDetAddress;
@property (weak, nonatomic) IBOutlet UILabel *actDetCostLbl;
@property (weak, nonatomic) IBOutlet UILabel *actDetTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *actDetSponsorLbl;

@end
