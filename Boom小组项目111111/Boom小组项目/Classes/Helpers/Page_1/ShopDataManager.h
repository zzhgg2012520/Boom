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

// 属性接收appDelegate里面的被管理对象上下文
@property (nonatomic, retain) NSManagedObjectContext * myObjectContext;

@property (nonatomic, retain) NSMutableArray * Array;

@property (nonatomic, retain) AppDelegate * appDelegate;

+ (instancetype)shareDataManager;

@end
