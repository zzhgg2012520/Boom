//
//  City.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "City.h"

@implementation City

-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _num_id = value;
    }
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _name];
}

@end
