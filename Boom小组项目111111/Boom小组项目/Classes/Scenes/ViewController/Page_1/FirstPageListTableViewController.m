//
//  FirstPageListTableViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "FirstPageListTableViewController.h"

@interface FirstPageListTableViewController ()

@property (nonatomic, strong) NSMutableArray * firstCellArray;
@property (nonatomic, strong) NSMutableArray * secondCellArray;

@end

@implementation FirstPageListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tableView的属性设置
    [self setUpTableView];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"NET"] isEqualToString:@"1"]) {
        // 数据解析
        [self requestData];
    }else{
        self.view.userInteractionEnabled = NO;
    }
    
    // 去掉返回按钮文字
    UIBarButtonItem * backButton = [UIBarButtonItem new];
    backButton.title = @"";
    self.navigationItem.backBarButtonItem = backButton;
    
    // 自定义titleView
    [self customTitleView];
    
    // 收藏按钮
    [self addRightBarButtonItem];

}

- (void)viewWillAppear:(BOOL)animated{

    // 判断是否已登录
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser == nil) {
        
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"sign_star"];
        
    }else{
        
        // 如果已被收藏
        ModelForListCell * model = self.firstCellArray[0];
        if ([[ShopDataManager shareDataManager] getCollectWithTitle:model.title] != nil){
            
            self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"sign_stared"];
        }
    }
}

// 数据解析
- (void)requestData{
    
    NSString * string = [NSString stringWithFormat:URL_FirstPageList, self.subId];
    [self requsetDataForFirstCellWithString:string];
    [self requsetDataForSecondCellWithString:string];
    
}

// 自定义titleView
- (void)customTitleView{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200,44)];
    label.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    ModelForListCell * model = self.firstCellArray[0];
    label.text = model.title;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    self.navigationItem.titleView.hidden = YES;
    
}

// 标题动态渐变显示
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 65) {
        self.navigationItem.titleView.hidden = NO;
        self.navigationItem.titleView.alpha  =  (scrollView.contentOffset.y  - 65 )/ 85;
    }else{
        self.navigationItem.titleView.hidden = YES;
    }
    
}

// 收藏按钮
- (void)addRightBarButtonItem{

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sign_star"] style:UIBarButtonItemStyleDone target:self action:@selector(collect:)];
    
}

// 收藏事件
- (void)collect:(UIBarButtonItem *)sender{

    // 判断是否已登录
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser == nil) {
        
        LoginViewController * loginVC = [LoginViewController new];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }else
    {
        ModelForListCell * model = self.firstCellArray[0];
        if ([[ShopDataManager shareDataManager] getCollectWithTitle:model.title] == nil) {
            
            // 如果未被收藏
            sender.image = [UIImage imageNamed:@"sign_stared"];
            [[ShopDataManager shareDataManager] addCollectTitle:model.title subTitle:model.subTitle img:model.image subId:self.subId];
        }else{
            
            // 如果已被收藏
            sender.image = [UIImage imageNamed:@"sign_star"];
            [[ShopDataManager shareDataManager] deleteCollectWithTitle:model.title];
        }
    }
}

// tableView的属性设置
- (void)setUpTableView{
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
}

// 第一组cell数据解析
- (void)requsetDataForFirstCellWithString:(NSString *)string{
    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:string]];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    ModelForListCell * model = [ModelForListCell new];
    [model setValuesForKeysWithDictionary:dict[@"body"]];
    [self.firstCellArray addObject:model];
}

// 第二组cell数据解析
- (void)requsetDataForSecondCellWithString:(NSString *)string{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary * dic in dict[@"body"][@"contents"]){
            ModelForContents * model = [ModelForContents new];
            [model setValuesForKeysWithDictionary:dic];
            [self.secondCellArray addObject:model];
        }
        // 主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        });

    }];
    
    [task resume];
    
    
}

// 分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
        
    }else{
        
        return self.secondCellArray.count;
        
    }
    
}

// cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 第一组
    if (indexPath.section == 0) {
        
        static NSString * cellID = @"FirstPageListTableViewCell";
        FirstPageListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[FirstPageListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        ModelForListCell * model = self.firstCellArray[indexPath.row];
        cell.modelForListCell = model;
        cell.userInteractionEnabled = NO;
        return cell;

    }else{
        
        // 第二组
        static NSString * cellID = @"ListItemTableViewCell";
        ListItemTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ListItemTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        ModelForContents * model = self.secondCellArray[indexPath.row];
        cell.model = model;
        return cell;
        
    }
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        ModelForListCell * model = self.firstCellArray[indexPath.row];
        return [FirstPageListTableViewCell calcHeightForCellWithModelForListCell:model];
        
    }else{
        
        ModelForContents * model = self.secondCellArray[indexPath.row];
        return [ListItemTableViewCell calcHeightForCellWithModelForContents:model] - 3;
        
    }
}

// cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    // 跳转
    self.hidesBottomBarWhenPushed = YES;
    ModelForContents * model = self.secondCellArray[indexPath.row];
    ListInfoTableViewController * listInfoTVC = [ListInfoTableViewController new];
    listInfoTVC.shopId = model.businessId;
    [self.navigationController pushViewController:listInfoTVC animated:YES];
}

// 懒加载
-(NSMutableArray *)firstCellArray{
    
    if (!_firstCellArray) {
        self.firstCellArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _firstCellArray;
    
}
// 懒加载
-(NSMutableArray *)secondCellArray{
    
    if (!_secondCellArray) {
        self.secondCellArray = [NSMutableArray array];
    }
    return _secondCellArray;
    
}

@end
