//
//  ShopDataManager.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ShopDataManager.h"

@interface ShopDataManager ()

// 属性接收appDelegate里面的被管理对象上下文
@property (nonatomic, retain) NSManagedObjectContext * myObjectContext;
// 接收所有查询出来的收藏内容
@property (nonatomic, retain) NSMutableArray * array;

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
        
        self.array = [NSMutableArray array];
        // 获取appDelegate里面的被管理上下文对象
        // 1 获取 appDelegate
        AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
        // 2 获取被管理
        self.myObjectContext = appDelegate.managedObjectContext;
        
    }
    return self;
    
}

// 添加收藏对象
- (void)addCollectTitle:(NSString *)title
               subTitle:(NSString *)subTitle
                    img:(NSString *)img
                  subId:(NSString *)subId{
    
    //创建描述对象
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Collect_Type_Model" inManagedObjectContext:self.myObjectContext];
    
    //创建ComicsCollect对象
    Collect_Type_Model * collect = [[Collect_Type_Model alloc] initWithEntity:description insertIntoManagedObjectContext:self.myObjectContext];
    collect.title = title;
    collect.subTitle = subTitle;
    collect.img = img;
    collect.subId = subId;
    //保存操作
    [self.myObjectContext save:nil];
    
}

// 查询所有收藏
- (NSArray *)getAllCollect{
    
    // 搜索类
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // 实体描述
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Collect_Type_Model" inManagedObjectContext:self.myObjectContext];
    [fetchRequest setEntity:entity];
    
    // 执行查询请求
    NSError *error = nil;
    NSArray *fetchedObjects = [self.myObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        return nil;
    }else{
        return fetchedObjects;
        
    }
    return nil;
}

// 按标题查找
- (Collect_Type_Model *)getCollectWithTitle:(NSString *)title{
    
    // 搜索类
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // 实体描述
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Collect_Type_Model" inManagedObjectContext:self.myObjectContext];
    [fetchRequest setEntity:entity];
    
    // 查找条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@", title];
    [fetchRequest setPredicate:predicate];
    
    // 执行查询请求
    NSError *error = nil;
    NSArray *fetchedObjects = [self.myObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects.count == 0) {
        return nil;
    }else{
        return fetchedObjects[0];
        
    }
    
}

// 按标题删除
- (void)deleteCollectWithTitle:(NSString *)title{
    
    // 搜索类
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // 实体描述
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Collect_Type_Model" inManagedObjectContext:self.myObjectContext];
    [fetchRequest setEntity:entity];
    
    // 查找条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@", title];
    [fetchRequest setPredicate:predicate];
    
    // 执行查询请求
    NSError *error = nil;
    NSArray *fetchedObjects = [self.myObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects.count != 0) {
        [self.myObjectContext deleteObject:fetchedObjects[0]];
        [self.myObjectContext save:nil];
    }
    
}

@end
