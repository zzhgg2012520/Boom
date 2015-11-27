//
//  BeSearchedTableViewController.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/18.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "BeSearchedTableViewController.h"

@interface BeSearchedTableViewController ()

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) UIAlertController *alertController;

@end

@implementation BeSearchedTableViewController

static NSString *const listCellID = @"listCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"精心搜索的小店";
    
    //修改了navigationBar.barTintColor背景的颜色和tintColor的字体颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    //当前页的页号
    self.currentPage = 1;
    
#pragma mark -- 请求数据：刷新，加载, 刷新数据
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"NET"] isEqualToString:@"1"]) {
        [self pullTlLoadData];
        [self dropToRefresh];
    }
    
    [SearchDataManager sharedDataManager].result = ^(){
        
#pragma mark -- 判断是否有数据，无数据弹出alertView提示
        if ([[[SearchDataManager sharedDataManager]                                                                                                                                                  listArray] count] < 1) {
            [self addAlertView];
        }
        
        [self.tableView reloadData];
    };
    
    //注册listCell
    [self.tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:listCellID];
    
    //隐藏tabBar
    self.tabBarController.tabBar.hidden = YES;
 
}

- (void)addAlertView
{
    _alertController = [UIAlertController alertControllerWithTitle:@"嗨！亲" message:@"没有搜索出内容，请换搜索关键词。请输入商圈，地点，商户名。" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction * action = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //block回调上一个页面
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [_alertController addAction:action];
    
    [self presentViewController:_alertController animated:YES completion:nil];
}

#pragma mark -- 请求数据
//上拉加载
- (void)dropToRefresh
{
    __weak __typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.tableView reloadData];
            
            NSString *strUrl = [NSString stringWithFormat:kSearchUrl,[[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"],self.qStr,++ self.currentPage];
            
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
            
            NSString *strUrl = [NSString stringWithFormat:kSearchUrl,[[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"],_qStr,self.currentPage];
            
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
