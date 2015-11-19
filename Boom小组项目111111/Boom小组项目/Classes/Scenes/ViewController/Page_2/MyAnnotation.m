//
//  MyAnnotation.m
//  Map1.0
//
//  Created by lanou3g on 15/10/14.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (instancetype)iniWithTitle:(NSString *)title
                    subtitle:(NSString *)subtitle
                  coordinate:(CLLocationCoordinate2D)coordinate{
    
    if (self == [super init]) {
        _title = title;
        _subtitle = subtitle;
        _coordinate = coordinate;
    }
    return self;
    
}

@end
