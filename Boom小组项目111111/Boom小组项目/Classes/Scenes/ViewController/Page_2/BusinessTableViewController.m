//
//  BusinessTableViewController.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/11.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "BusinessTableViewController.h"

@interface BusinessTableViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>

    //定义管理类
@property (nonatomic,strong) CLLocationManager * manager;
@property (nonatomic,strong) CLLocation * userLocation;

//当前页
@property (nonatomic,assign) NSInteger currentPage;
//右上角的map和列表切换
@property (nonatomic,assign)BOOL mapSwitch;
//地图View
@property (nonatomic,strong) MKMapView * mapView;

@end

@implementation BusinessTableViewController

static NSString *const listCellID = @"listCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigationController的title的name
    self.title = _titleStr;
 
    // 去掉返回按钮文字
    UIBarButtonItem * backButton = [UIBarButtonItem new];
    backButton.title = @"";
    self.navigationItem.backBarButtonItem = backButton;
    
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
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"NET"] isEqualToString:@"1"]) {
        [self pullTlLoadData];
        [self dropToRefresh];
        [SearchDataManager sharedDataManager].result = ^(){
            [self.tableView reloadData];
        };
    }else{
        self.view.userInteractionEnabled = NO;
    }
    
    
    //注册listCell
    [self.tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:listCellID];
    
}

//初始化地图
- (void)initMapView
{
    // 创建地图
    self.mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 设置地图属性
    
    // 设置地图类型
    self.mapView.mapType = 0;
    
    //用户位置
    //mapView.userLocation = @"经纬度";
    self.mapView.showsUserLocation = YES;
    
    // 判断系统
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        // 允许定位 需要在info.plist里面添加字段，并且和此处保持一致
        // 这个启动权限是不是cllcationmanager里的
        _manager = [[CLLocationManager alloc] init];
        [_manager requestWhenInUseAuthorization];
        
    }
    
    // 设置用户跟踪模式 为一直跟踪
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    // 添加到视图上
//    [self.view addSubview:self.mapView];
    
    // 设置地图的代理
    self.mapView.delegate = self;
    
    // 距离筛选器 设置最小的距离更新提示距离
    _manager.desiredAccuracy = 100;
    
    // 开始定位
    [_manager startUpdatingLocation];
    
    [self.view sendSubviewToBack:self.mapView];
}

#pragma mark --MKMapViewDelegate
#pragma mark -- 用户位置发生了变化
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    userLocation.title = @"你的位置哦";
    
    //系统大头针：插大头针
    MKPointAnnotation * point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    [mapView addAnnotation:point];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    //NSLog(@"从旧位置到新位置");
    
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views
{
    //自定义大头针
    for (List *list in [[SearchDataManager sharedDataManager] listArray]) {
        
        CLLocationCoordinate2D myCoor = CLLocationCoordinate2DMake([list.latitude doubleValue], [list.longitude doubleValue]);
        MyAnnotation * myAnnotation = [[MyAnnotation alloc] iniWithTitle:list.name subtitle:list.desc coordinate:myCoor];
        
        [mapView addAnnotation:myAnnotation];
    }
}

#pragma mark --
//往地图上添加标记，例如大头针的时候会走
//创建重用标识符
static NSString *const reuseID = @"annotaion";
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    //根据重用标识符查找是否有创建好的可重用的
    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseID];
    //创建气泡
    if (!pinAnnotationView) {
        //如果没有，就去创建
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseID];
    }
    
    //左视图
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_map_food"]];
    imageView.frame = CGRectMake(0, 0, 30, 50);
    [pinAnnotationView setLeftCalloutAccessoryView:imageView];
    
    //打开视图
    pinAnnotationView.canShowCallout = YES;
    
    //返回
    return pinAnnotationView;
}

#pragma mark --
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
//    NSLog(@"点击气泡的时候走了");
}

//增加地图键
- (void)addBackAndMapButton
{
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
    if (self.mapSwitch) {
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
            
            NSString *strUrl = [NSString stringWithFormat:kBusinessDetailDropUrl,[[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"],++ self.currentPage,self.channelid,self.idStr];
            
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

            NSString *strUrl = [NSString stringWithFormat:kBusinessDetailPullUrl,[[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"],self.channelid,self.categoryId,self.idStr];
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
