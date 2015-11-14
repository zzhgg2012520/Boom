//
//  ModelForListCell.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ModelForListCell.h"

@implementation ModelForListCell

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _num_id = value;
    }
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _title];
}

@end
