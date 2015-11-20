//
//  ShopDataManager.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ShopDataManager.h"

@interface ShopDataManager ()


@end


@implementation ShopDataManager

+ (instancetype)shareDataManager{
    
    static ShopDataManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [ShopDataManager new];
    });
    return manager;
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.Array = [NSMutableArray array];
        // 获取appDelegate里面的被管理上下文对象
        // 1 获取 appDelegate
        self.appDelegate = [UIApplication sharedApplication].delegate;
        // 2 获取被管理
        self.myObjectContext = self.appDelegate.managedObjectContext;
        
    }
    return self;
    
}











@end
