//
//  SearchDataManager.h
//  Boom1.1
//
//  Created by superGuest on 15/11/11.
//  Copyright © 2015年 wgw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Result)();

@interface SearchDataManager : NSObject

+ (instancetype)sharedDataManager;
- (void)requsetDataWithSceneString:(NSString *)string;
- (void)requestDataWithBusinessString:(NSString *)string;
- (void)requestDataWithListString:(NSString *)string;
//allcategorys
- (void)requestDataWithAllFoodString:(NSString *)string;


@property (nonatomic,copy) Result result;
@property (nonatomic,strong) NSMutableArray *allBusinessArray;
@property (nonatomic,strong) NSMutableArray *allSceneArray;
//@property (nonatomic,strong) NSMutableArray *allListArray;
@property (nonatomic,strong) NSMutableArray *listArray;

//allcategorys
@property (nonatomic,strong) NSMutableArray *allCategorysArray;
@property (nonatomic,strong) NSMutableArray *allEasyArray;
@property (nonatomic,strong) NSMutableArray *allFoodArray;

@end
