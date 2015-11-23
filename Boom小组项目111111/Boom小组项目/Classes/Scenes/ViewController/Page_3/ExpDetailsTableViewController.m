//
//  ExpDetailsTableViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ExpDetailsTableViewController.h"

@interface ExpDetailsTableViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *allDataArray;
@property (nonatomic, strong) NSMutableArray *allDataArray_1;

@property (nonatomic, strong) UITableView *ExpDetailsTableView;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSString *shopID;

@end

@implementation ExpDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentPage = 1;
    self.hidesBottomBarWhenPushed = YES;
    self.title = @"体验详情";
    self.ExpDetailsTableView.frame = self.view.frame;
    self.ExpDetailsTableView.delegate = self;
    self.ExpDetailsTableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpDetHeader_2TableViewCell" bundle:nil]  forHeaderFooterViewReuseIdentifier:@"ExpDetH_2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpDetHeader_3TableViewCell" bundle:nil] forCellReuseIdentifier:@"ExpDetH_3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpDet_1TableViewCell" bundle:nil] forCellReuseIdentifier:@"ExpDet_1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpDetDisTableViewCell" bundle:nil] forCellReuseIdentifier:@"EDDID"];
    [self.tableView registerClass:[LunBoTu class] forHeaderFooterViewReuseIdentifier:@"LBT"];
    
    NSString * url_string = [NSString stringWithFormat:@"http://www.molyo.com//mExperience/getInfo?id=%@&accessToken=1511161452277577954b2bec4045110d&device=m2&os=Android+5.1&osType=android&netWork=wifi",self.expID];
    
    [self requestDataWithListString:url_string];
    [self.tableView reloadData];
    
    NSString *url_string_1 = [NSString stringWithFormat:@"http://www.molyo.com//mExperience/response/getList?businessId=%@&pageSize=8&currentPage=1&accessToken=",self.expID];
    
    [self requestDataWithListString_1:url_string_1];
    
}

#pragma mark - 解析数据

- (void)requestDataWithListString:(NSString *)string
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.allDataArray = [NSMutableArray arrayWithCapacity:20];

        ExpDetails *model = [ExpDetails new];
        [model setValuesForKeysWithDictionary:dict[@"body"]];
        [self.allDataArray addObject:model];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [task resume];
    
}

- (void)requestDataWithListString_1:(NSString *)string
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in dict[@"body"][@"list"]) {
            Discuss *model = [Discuss new];
            [model setValuesForKeysWithDictionary:dic];
            [self.allDataArray_1 addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [task resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allDataArray_1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExpDetDisTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDDID" forIndexPath:indexPath];
    Experience * model = self.allDataArray_1[indexPath.row];
    cell.experience = model;
    return cell;
}

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ExpDetHeader_2TableViewCell *reuseView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ExpDetH_2"];
    ExpDetails *model = self.allDataArray[section];
    reuseView.ExpDetails = model;
//    self.tableView.tableHeaderView = reuseView;
    self.shopID = model.shopId;
    [reuseView.shopNameBtn addTarget:self action:@selector(shopNameBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return reuseView;
}

//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 412;
    if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(- scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(- sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)shopNameBtnAction:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    ListInfoTableViewController *LITVC = [ListInfoTableViewController new];
    LITVC.shopId = self.shopID;
    [self.navigationController pushViewController:LITVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 412;
}

- (NSMutableArray *)allDataArray_1{
    
    if (!_allDataArray_1) {
        self.allDataArray_1 = [NSMutableArray array];
    }
    return _allDataArray_1;
    
}

@end
