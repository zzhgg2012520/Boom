//
//  ItemInfoDescrModel.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ItemInfoDescrModel.h"

@implementation ItemInfoDescrModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _num_id = value;
    }
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _name];
}

@end
