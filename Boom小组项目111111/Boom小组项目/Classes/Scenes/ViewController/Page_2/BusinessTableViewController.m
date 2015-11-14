//
//  BusinessTableViewController.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/11.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "BusinessTableViewController.h"

@interface BusinessTableViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    //定义管理类
    CLLocationManager *manager;
    CLLocation *userLocation;
}
//当前页
@property (nonatomic,assign) NSInteger currentPage;
//右上角的map和列表切换
@property (nonatomic,assign)BOOL mapSwitch;
//地图View
@property (nonatomic,strong) MKMapView *mapView;

@end

@implementation BusinessTableViewController

static NSString *const listCellID = @"listCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigationController的title的name
    self.navigationItem.title = self.business.name;
 
    
    //修改了navigationBar.barTintColor背景的颜色和tintColor的字体颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    //增加返回和地图键
    [self addBackAndMapButton];
    
    //初始化地图
    [self initMapView];
    
    //初始化mapSwitch
    self.mapSwitch = YES;
    
    //当前页的页号
    self.currentPage = 1;
    
#pragma mark -- 请求数据：刷新，加载, 刷新数据
    [self pullTlLoadData];
    [self dropToRefresh];
    [SearchDataManager sharedDataManager].result = ^(){
        [self.tableView reloadData];
    };
    
    //注册listCell
    [self.tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:listCellID];
    
    //隐藏tabBar
//    self.tabBarController.tabBar.hidden = YES;
}

//初始化地图
- (void)initMapView
{
    self.mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.mapView.showsUserLocation = YES;
    //判断系统
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        //允许定位,需要在info.plist里面添加字段，并且和此处保持一致
        manager = [[CLLocationManager alloc] init];
        
        //设置权限为使用时进行定位
        [manager requestWhenInUseAuthorization];
        
        //这是用户的跟踪模式:为一直跟踪
        [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        
    }

    //设置地图的代理
    _mapView.delegate = self;
    
    //设置地图管理类的代理
    manager.delegate = self;
    
    //距离筛选器：设置最小的人的位置更新提示距离
    manager.desiredAccuracy = 1000;
    
    //开始定位
    [manager startUpdatingLocation];
    
    [self.view sendSubviewToBack:self.mapView];
}

#pragma mark --MKMapViewDelegate
#pragma mark -- 用户位置发生了变化
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //NSLog(@"%d,%s",__LINE__,__FUNCTION__);
    //NSLog(@"title = %@,subtitle = %@",userLocation.title,userLocation.subtitle);
    
    //蓝色小点得气泡
//    userLocation.title = @"我爱你";
//    userLocation.subtitle = @"小甜心";

    
//    CLLocationDegrees lait = location.coordinate.latitude;
//    
//    CLLocationDegrees longit = location.coordinate.longitude;
    
    //userLocation = [[CLLocation alloc] initWithLatitude:lait longitude:longit];

    
//    //插一根大头针
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    
//    //插入的位置
//    CLLocationCoordinate2D theLocation = userLocation.coordinate;
//    point.coordinate = theLocation;
//    
//    [mapView addAnnotation:point];
}
//增加返回和地图键
- (void)addBackAndMapButton
{
    //返回键
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"abc_ic_ab_back_mtrl_am_alpha"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    
    //地图键
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_map_mode"] style:UIBarButtonItemStylePlain target:self action:@selector(mapAction:)];
}

//返回键
- (void)backAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//地图键切换界面
- (void)mapAction:(UIBarButtonItem *)sender
{
    if (self.mapSwitch == YES) {
        //cellbutton
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_list_mode"] style:UIBarButtonItemStylePlain target:self action:@selector(mapAction:)];

        [self.view addSubview:self.mapView];
        [self.view bringSubviewToFront:self.mapView];
        
        self.mapSwitch = NO;
    }else{
        //mapButton
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_map_mode"] style:UIBarButtonItemStylePlain target:self action:@selector(mapAction:)];
        
        [self.view sendSubviewToBack:self.mapView];
        self.mapSwitch = YES;
    }
}

#pragma mark -- 请求数据
//上拉加载
- (void)dropToRefresh
{
    __weak __typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.tableView reloadData];
            
            NSString *strUrl = [NSString stringWithFormat:@"http://www.molyo.com//mShop/getShopList?cityId=%@&longitude=116.34381300000000&latitude=40.03028800000000&pageSize=8&currentPage=%ld&channelId=%@categoryId=&sceneId=&districtId=&liveCircleId=&businessDistrictId=%@netWork=wifi&device=MI+1SC&os=Android+4.1.2&osType=android",[[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"],++ self.currentPage,self.channelid,self.idStr];
            
            [[SearchDataManager sharedDataManager] requestDataWithListString:strUrl];

            [self.tableView reloadData];
            
            [weakSelf.tableView.footer endRefreshing];
        });
    }];
    self.tableView.footer.hidden = YES;
}

// 下拉刷新
- (void)pullTlLoadData
{
    
    __weak __typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 模拟延迟加载数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            
            // 清空数组
            if ([SearchDataManager sharedDataManager].                                                                                                                                                   listArray.count != 0) {
                
                [[SearchDataManager sharedDataManager].listArray removeAllObjects];
            }
            
            NSString *strUrl = [NSString stringWithFormat:@"http://www.molyo.com//mShop/getShopList?cityId=%@&longitude=116.34381300000000&latitude=40.03028800000000&pageSize=8&currentPage=1&channelId=%@categoryId=&sceneId=&districtId=&liveCircleId=&businessDistrictId=%@netWork=wifi&device=MI+1SC&os=Android+4.1.2&osType=android",[[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"],self.channelid,self.idStr];
                [[SearchDataManager sharedDataManager] requestDataWithListString:strUrl];
          
            //刷新数据
            [self.tableView reloadData];
            // 结束刷新
            [weakSelf.tableView.header endRefreshing];
            
        });
        
    }];
    [self.tableView.header beginRefreshing];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SearchDataManager sharedDataManager]listArray].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellID forIndexPath:indexPath];
    List *list = [[SearchDataManager sharedDataManager]listArray][indexPath.row];
    cell.list = list;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    Business *b = [[SearchDataManager sharedDataManager]listArray][indexPath.row];
    ListInfoTableViewController *listInfoTVC = [ListInfoTableViewController new];
    listInfoTVC.shopId = b.idStr;
    [self.navigationController pushViewController:listInfoTVC animated:YES];                      
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205;
}

@end
