//
//  Newest.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "Newest.h"

@implementation Newest

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.Id = value;
    }
}

@end