//
//  FirstPageTableViewController.m
//  Boom1.0
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "FirstPageTableViewController.h"

static NSString *const menuCellIdentifier = @"rotationCell";

@interface FirstPageTableViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
YALContextMenuTableViewDelegate
>

@property (nonatomic, strong) YALContextMenuTableView* contextMenuTableView;

@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuIcons;
@property (nonatomic ,strong) UIBarButtonItem * rightItem;
@property (nonatomic, strong) NSMutableArray * allData;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger temp;

@end


@implementation FirstPageTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.currentPage = 1;
    
    [self initiateMenuOptions];
    
    // 自定义rightBarButtonItem
    self.rightItem = [[UIBarButtonItem alloc] initWithTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"cityName"] style:UIBarButtonItemStyleDone target:self action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:16], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    //添加leftBarButtonItem
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_scan_white.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    
    // title
    self.navigationItem.title = @"多啦";

    // 去掉cell横线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 下拉刷新
    [self dropToRefresh];
    // 上拉加载
    [self pullToLoadData];

}

- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[Two_dimensional_codeViewController new] animated:YES ];
    self.hidesBottomBarWhenPushed = NO;
}

// 下拉刷新
- (void)dropToRefresh{
    
    __weak __typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 模拟延迟加强用户体验
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];

            // 清空数组
            [self.allData removeAllObjects];
            self.currentPage = 1;
            
            // 数据解析
            [self requestDataWithString:[NSString stringWithFormat:@"http://www.molyo.com//mIndex/getInfoV1_7?cityId=%@&pageSize=8&currentPage=1&netWork=wifi", [[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"]]];
            
            self.temp = self.allData.count;
            
            [self.tableView reloadData];
            [weakSelf.tableView.header endRefreshing];
            
            // 恢复数据加载状态
            [weakSelf.tableView.footer resetNoMoreData];
        });
    }];
    [self.tableView.header beginRefreshing];

}

// 上拉加载
- (void)pullToLoadData{
    
    __weak __typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        // 模拟延迟加强用户体验
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
  
            NSString * url_string = [NSString stringWithFormat:@"http://www.molyo.com//mIndex/getInfoV1_7?cityId=%@&pageSize=8&currentPage=%ld&netWork=wifi", [[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"], ++self.currentPage];
            [self requestDataWithString:url_string];
            [self.tableView reloadData];
            
            [weakSelf.tableView.footer endRefreshing];
            
            // 提示没有更多数据
            if (self.temp == self.allData.count) {
                // 进入加载完成所有数据状态
                [weakSelf.tableView.footer endRefreshingWithNoMoreData];
            }else{
                self.temp = self.allData.count;
            }
        });
    }];
    
}

// 数据解析
- (void)requestDataWithString:(NSString *)string{
    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:string]];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary * dic in dict[@"body"][@"subjectList"]){
        SubjectList * model = [SubjectList new];
        [model setValuesForKeysWithDictionary:dic];
        [self.allData addObject:model];
    }
    [self.tableView reloadData];
    
}

- (void)rightButton:(UIButton *)sender{
    
    // init YALContextMenuTableView tableView
    if (!self.contextMenuTableView) {
        self.contextMenuTableView = [[YALContextMenuTableView alloc]initWithTableViewDelegateDataSource:self];
        self.contextMenuTableView.animationDuration = 0.15;
        //optional - implement custom YALContextMenuTableView custom protocol
        self.contextMenuTableView.yalDelegate = self;
        
        //register nib
        UINib *cellNib = [UINib nibWithNibName:@"ContextMenuCell" bundle:nil];
        [self.contextMenuTableView registerNib:cellNib forCellReuseIdentifier:menuCellIdentifier];
    }
    
    // it is better to use this method only for proper animation
    [self.contextMenuTableView showInView:self.navigationController.view withEdgeInsets:UIEdgeInsetsZero animated:YES];
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    //should be called after rotation animation completed
    [self.contextMenuTableView reloadData];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.contextMenuTableView updateAlongsideRotation];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //should be called after rotation animation completed
        [self.contextMenuTableView reloadData];
    }];
    [self.contextMenuTableView updateAlongsideRotation];
    
}

- (void)initiateMenuOptions {
    
    self.menuTitles = @[@"",
                        @"广州",
                        @"杭州",
                        @"上海",
                        @"深圳",
                        @"厦门"];
    
    self.menuIcons = @[[UIImage imageNamed:@"关闭2"],
                       [UIImage imageNamed:@"qita"],
                       [UIImage imageNamed:@"hangzhou"],
                       [UIImage imageNamed:@"shanghai"],
                       [UIImage imageNamed:@"shenzhen"],
                       [UIImage imageNamed:@"guangzhou"]];
    
}

#pragma mark - YALContextMenuTableViewDelegate
- (void)contextMenuTableView:(YALContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
            return;
            break;
        }
        case 1:
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cityName"];
            [[NSUserDefaults standardUserDefaults] setObject:@"广州  " forKey:@"cityName"];
            self.rightItem.title = [[NSUserDefaults standardUserDefaults] valueForKey:@"cityName"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cityId"];
            [[NSUserDefaults standardUserDefaults] setObject:@"guangzhou" forKey:@"cityId"];

            self.currentPage = 1;
            
            // 数据解析
            [self dropToRefresh];

            break;
        }
        case 2:
        {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cityName"];
            [[NSUserDefaults standardUserDefaults] setObject:@"杭州  " forKey:@"cityName"];
            self.rightItem.title = [[NSUserDefaults standardUserDefaults] valueForKey:@"cityName"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cityId"];
            [[NSUserDefaults standardUserDefaults] setObject:@"hangzhou" forKey:@"cityId"];

            self.currentPage = 1;
            
            // 数据解析
            [self dropToRefresh];

            break;
        }
        case 3:
        {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cityName"];
            [[NSUserDefaults standardUserDefaults] setObject:@"上海  " forKey:@"cityName"];
            self.rightItem.title = [[NSUserDefaults standardUserDefaults] valueForKey:@"cityName"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cityId"];
            [[NSUserDefaults standardUserDefaults] setObject:@"shanghai" forKey:@"cityId"];

            self.currentPage = 1;
            
            // 数据解析
            [self dropToRefresh];

            break;
        }
        case 4:
        {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cityName"];
            [[NSUserDefaults standardUserDefaults] setObject:@"深圳  " forKey:@"cityName"];
            self.rightItem.title = [[NSUserDefaults standardUserDefaults] valueForKey:@"cityName"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cityId"];
            [[NSUserDefaults standardUserDefaults] setObject:@"shenzhen" forKey:@"cityId"];

            self.currentPage = 1;
            
            // 数据解析
            [self dropToRefresh];
            
            break;
        }
        case 5:
        {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cityName"];
            [[NSUserDefaults standardUserDefaults] setObject:@"厦门  " forKey:@"cityName"];
            self.rightItem.title = [[NSUserDefaults standardUserDefaults] valueForKey:@"cityName"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cityId"];
            [[NSUserDefaults standardUserDefaults] setObject:@"xiamen" forKey:@"cityId"];

            self.currentPage = 1;
            
            // 数据解析
            [self dropToRefresh];
            
            break;
        }
        default:
            break;
    }
}

// cell 点击事件
- (void)tableView:(YALContextMenuTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:self.contextMenuTableView]) {
        [tableView dismisWithIndexPath:indexPath];
    }else{
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        // 获取模型
        SubjectList * subjectList = self.allData[indexPath.row];
        
        // 页面跳转
        self.hidesBottomBarWhenPushed = YES;
        FirstPageListTableViewController
        * firstPageListTVC = [FirstPageListTableViewController new];
        firstPageListTVC.subId = subjectList.subId;
        firstPageListTVC.subjectList = subjectList;
        [self.navigationController pushViewController:firstPageListTVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }
    
}

#pragma mark - Table view data source

// cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:self.contextMenuTableView]) {
        return self.menuTitles.count;
    }
    return self.allData.count;
    
}

// cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:self.contextMenuTableView]) {
        
        ContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
        
        if (cell) {
            cell.menuTitleLabel.text = [self.menuTitles objectAtIndex:indexPath.row];
            cell.menuImageView.image = [self.menuIcons objectAtIndex:indexPath.row];
        }
        
        return cell;
    }
    
    static NSString * cellID = @"FirstPageCell";
    FirstPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FirstPageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    SubjectList * subjectList = self.allData[indexPath.row];
    cell.titleLabel.text = subjectList.title;
    cell.subTitleLabel.text = subjectList.subTitle;
    cell.typeLabel.text = subjectList.tag;
    cell.typeImageView.image = [UIImage imageNamed:@"类型背景"];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:subjectList.img]];
    return cell;
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:self.contextMenuTableView]) {
        return 65;
    }
    return 200;
    
}

// 懒加载
- (NSMutableArray *)allData{
    
    if (!_allData) {
        self.allData = [NSMutableArray array];
    }
    return _allData;
    
}

@end
