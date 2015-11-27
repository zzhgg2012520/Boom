//
//  ShopMapViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ShopMapViewController.h"

@interface ShopMapViewController ()

@property (nonatomic, strong) MKMapView * mapView;

@end

@implementation ShopMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"地图";
    
    // 初始化地图
    _mapView=[[MKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];
    _mapView.mapType = 0;
    
    //坐标
    CGFloat longitude = [self.longitude floatValue];
    CGFloat latitude = [self.latitude floatValue];
    CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
    
    // 大头针
    MKPointAnnotation * annotation=[[MKPointAnnotation alloc]init];
    annotation.title = self.name;
    annotation.subtitle = self.address;
    annotation.coordinate = location;
    [_mapView addAnnotation:annotation];
    [_mapView selectAnnotation:annotation animated:YES];//标题和子标题自动显示
    
    // 调整当前显示的地图比例
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 300, 300);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    
}

@end
