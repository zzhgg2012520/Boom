//
//  Activity.h
//  Boom小组项目
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *dateTimeParse;

@property (nonatomic, strong) NSString *cost;
@property (nonatomic, strong) NSString *dateType;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *enableFlag;
@property (nonatomic, strong) NSString *interestCount;
@property (nonatomic, strong) NSString *joinCount;
@property (nonatomic, strong) NSString *sponsorId;
@property (nonatomic, strong) NSString *sponsorName;
@property (nonatomic, strong) NSString *sponsorType;
@property (nonatomic, strong) NSDictionary *times;

@end