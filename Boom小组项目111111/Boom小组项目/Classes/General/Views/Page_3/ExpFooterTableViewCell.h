//
//  ExpFooterTableViewCell.h
//  Boom小组项目
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpFooterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *place;
@property (weak, nonatomic) IBOutlet UIButton *shopNameBtn;
@property (weak, nonatomic) IBOutlet UILabel *discussCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *collectCountLbl;

@end
