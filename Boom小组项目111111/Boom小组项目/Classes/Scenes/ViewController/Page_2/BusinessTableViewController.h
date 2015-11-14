//
//  BusinessTableViewController.h
//  Boom小组项目
//
//  Created by superGuest on 15/11/11.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Business;
@interface BusinessTableViewController : UITableViewController

@property (nonatomic,strong) Business *business;
@property (nonatomic,strong) NSString *idStr;
@property (nonatomic,strong) NSString *channelid;

@end
