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
@property (nonatomic,strong) NSArray * allCategoryArray;
@property (nonatomic,strong) NSMutableArray * typeArray;

@end

@implementation GategoryViewController

static NSString * const reuseIdentifier = @"gategory";
static NSString * const reuseHeaderIdentifier = @"header";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"全部类别";
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"NET"] isEqualToString:@"1"]) {
        //请求数据
        [self requestData];
    }else{
        self.view.userInteractionEnabled = NO;
    }
 
#pragma mark -- 布局layout
    [self addCollectionView];
    
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [collectView registerNib:[UINib nibWithNibName:@"GategoryCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //header collectView
    [collectView registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier];
  
    //不显示竖向条
    collectView.showsVerticalScrollIndicator = NO;
    
    //为allCategoryArray添加两个数组
    self.allCategoryArray = [NSArray arrayWithObjects:[SearchDataManager sharedDataManager].allEasyArray,[SearchDataManager sharedDataManager].allFoodArray, nil];
    
    //typeArray;
    self.typeArray = [NSMutableArray arrayWithObjects:@"休闲",@"美食", nil];
    
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
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 30, 80, 30);
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
    
    return [(NSMutableArray *)[self.allCategoryArray objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    scene *e = [self.allCategoryArray[indexPath.section] objectAtIndex:indexPath.row];
    cell.scene = e;
    
    return cell;
}

//添加头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderCollectionReusableView  * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
    header.nameLabel.text = self.typeArray[indexPath.section];
    return header;
}

//height of header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessTableViewController *businessTVC = [BusinessTableViewController new];
    
    if (indexPath.section == 2) {
        businessTVC.channelid = @"tongue&";
        businessTVC.categoryId = [NSString stringWithFormat:@"%@%@",[[self.allCategoryArray[indexPath.section] objectAtIndex:indexPath.row] idStr],@"&" ];
        businessTVC.idStr = @"&";
    }else{
        businessTVC.channelid = @"tastebar&";
        businessTVC.categoryId = [NSString stringWithFormat:@"%@%@",[[self.allCategoryArray[indexPath.section] objectAtIndex:indexPath.row] idStr],@"&" ];
        businessTVC.idStr = @"&";
    }
    
    [self.navigationController pushViewController:businessTVC animated:YES];
}

@end
