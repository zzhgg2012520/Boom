//
//  ActivityTableViewController.m
//  Boom1.0
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ActivityTableViewController.h"

@interface ActivityTableViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *ActivityTableView;
@property (nonatomic, strong) NSMutableArray *allDataArray;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSString *actID;

@end

@implementation ActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    
    self.ActivityTableView.frame = CGRectMake(SCROLLWIDTH_3, 0, SCROLLWIDTH_3, SCROLLHEIGHT_3);
    
    self.ActivityTableView.dataSource = self;
    self.ActivityTableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"actID"];
    
    //下拉加载
    [self pullToLoadData];
    //上拉刷新
    [self dropToRefresh];

    //影藏tableView线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [[SearchDataManager sharedDataManager] setExtraCellHidden:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 解析数据

- (void)requestDataWithListString:(NSString *)string
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in dict[@"body"][@"list"]) {
            Activity *model = [Activity new];
            [model setValuesForKeysWithDictionary:dic];
            [self.allDataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [task resume];
}

#pragma mark -上拉加载

- (void)pullToLoadData
{
    __weak __typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.tableView reloadData];
            NSString * url_string = [NSString stringWithFormat:@"http://www.molyo.com//mActive/getList?cityId=%@&businessId=&pageSize=8&currentPage=%ld&sort=t", [[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"], ++self.currentPage];
            [self requestDataWithListString:url_string];
            
            [self.tableView reloadData];
            
            [weakSelf.tableView.footer endRefreshing];
        });
    }];
    self.tableView.footer.hidden = YES;
    
}

#pragma mark - 下拉刷新

- (void)dropToRefresh
{
    __weak __typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 模拟延迟加载数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.tableView reloadData];
            // 清空数组
            [self.allDataArray removeAllObjects];
            // 数据解析
            [self requestDataWithListString:[NSString stringWithFormat:@"http://www.molyo.com//mActive/getList?cityId=%@&businessId=&pageSize=8&currentPage=1&sort=t", [[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"]]];
            
            [self.tableView reloadData];
            // 结束刷新
            [weakSelf.tableView.header endRefreshing];
        });
        
    }];
    [self.tableView.header beginRefreshing];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"actID" forIndexPath:indexPath];
    
    Activity *a = self.allDataArray[indexPath.section];
    
    [cell.actImgView sd_setImageWithURL:[NSURL URLWithString:a.img]];
    cell.actTitleLbl.text = a.title;
    cell.actTimeLbl.text = a.dateTimeParse;
    cell.actAdressLbl.text = a.address;
    cell.actTypeLbl.text = a.type;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    ActDetTableViewController *ADTVC = [ActDetTableViewController new];
    Activity *a = self.allDataArray[indexPath.section];
    ADTVC.actID = a.Id;
    [self.navigationController pushViewController:ADTVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (UITableView *)ActivityTableView
{
    if (!_ActivityTableView) {
        self.ActivityTableView = [UITableView new];
    }
    return _ActivityTableView;
}

- (NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray new];
    }
    return _allDataArray;
}

@end
