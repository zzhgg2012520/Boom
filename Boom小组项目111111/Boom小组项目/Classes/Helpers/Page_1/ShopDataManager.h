//
//  ShopDataManager.h
//  Boom小组项目
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ShopDataManager : NSObject

+ (instancetype)shareDataManager;

// 添加收藏对象
- (void)addCollectTitle:(NSString *)title
               subTitle:(NSString *)subTitle
                    img:(NSString *)img
                  subId:(NSString *)subId;

// 查询所有收藏
- (NSArray *)getAllCollect;

// 按标题查找
- (Collect_Type_Model *)getCollectWithTitle:(NSString *)title;

// 按标题删除
- (void)deleteCollectWithTitle:(NSString *)title;

@end
