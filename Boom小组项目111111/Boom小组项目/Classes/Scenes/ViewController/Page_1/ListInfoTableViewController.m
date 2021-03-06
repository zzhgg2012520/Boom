//
//  ListInfoTableViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ListInfoTableViewController.h"

@interface ListInfoTableViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;
// 用来接收webView高度
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) ItemInfoDescrModel * descrModel;

@property (nonatomic, strong) NSMutableArray * scrollViewArray;

@property (nonatomic, strong) NSString * string;

@end

@implementation ListInfoTableViewController

// 重写init方法，把tableView 的 style设置为UITableViewStyleGrouped（默认是                          UITableViewStylePlain）
-(instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
        return self;
        
    }
    
    return self;
    
}

// Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.000001;
    
}

// Footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10;
    }
    return 0.000001;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 去掉返回按钮文字
    UIBarButtonItem * backButton = [UIBarButtonItem new];
    backButton.title = @"";
    self.navigationItem.backBarButtonItem = backButton;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.string = [NSString stringWithFormat:URL_ForDescr, self.shopId];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"NET"] isEqualToString:@"1"]) {
        [self requestDataForScrollViewWithString:self.string];
        [self requestDataForDescrWithString:self.string];
    }else{
        self.view.userInteractionEnabled = NO;
    }
    
    
}

// 解析轮播图图片
- (void)requestDataForScrollViewWithString:(NSString *)string{

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary * dic in dict[@"body"][@"imgs"]) {
            ScrollViewModel * model = [ScrollViewModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.scrollViewArray addObject:model.mImg];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        });
        
    }];
    [task resume];
    
}

// 解析
- (void)requestDataForDescrWithString:(NSString *)string{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.descrModel = [ItemInfoDescrModel new];
        [self.descrModel setValuesForKeysWithDictionary:dict[@"body"]];
        // 主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:1 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath2] withRowAnimation:UITableViewRowAnimationNone];
        });
    }];
    [task resume];
    
}

#pragma mark - Table view data source

// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

// 每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
        {
            return 2;
            break;
        }
        case 1:
        {
            return 2;
            break;
        }
        default:
            return 0;
            break;
    }
    
}

// cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (indexPath.section) {
        case 0:
        {
            // 第一组第一行
            if (indexPath.row == 0) {
                
                static NSString * cellID = @"FirstItemInfoCell";
                FirstItemInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell = [[FirstItemInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                    
                    cell.array = self.scrollViewArray;
                    
                }
                return cell;
            }
            
            // 第一组第二行
            if (indexPath.row == 1) {
                
                static NSString * cellID = @"ItemInfoDescrCell";
                ItemInfoDescrCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell = [[ItemInfoDescrCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
#warning 判断是否已经刷新，没刷新就给默认值
                    cell.model = self.descrModel;
                    self.navigationItem.title = self.descrModel.name;
    
                }
                return cell;
            }
            
            break;
        }
        
        // 第二组
        case 1:
        {
            // 第二组第一行
            if (indexPath.row == 0) {
                
                static NSString * cellID = @"Label";
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                    
                    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
                    label.text = @"特色介绍";
                    label.font = [UIFont systemFontOfSize:20];
                    [cell addSubview:label];
                    
                }
                cell.userInteractionEnabled = NO;
                return cell;
            }
            
            // 第二组第二行
            if (indexPath.row == 1) {
                
                static NSString * cellID = @"webViewCell";
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                    // webView初始化
                    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
                    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:URL_ForWebView, self.shopId]]];
                    
                    [self.webView loadRequest:request];
                    self.webView.delegate = self;
                    self.webView.scrollView.scrollEnabled = NO;
                    [cell addSubview:self.webView];
                }
                cell.userInteractionEnabled = NO;
                return cell;
                
            }
            break;
        }
        default:
            break;
    }
    
    // 没用的
    static NSString * cellID = @"temp";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
    
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 属性接收的高度设为web高度
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                return 220;
            }else{
                return 95;
            }
            break;
        }
        case 1:
        {
            if (indexPath.row == 0) {
                return 40;
            }else{
                return self.height;
            }
            break;
        }
        default:
            break;
    }
    return 1;
    
}

/**
 *  webView完成加载
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    UIScrollView *webViewScroll = webView.subviews[0];
    webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webViewScroll.contentSize.width, webViewScroll.contentSize.height);
    
    // 用属性接收高度
    self.height = webView.frame.size.height;

    // 刷新
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    
}

// cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    ShopInfoTableViewController * shopInfoTVC = [ShopInfoTableViewController new];
    shopInfoTVC.descrModel = self.descrModel;
    shopInfoTVC.string = self.string;
    [self.navigationController pushViewController:shopInfoTVC animated:YES];
    
}

// 懒加载
-(NSMutableArray *)scrollViewArray{
    
    if (!_scrollViewArray) {
        self.scrollViewArray = [NSMutableArray array];
    }
    return _scrollViewArray;
}

@end
