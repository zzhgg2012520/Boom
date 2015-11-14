//
//  SceneTableViewController.m
//  Boom1.1
//
//  Created by superGuest on 15/11/12.
//  Copyright © 2015年 wgw. All rights reserved.
//

#import "SceneTableViewController.h"


@interface SceneTableViewController ()
{
    NSMutableArray *chooseArray;
}
@property (nonatomic,assign) NSInteger currentPage;

@end

@implementation SceneTableViewController

static NSString *const listCellID = @"listCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigationController的title的name
    self.navigationItem.title = self.scene.name;
    
    //修改了navigationBar.barTintColor背景的颜色和tintColor的字体颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    //增加返回和地图键
    [self addBackAndMapButton];
    
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
    self.tabBarController.tabBar.hidden = YES;
}

//增加返回和地图键
- (void)addBackAndMapButton
{
    //返回键
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"abc_ic_ab_back_mtrl_am_alpha"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    
    //地图键
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_map_mode"] style:UIBarButtonItemStylePlain target:self action:@selector(mapAction:)];
}

- (void)backAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mapAction:(UIBarButtonItem *)sender
{
    
}

#pragma mark -- 请求数据
//上拉加载
- (void)dropToRefresh
{
    __weak __typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.tableView reloadData];
            
            NSString *strUrl = [NSString stringWithFormat:@"http://www.molyo.com//mShop/getShopList?cityId=shenzhen&longitude=116.34349600000000&latitude=40.03029200000000&pageSize=8&currentPage=%ld&channelId=&categoryId=&sceneId=%@&districtId=&liveCircleId=&businessDistrictId=&netWork=wifi&device=MI+1SC&os=Android+4.1.2&osType=android",++ self.currentPage,self.scene.idStr];
            
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
            
            NSString *strUrl = [NSString stringWithFormat:kSceneDetailUrl,[[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"],self.scene.idStr];
            
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
    scene *b = [[SearchDataManager sharedDataManager]listArray][indexPath.row];
    ListInfoTableViewController *listInfoTVC = [ListInfoTableViewController new];
    listInfoTVC.shopId = b.idStr;
    [self.navigationController pushViewController:listInfoTVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205;
}

@end
