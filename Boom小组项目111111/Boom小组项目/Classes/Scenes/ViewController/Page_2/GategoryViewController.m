//
//  GategoryViewController.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/14.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "GategoryViewController.h"

@interface GategoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView * collectView;
}
@property (nonatomic,strong) NSArray *allCategoryArray;

@end

@implementation GategoryViewController

static NSString * const reuseIdentifier = @"gategory";
static NSString * const reuseHeaderIdentifier = @"headerView";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求数据
    [self requestData];
    
#pragma mark -- 布局layout
    [self addCollectionView];
    
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes and header collectView
    [collectView registerNib:[UINib nibWithNibName:@"GategoryCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [collectView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier];
    
    
    //为allCategoryArray添加两个数组
    self.allCategoryArray = [NSArray arrayWithObjects:[SearchDataManager sharedDataManager].allEasyArray,[SearchDataManager sharedDataManager].allFoodArray, nil];
    
    //刷新数据
    [SearchDataManager sharedDataManager].result = ^(){
        [collectView reloadData];
    };
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(50, 30, 50, 30);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    collectView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    collectView.backgroundColor = [UIColor whiteColor];
    collectView.delegate = self;
    collectView.dataSource = self;
    [self.view addSubview:collectView];
}

- (void)requestData
{
    if ([[SearchDataManager sharedDataManager] allFoodArray].count > 0||[[SearchDataManager sharedDataManager] allEasyArray].count > 0) {
        
        [[[SearchDataManager sharedDataManager] allEasyArray] removeAllObjects];
        [[[SearchDataManager sharedDataManager] allFoodArray] removeAllObjects];
    
    }

    NSString *strUrl = [NSString stringWithFormat:kGategoryUrl,[[NSUserDefaults standardUserDefaults] valueForKey:@"cityId"]];
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
    
    GategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    scene *e = [self.allCategoryArray[indexPath.section] objectAtIndex:indexPath.row];
    cell.scene = e;
    
    return cell;
}

//添加头视图
//重用视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
    header.backgroundColor = [UIColor redColor];
    return header;
}


@end
