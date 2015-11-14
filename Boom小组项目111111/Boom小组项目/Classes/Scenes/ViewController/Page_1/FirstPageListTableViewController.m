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
    
    NSString * string = [NSString stringWithFormat:URL_FirstPageList, self.subId];
    [self requsetDataForFirstCellWithString:string];
    [self requsetDataForSecondCellWithString:string];
    
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
    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:string]];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary * dic in dict[@"body"][@"contents"]){
        ModelForContents * model = [ModelForContents new];
        [model setValuesForKeysWithDictionary:dic];
        [self.secondCellArray addObject:model];
    }

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
