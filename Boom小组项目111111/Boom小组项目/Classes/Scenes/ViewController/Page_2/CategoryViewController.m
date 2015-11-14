//
//  CategoryViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSArray *allCategoryArray;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation CategoryViewController

static NSString * const reuseIdentifier = @"scene";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求数据
    [self requestData];
    
#pragma mark -- 布局layout
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    
    flowLayout.itemSize = CGSizeMake(40, 40);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    self.collectionView.backgroundColor  = [UIColor redColor]; 
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"sceneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //为allCategoryArray添加两个数组
    self.allCategoryArray = [NSArray arrayWithObjects:[SearchDataManager sharedDataManager].allEasyArray,[SearchDataManager sharedDataManager].allFoodArray, nil];
}

- (void)requestData
{
    NSString *strUrl = @"http://www.molyo.com//mShop/category/getAllChannelCategoryV1_7?cityId=hangzhou";
    [[SearchDataManager sharedDataManager]requestDataWithAllFoodString:strUrl];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [[self.allCategoryArray objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    sceneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

//    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.allCategoryArray[indexPath.section][indexPath.row]]];
    
//    cell.nameLabel.text = [self.allCategoryArray[indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(40, 40);
}

@end
