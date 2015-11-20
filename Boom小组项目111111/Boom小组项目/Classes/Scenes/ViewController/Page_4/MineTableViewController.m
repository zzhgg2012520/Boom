//
//  MineTableViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "MineTableViewController.h"

@interface MineTableViewController ()

@property (nonatomic, strong) UIImageView * imgView;

@end

@implementation MineTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        return self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人中心";
    
    // 背景图片
    [self addBackground];
    
}

// 背景图片
- (void)addBackground{
    
    // 背景
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -220, [UIScreen mainScreen].bounds.size.width, 220)];
    self.imgView.image = [UIImage imageNamed:@"我的界面背景"];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:self.imgView];
    self.tableView.contentInset = UIEdgeInsetsMake(220, 0, 0, 0);
    
    // 用户头像，姓名
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50, self.imgView.frame.origin.y + 25, 100, 100)];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.image = [UIImage imageNamed:@"yonghu"];
    [self.tableView addSubview:imgView];
    // 切圆角
    imgView.layer.cornerRadius = imgView.frame.size.width / 2;
    imgView.clipsToBounds = YES;
    // 边框
    [imgView.layer setBorderWidth:4];
    [imgView.layer setBorderColor:[[UIColor blackColor] CGColor]];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.frame.origin.y + imgView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 40)];
    label.text = @"不许叫我叔叔";
    label.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:label];
    
    // 体验 关注 粉丝
    [self addViewsToImageView];
    
}

// 体验 关注 粉丝
- (void)addViewsToImageView{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, -50, [UIScreen mainScreen].bounds.size.width, 50)];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.tableView addSubview:view];
    
    UILabel * expLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, [UIScreen mainScreen].bounds.size.width / 3, 33)];
    expLabel.text = @"体验";
    expLabel.textColor = [UIColor whiteColor];
    expLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:expLabel];
    
    UILabel * expNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -23, [UIScreen mainScreen].bounds.size.width / 3, 20)];
    expNumLabel.text = @"8";
    expNumLabel.textColor = [UIColor whiteColor];
    expNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:expNumLabel];
    
    UILabel * attLabel = [[UILabel alloc] initWithFrame:CGRectMake(expLabel.frame.size.width, expLabel.frame.origin.y, expLabel.frame.size.width, expLabel.frame.size.height)];
    attLabel.text = @"关注";
    attLabel.textColor = [UIColor whiteColor];
    attLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:attLabel];
    
    UILabel * attNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(expNumLabel.frame.size.width, expNumLabel.frame.origin.y, expNumLabel.frame.size.width, expNumLabel.frame.size.height)];
    attNumLabel.text = @"213";
    attNumLabel.textColor = [UIColor whiteColor];
    attNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:attNumLabel];
    
    UILabel * fansLabel = [[UILabel alloc] initWithFrame:CGRectMake(expLabel.frame.size.width * 2, expLabel.frame.origin.y, expLabel.frame.size.width, expLabel.frame.size.height)];
    fansLabel.text = @"粉丝";
    fansLabel.textColor = [UIColor whiteColor];
    fansLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:fansLabel];
    
    UILabel * fansNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(expNumLabel.frame.size.width * 2, expNumLabel.frame.origin.y, expNumLabel.frame.size.width, expNumLabel.frame.size.height)];
    fansNumLabel.text = @"46";
    fansNumLabel.textColor = [UIColor whiteColor];
    fansNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:fansNumLabel];
    
}

// 图片拉伸放大
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    if (y < -220) {
        CGRect frame = self.imgView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;
        self.imgView.frame = frame;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            static NSString * cellID = @"我的收藏";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
            label.text = @"我的收藏";
            [cell addSubview:label];
            
            return cell;
        }
            break;
        case 1:
        {
            static NSString * cellID = @"我的活动";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
            label.text = @"我的活动";
            [cell addSubview:label];
            
            return cell;
            break;
        }
        case 2:
        {
            static NSString * cellID = @"3";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
            
            return cell;
            break;
        }
        default:
            break;
    }
    
    static NSString * cellID = @"没用的cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    return cell;
    
}

// cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            self.hidesBottomBarWhenPushed = YES;
            CollectViewController * collectVC = [CollectViewController new];
            [self.navigationController pushViewController:collectVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
    
}

@end
