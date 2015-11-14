//
//  List.m
//  Boom1.0
//
//  Created by superGuest on 15/11/10.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "List.h"

@implementation List

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.idStr = value;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@", _name,_idStr];
}

@end
