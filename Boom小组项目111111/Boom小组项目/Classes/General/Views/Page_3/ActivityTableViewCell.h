//
//  ActivityTableViewCell.h
//  Boom1.0
//
//  Created by 付强 on 15/11/9.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

/* -----------------------活动自定义cell----------------------- */

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *actImgView;
@property (weak, nonatomic) IBOutlet UILabel *actTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *actTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *actAdressLbl;
@property (weak, nonatomic) IBOutlet UILabel *actTypeLbl;

@end
