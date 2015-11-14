//
//  SearchDataManager.m
//  Boom1.1
//
//  Created by superGuest on 15/11/11.
//  Copyright © 2015年 wgw. All rights reserved.
//

#import "SearchDataManager.h"
@interface SearchDataManager()

@property (nonatomic,strong) NSMutableArray *sceneArray;
@property (nonatomic,strong) NSMutableArray *businessArray;


@end
@implementation SearchDataManager

+ (instancetype)sharedDataManager
{
    static SearchDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [SearchDataManager new];
    });
    return manager;
}

- (void)requsetDataWithSceneString:(NSString *)string
{
    if (self.sceneArray.count > 0) {
        [self.sceneArray removeAllObjects];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            for (NSDictionary *dic in dict[@"body"][@"list"]) {
                scene *model = [scene new];
                [model setValuesForKeysWithDictionary:dic];
                [self.sceneArray addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.result();
            });
            
        }];
        
        [task resume];
    });
}

- (void)requestDataWithBusinessString:(NSString *)string
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if ([self.allBusinessArray count] > 0) {
                [self.allBusinessArray removeAllObjects];
            }
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            for (NSDictionary *dic in dict[@"body"][@"list"]) {
                Business *model = [Business new];
                [model setValuesForKeysWithDictionary:dic];
                [self.allBusinessArray addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.result();
            });
            
        }];
        
        [task resume];
    });
}

- (void)requestDataWithListString:(NSString *)string
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        

            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            for (NSDictionary *dic in dict[@"body"][@"list"]) {
                List *model = [List new];
                [model setValuesForKeysWithDictionary:dic];
                [self.listArray addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.result();
            });
            
        }];
        
        [task resume];
    });
}

- (void)requestDataWithAllFoodString:(NSString *)string
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string ]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            for (NSDictionary *dic in dict[@"body"][@"channel"][0][@"categorys"]) {
                scene * model =  [scene new];
                [model setValuesForKeysWithDictionary:dic];
                [self.allEasyArray addObject:model];
            }
            
            for (NSDictionary * dic in dict[@"body"][@"channel"][1][@"categorys"]) {
                scene * model = [scene new];
                [model setValuesForKeysWithDictionary:dic];
                [self.allFoodArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.result();
            });
            
        }];
        
        [task resume];
        
    });
}

//lazy loading
- (NSMutableArray *)sceneArray
{
    if (!_sceneArray) {
        _sceneArray = [NSMutableArray new];
    }
    return _sceneArray;
}

- (NSMutableArray *)allSceneArray
{
    return [self.sceneArray copy];
}

//lazy loading
//- (NSMutableArray *)businessArray
//{
//    if (!_businessArray) {
//        _businessArray = [NSMutableArray new];
//    }
//    return _businessArray;
//}

- (NSMutableArray *)allBusinessArray
{
    if (!_allBusinessArray) {
        _allBusinessArray = [NSMutableArray new];
    }
    return _allBusinessArray;
}

//lazyloading
- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}

- (NSMutableArray *)allFoodArray
{
    if (!_allFoodArray) {
        _allFoodArray = [NSMutableArray  new];
    }
    return _allFoodArray;
}

- (NSMutableArray *)allEasyArray
{
    if (!_allEasyArray) {
        _allEasyArray = [NSMutableArray new];
    }
    return _allEasyArray;
}

- (NSMutableArray *)allCategorysArray
{
    if(!_allEasyArray){
        self.allCategorysArray = [NSMutableArray new];
    }
    return _allCategorysArray;
}

@end
