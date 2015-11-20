//
//  ExpDetails.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ExpDetails.h"

@implementation ExpDetails

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSMutableArray *)imgs
{
    if (_imgs == nil) {
        self.imgs = [NSMutableArray array];
    }
    return _imgs;
}

@end
