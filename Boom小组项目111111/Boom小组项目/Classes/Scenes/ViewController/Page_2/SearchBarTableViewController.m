//
//  SearchBarTableViewController.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/18.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "SearchBarTableViewController.h"

@interface SearchBarTableViewController ()<UISearchBarDelegate>

@property (nonatomic, retain) NSMutableArray *allDataArray;                     // 存放所有数据的数组
@property (nonatomic, retain) NSMutableArray *searchResultDataArray;            // 存放搜索出结果的数组

@property (nonatomic, retain) UISearchController *searchController;             // 搜索控制器
@property (nonatomic, retain) UITableViewController *searchTVC;                 // 搜索使用的表示图控制器
@property (nonatomic,strong) UISearchBar *searchBar;

@end

@implementation SearchBarTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"搜搜";
    
    //影藏tableView线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [[SearchDataManager sharedDataManager] setExtraCellHidden:self.tableView];
    
    [self loadViews];
    //[self loadData];
    
}

#pragma mark - ~~
#pragma mark 加载视图
- (void)loadViews
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCROLLWIDTH, 44)];
    self.searchBar.placeholder = @"请输入商圈，地点，商户名";
    
    //代理事件
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.hidesBottomBarWhenPushed = YES;
    BeSearchedTableViewController *beSearchTVC = [BeSearchedTableViewController new];
    beSearchTVC.qStr = [SearchBarTableViewController hexStringFromString:searchBar.text];
    [self.navigationController pushViewController:beSearchTVC animated:YES];
}

+ (NSString *)hexStringFromString:(NSString *)string
{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length] == 1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@%@",hexStr,@"%",newHexStr];
    }
    int i = 0;
    for (i = 0 ; i < [hexStr length]; i ++) {
        char c = [hexStr characterAtIndex:i];
        if ('a' <= i || i <= 'b') {
            c = c - 32;
        }
    }
    //字符串中所有小写字母转化为大写
    return [hexStr uppercaseString];
}

@end
