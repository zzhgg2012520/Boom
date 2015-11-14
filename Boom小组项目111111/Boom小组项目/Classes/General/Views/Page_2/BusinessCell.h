//
//  BusinessCell.h
//  Boom小组项目
//
//  Created by superGuest on 15/11/10.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Business;
@interface BusinessCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) Business *business;

- (void)setBusiness:(Business *)business;

@end
