//
//  MyAnnotation.h
//  Map1.0
//
//  Created by lanou3g on 15/10/14.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * subtitle;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

// 扩充的
@property (nonatomic, assign) int tag;

- (instancetype)iniWithTitle:(NSString *)title
                    subtitle:(NSString *)subtitle
                  coordinate:(CLLocationCoordinate2D)coordinate;

@end
