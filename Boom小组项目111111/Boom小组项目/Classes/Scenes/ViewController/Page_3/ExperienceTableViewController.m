//
//  ExperienceTableViewController.m
//  Boom1.0
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ExperienceTableViewController.h"

@interface ExperienceTableViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *ExperienceTableView;
@property (nonatomic, strong) NSMutableArray *allDataArray;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSString *shopID;
@property (nonatomic, strong) NSString *expID;

@end

@implementation ExperienceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    
    self.ExperienceTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCROLLWIDTH_3, SCROLLHEIGHT_3) style:UITableViewStyleGrouped];
    
    self.ExperienceTableView.dataSource = self;
    self.ExperienceTableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:@"expID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"expHID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpFooterTableViewCell" bundle:nil] forCellReuseIdentifier:@"expFID"];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"NET"] isEqualToString:@"1"]) {
        [self pullToLoadData];
        [self dropToRefresh];
    }else{
        self.view.userInteractionEnabled = NO;
    }
    
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
            Experience *model = [Experience new];
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
            NSString * url_string = [NSString stringWithFormat:@"http://www.molyo.com//mExperience/getFineList?cityId=%@&shopId=&pageSize=8&currentPage=%ld&accessToken=&netWork=wifi", [[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"], ++self.currentPage];
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
            [self requestDataWithListString:[NSString stringWithFormat:@"http://www.molyo.com//mExperience/getFineList?cityId=%@&shopId=&pageSize=8&currentPage=1&accessToken=&netWork=wifi", [[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"]]];
            
            [self.tableView reloadData];
            // 结束刷新
            [weakSelf.tableView.header endRefreshing];
        });
        
    }];
    [self.tableView.header beginRefreshing];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.allDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [UITableViewCell new];
    
    switch (indexPath.row) {
        case 0:{
            
            ExpHeaderTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"expHID" forIndexPath:indexPath];
            
            headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
            headerCell.separatorInset = UIEdgeInsetsMake(0, self.view.frame.size.width / 2, 0, self.view.frame.size.width / 2);
            
            cell = headerCell;
            
            Experience *e = self.allDataArray[indexPath.section];
            
            [headerCell.userImgView sd_setImageWithURL:[NSURL URLWithString:e.userImg]];
            
            [headerCell.userNameBtn setTitle:e.userName forState:UIControlStateNormal];
            [headerCell.userNameBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            
            NSRange range = NSMakeRange(5, 11);
            NSString *cTime = [e.createTime substringWithRange:range];
            headerCell.creatTimeLbl.text = cTime;
            
            break;
        }
        case 1:{
            
            ExperienceTableViewCell *expCell = [tableView dequeueReusableCellWithIdentifier:@"expID" forIndexPath:indexPath];
            
            expCell.selectionStyle = UITableViewCellSelectionStyleNone;
            expCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 10);
            
            cell = expCell;
            
            Experience *e = self.allDataArray[indexPath.section];
            
            [expCell.coverImgView sd_setImageWithURL:[NSURL URLWithString:e.cover] placeholderImage:nil];
            expCell.desLbl.text = e.desc;
            
            break;
        }
        case 2:{
            
            ExpFooterTableViewCell *footerCell = [tableView dequeueReusableCellWithIdentifier:@"expFID" forIndexPath:indexPath];
            
            footerCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell = footerCell;
            
            Experience *e = self.allDataArray[indexPath.section];
            
            [footerCell.shopNameBtn setTitle:e.shopName forState:UIControlStateNormal];
            
            [footerCell.shopNameBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            
            footerCell.discussCountLbl.text = e.praiseCount;
            footerCell.collectCountLbl.text = e.resCount;
            
            self.shopID = e.shopId;
            
            [footerCell.shopNameBtn addTarget:self action:@selector(shopNameBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
    }
    
    return cell;
}

- (void)shopNameBtnAction:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    ListInfoTableViewController *LITVC = [ListInfoTableViewController new];
    LITVC.shopId = self.shopID;
    [self.navigationController pushViewController:LITVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    
    switch (indexPath.row) {
        case 0:{
            
            height = 40;
            break;
        }
        case 1:{
            
            height = 280;
            break;
        }
        case 2:{
            
            height = 40;
            break;
        }
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            
            break;
        }
        case 1:{
            
            ExpDetailsTableViewController *EDTVC = [ExpDetailsTableViewController new];
            
            Experience *e = self.allDataArray[indexPath.section];
            
            EDTVC.expID = e.Id;
            
            [self.navigationController pushViewController:EDTVC animated:YES];
            
            break;
        }
        case 2:{
            
            break;
        }
    }
}

- (UITableView *)ExperienceTableView
{
    if (!_ExperienceTableView) {
        self.ExperienceTableView = [UITableView new];
    }
    return _ExperienceTableView;
}

- (NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray new];
    }
    return _allDataArray;
}

@end
