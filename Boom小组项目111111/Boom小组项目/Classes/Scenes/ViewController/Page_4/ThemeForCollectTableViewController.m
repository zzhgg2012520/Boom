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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString * cellID = @"FirstPageCell";
    FirstPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FirstPageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    SubjectList * subjectList = self.allData[indexPath.row];
//    cell.titleLabel.text = subjectList.title;
//    cell.subTitleLabel.text = subjectList.subTitle;
//    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:subjectList.img]];
    
    return cell;
    
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
    
}

@end
