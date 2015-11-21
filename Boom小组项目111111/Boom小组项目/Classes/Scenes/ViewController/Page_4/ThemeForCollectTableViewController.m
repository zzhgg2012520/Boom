//
//  ThemeForCollectTableViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ThemeForCollectTableViewController.h"

@interface ThemeForCollectTableViewController ()

@end

@implementation ThemeForCollectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去掉cell横线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[ShopDataManager shareDataManager] getAllCollect].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString * cellID = @"FirstPageCell";
    FirstPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FirstPageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    Collect_Type_Model * model = [[ShopDataManager shareDataManager] getAllCollect][indexPath.row];
    cell.titleLabel.text = model.title;
    cell.subTitleLabel.text = model.subTitle;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    return cell;
    
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 页面跳转
    self.hidesBottomBarWhenPushed = YES;
    FirstPageListTableViewController
    * firstPageListTVC = [FirstPageListTableViewController new];
    Collect_Type_Model * model = [[ShopDataManager shareDataManager] getAllCollect][indexPath.row];
    firstPageListTVC.subId = model.subId;
    [self.navigationController pushViewController:firstPageListTVC animated:YES];

    
}

@end
