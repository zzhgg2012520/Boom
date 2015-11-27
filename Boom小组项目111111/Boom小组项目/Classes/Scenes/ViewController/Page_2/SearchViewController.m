//
//  SearchViewController.m
//  Boom1.0
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>

//searchBar
@property (nonatomic,strong) UISearchBar *searchBar;

//查找方式：near，easy，food，all
@property (nonatomic,strong) UIButton *nearButton;
@property (nonatomic,strong) UIButton *easyButton;
@property (nonatomic,strong) UIButton *foodButton;
@property (nonatomic,strong) UIButton *allButton;

//场景scene
@property (nonatomic,strong) UICollectionView *sceneCollectionView;

//商圈business
@property (nonatomic,strong) UITableView *businessTableView;

//sceneNSMutableArray
@property (nonatomic,strong) NSMutableArray *scenePicArray;

@end

@implementation SearchViewController

static NSString *const businessCellID = @"business";
static NSString *const sceneCellID = @"scene";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查找";
#pragma mark -- 布局导航条上的searchBar;  四个near,easy,food,all(button);  sceneCollectionView; businessTableView;
    [self addView];
    
#pragma mark -- scenePicArray

#pragma mark -- register sceneCollectionViewCell and BusinessCell
    [self.sceneCollectionView registerNib:[UINib nibWithNibName:@"sceneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:sceneCellID];
    [self.businessTableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:businessCellID];
    
#pragma mark -- request scenelist data
    [self requestSceneList];
    
#pragma mark -- request business data
//    [self requestBusiness];
    
#pragma mark -- cell分割线(无)
    self.businessTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
#pragma mark -- 刷新数据 block 回调
    [SearchDataManager sharedDataManager].result = ^(){
        [self.sceneCollectionView reloadData];
        [self.businessTableView reloadData];
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [self requestBusiness];
    [self.businessTableView reloadData];
}

- (void)addView
{
#pragma mark -- searchBarButton
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCROLLWIDTH - 20, 44)];
    [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"search_pic"] forState:UIControlStateNormal];

    button.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = button;
    
#pragma mark -- scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(SCROLLWIDTH, 2 * SCROLLHEIGHT);
    
#pragma mark -- style of find：near，easy，food，all
    //near
    self.nearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nearButton.frame = CGRectMake(0, 0, SCROLLWIDTH / 2 - 1, SCROLLHEIGHT / 6 - 1);
    [self.nearButton setImage:[UIImage imageNamed:@"img_category_nearyby"] forState:UIControlStateNormal];
    self.nearButton.backgroundColor =[UIColor whiteColor];
    [self.nearButton addTarget:self action:@selector(nearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.nearButton];
    
    //easy
    self.easyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.easyButton.frame = CGRectMake(SCROLLWIDTH / 2 , 0, SCROLLWIDTH / 2, SCROLLHEIGHT / 6-1);
    self.easyButton.backgroundColor = [UIColor whiteColor];
    [self.easyButton setImage:[UIImage imageNamed:@"img_category_xiuxian"] forState:UIControlStateNormal];
    [self.easyButton addTarget:self action:@selector(easyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.easyButton];
    
    //food
    self.foodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.foodButton.frame = CGRectMake(0, SCROLLHEIGHT / 6, SCROLLWIDTH / 2-1, SCROLLHEIGHT / 6);
    self.foodButton.backgroundColor = [UIColor whiteColor];
    [self.foodButton setImage:[UIImage imageNamed:@"img_category_food"] forState:UIControlStateNormal];
    [self.foodButton addTarget:self action:@selector(foodButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.foodButton];
    
    //all
    self.allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.allButton.frame = CGRectMake(SCROLLWIDTH / 2, SCROLLHEIGHT / 6, SCROLLWIDTH / 2, SCROLLHEIGHT / 6);
    self.allButton.backgroundColor = [UIColor whiteColor];
    self.allButton.imageView.frame = CGRectMake(self.allButton.imageView.frame.origin.x, self.allButton.imageView.frame.origin.y, self.allButton.imageView.frame.size.width, self.allButton.imageView.frame.size.height);
    [self.allButton setImage:[UIImage imageNamed:@"img_category_other"] forState:UIControlStateNormal];
    [self.allButton addTarget:self action:@selector(allButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.allButton];
    
#pragma mark -- sceneLabel
    UILabel *sceneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCROLLHEIGHT / 3 + 10, SCROLLWIDTH, 39)];
    sceneLabel.backgroundColor = [UIColor whiteColor];
    sceneLabel.text = @"    按场景查找";
    [sceneLabel setFont:[UIFont fontWithName:@"Baskerville" size:20]];
    [scrollView addSubview:sceneLabel];
    
#pragma mark -- sceneCollectionView
    UICollectionViewFlowLayout *sceneFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    sceneFlowLayout.itemSize = CGSizeMake(SCROLLWIDTH / 4, SCROLLHEIGHT / 4);
    self.sceneCollectionView.scrollEnabled = NO;
    self.sceneCollectionView.showsHorizontalScrollIndicator = NO;
    self.sceneCollectionView.showsVerticalScrollIndicator = NO;
    self.sceneCollectionView.bounces = NO;
//    sceneFlowLayout.minimumInteritemSpacing = 0;
    sceneFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    sceneFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sceneCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCROLLHEIGHT / 3 + 50, SCROLLWIDTH, SCROLLHEIGHT / 4 - 50) collectionViewLayout:sceneFlowLayout];
    self.sceneCollectionView.backgroundColor = [UIColor whiteColor];
    self.sceneCollectionView.delegate = self;
    self.sceneCollectionView.dataSource = self;
    [self.sceneCollectionView registerNib:[UINib nibWithNibName:@"sceneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"scene"];
    [scrollView addSubview:self.sceneCollectionView];
    
#pragma mark -- businessLabel
    UILabel *businessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCROLLHEIGHT / 12)* 7 + 10, SCROLLWIDTH, 39)];
    businessLabel.text = @"    按商圈查找";
    [businessLabel setFont:[UIFont fontWithName:@"Baskerville" size:20]];
    businessLabel.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:businessLabel];
    
#pragma mark -- businessTableView
    self.businessTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ((SCROLLHEIGHT / 12) *7) + 50, SCROLLWIDTH, ((SCROLLHEIGHT / 12) * 17) - 50)  style:UITableViewStylePlain];
    self.businessTableView.delegate = self;
    self.businessTableView.dataSource = self;
    [self.businessTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"business"];
    [scrollView addSubview:self.businessTableView];
}


#pragma mark -- collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[SearchDataManager sharedDataManager] allSceneArray].count;
}

#pragma mark -- request scenelist data
- (void)requestSceneList
{
    [[SearchDataManager sharedDataManager] requsetDataWithSceneString:[NSString stringWithFormat:kSceneListUrl, [[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"]]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    sceneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sceneCellID forIndexPath:indexPath];
    scene *scene =  [SearchDataManager sharedDataManager]. allSceneArray[indexPath.row];
    cell.scene = scene;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCROLLWIDTH / 3, SCROLLHEIGHT / 6);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    SceneTableViewController *sceneTVC = [SceneTableViewController new];
    scene *scene = [[SearchDataManager sharedDataManager] allSceneArray][indexPath.row];
    sceneTVC.qStr = @"&";
    sceneTVC.scene = scene;
    [self.navigationController pushViewController:sceneTVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

#pragma mark -- request business data
- (void)requestBusiness
{
    [[SearchDataManager sharedDataManager] requestDataWithBusinessString:[NSString stringWithFormat:kBusinessUrl,[[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"]]];
}

#pragma mark -- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SearchDataManager sharedDataManager]allBusinessArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Business *business = [SearchDataManager sharedDataManager].allBusinessArray[indexPath.row];
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:businessCellID];
    cell.business = business;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (((SCROLLHEIGHT / 12) * 17) - 6)/ ([[SearchDataManager sharedDataManager]allBusinessArray].count);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    BusinessTableViewController *businessTVC = [BusinessTableViewController new];
    Business *business = [[SearchDataManager sharedDataManager] allBusinessArray][indexPath.row];
    businessTVC.idStr = [NSString stringWithFormat:@"%@&",business.idStr];
    businessTVC.channelid = @"&";
    businessTVC.categoryId = @"&";
    businessTVC.titleStr = @"商圈";
    [self.navigationController pushViewController:businessTVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark -- nearButtonAction
- (void)nearButtonAction:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    BusinessTableViewController *businessTVC = [BusinessTableViewController new];
    businessTVC.idStr = @"&";
    businessTVC.channelid = @"&";
    businessTVC.categoryId = @"&";
    businessTVC.titleStr = @"附近";
    [self.navigationController pushViewController:businessTVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}

#pragma mark -- easyButtonAction
- (void)easyButtonAction:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    BusinessTableViewController *businessTVC = [BusinessTableViewController new];
    businessTVC.idStr = @"&";
    businessTVC.channelid = @"tastebar&";
    businessTVC.categoryId = @"&";
    businessTVC.titleStr = @"休闲";
    [self.navigationController pushViewController:businessTVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}

#pragma mark -- foodButtonAction
- (void)foodButtonAction:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    BusinessTableViewController *businessTVC = [BusinessTableViewController new];
    businessTVC.idStr = @"&";
    businessTVC.channelid = @"tongue&";
    businessTVC.categoryId = @"&";
    businessTVC.titleStr = @"美食";
    [self.navigationController pushViewController:businessTVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark -- allButtonAction
- (void)allButtonAction:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    GategoryViewController *allTypeCVC = [GategoryViewController new];
    [self.navigationController pushViewController:allTypeCVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark -- searchButton
- (void)button:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    SearchBarTableViewController *rootTVC = [SearchBarTableViewController new];
    [self.navigationController pushViewController:rootTVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
