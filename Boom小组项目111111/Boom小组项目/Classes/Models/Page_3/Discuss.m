//
//  Discuss.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "Discuss.h"

@implementation Discuss

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.Id = value;
    }
    
}

@end
