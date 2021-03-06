//
//  ShopInfoTableViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ShopInfoTableViewController.h"

@interface ShopInfoTableViewController ()

@property (nonatomic, strong) MKMapView * mapView;
@property (nonatomic, strong) NSString * text;

@end

@implementation ShopInfoTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        return self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去掉返回按钮文字
    UIBarButtonItem * backButton = [UIBarButtonItem new];
    backButton.title = @"";
    self.navigationItem.backBarButtonItem = backButton;
    
    self.navigationItem.title = @"商家详情";
    
    self.tableView.bounces = NO;

    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"NET"] isEqualToString:@"1"]) {
        [self requestDataForSecondCell];
    }else{
        self.view.userInteractionEnabled = NO;
    }
    
}

- (void)requestDataForSecondCell{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.text = dict[@"body"][@"category"][0][@"name"];
        
        // 主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath2] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        });
    }];
    [task resume];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

// header内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    // 初始化地图
    _mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    [self.view addSubview:_mapView];
    _mapView.mapType = 0;
    
    //坐标
    CGFloat longitude = [self.descrModel.longitude floatValue];
    CGFloat latitude = [self.descrModel.latitude floatValue];
    CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
    
    // 大头针
    MKPointAnnotation * annotation=[[MKPointAnnotation alloc]init];
    annotation.coordinate=location;
    [_mapView addAnnotation:annotation];
    
    // 调整当前显示的地图比例
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location,50, 50);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    
    // 添加轻拍手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_mapView addGestureRecognizer:tap];
    
    return _mapView;
    
}

// 轻拍手势事件
- (void)tapAction{
    
    ShopMapViewController * shopMapVC = [ShopMapViewController new];
    shopMapVC.name = self.descrModel.name;
    shopMapVC.address = self.descrModel.address;
    shopMapVC.longitude = self.descrModel.longitude;
    shopMapVC.latitude = self.descrModel.latitude;
    
    [self.navigationController pushViewController:shopMapVC animated:YES];
    
}

// header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 150;
    
}

// cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
            
        case 0:
        {
            static NSString * cellID = @"0";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 40)];
                label.text = @"地址：";
                [cell addSubview:label];
                
                UILabel * addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 250, 40)];
                addressLabel.text = [NSString stringWithFormat:@"%@ %@", self.descrModel.area, self.descrModel.address];
#warning 想在一行label里显示2行数据
                addressLabel.numberOfLines = 0;
                [cell addSubview:addressLabel];
                
            }
            return cell;
            break;
        }
            
        case 1:
        {
            static NSString * cellID = @"1";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 40)];
                label.text = @"电话：";
                [cell addSubview:label];
                
                UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 250, 40)];
                phoneLabel.text = self.descrModel.phone;
                [cell addSubview:phoneLabel];
                
            }
            return cell;
            break;
        }
            
        case 2:
        {
            static NSString * cellID = @"2";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 40)];
                label.text = @"类型：";
                [cell addSubview:label];
                
                UILabel * typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 250, 40)];
                [cell addSubview:typeLabel];
                typeLabel.text = self.text;
                
            }
            return cell;
            break;
        }
            
        case 3:
        {
            static NSString * cellID = @"3";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 40)];
                label.text = @"人均：";
                [cell addSubview:label];
                
                UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 250, 40)];
                priceLabel.text = [NSString stringWithFormat:@"%@-%@", self.descrModel.consumeMin, self.descrModel.consumeMax];
                [cell addSubview:priceLabel];
                
            }
            return cell;
            break;
        }
            
        case 4:
        {
            static NSString * cellID = @"4";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 40)];
                label.text = @"营业时间：";
                [cell addSubview:label];
                
                UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 250, 40)];
                [cell addSubview:timeLabel];
                
                NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.string]];
                NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                // 判断是否有营业时间信息
                NSArray * array = [NSArray array];
                array = dict[@"body"][@"openTimes"];
                if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0) {
                    timeLabel.text = [NSString stringWithFormat:@"%@至%@ %@", dict[@"body"][@"openTimes"][0][@"startDate"], dict[@"body"][@"openTimes"][0][@"endDate"],   dict[@"body"][@"openTimes"][0][@"time"]];
                }else{
                    timeLabel.text = @"暂无营业时间信息";
                }
                

            }
            return cell;
            break;
        }
            
        default:
            break;
    }
    
    static NSString * cellID = @"没用的cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;

}

// cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        [self tapAction];
        
    }
    
    if (indexPath.row == 1) {
        
        // 拨打电话
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self.descrModel.phone]]]];
        [self.view addSubview:callWebview];
  
    }
    
}

@end
