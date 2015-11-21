//
//  ExpDetailsTableViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ExpDetailsTableViewController.h"

@interface ExpDetailsTableViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *allDataArray;

@property (nonatomic, strong) UITableView *ExpDetailsTableView;

@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation ExpDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentPage = 1;
    
    self.title = @"体验详情";
    
    self.ExpDetailsTableView.frame = self.view.frame;
    
    self.ExpDetailsTableView.delegate = self;
    self.ExpDetailsTableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpDetHeader_2TableViewCell" bundle:nil] forCellReuseIdentifier:@"ExpDetH_2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpDetHeader_3TableViewCell" bundle:nil] forCellReuseIdentifier:@"ExpDetH_3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpDet_1TableViewCell" bundle:nil] forCellReuseIdentifier:@"ExpDet_1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpDetDisTableViewCell" bundle:nil] forCellReuseIdentifier:@"EDDID"];
    
    NSString * url_string = [NSString stringWithFormat:@"http://www.molyo.com//mExperience/getInfo?id=%@&accessToken=1511161452277577954b2bec4045110d&device=m2&os=Android+5.1&osType=android&netWork=wifi",self.expID];
    
    [self requestDataWithListString:url_string];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 解析数据

- (void)requestDataWithListString:(NSString *)string
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       
        ExpDetails *model = [ExpDetails new];
        [model setValuesForKeysWithDictionary:dict[@"body"]];
        self.allDataArray = [NSMutableArray arrayWithCapacity:40];
        [self.allDataArray addObject:model];
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [task resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 2;
    } else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [UITableViewCell new];
    
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                
                ExpDetHeader_2TableViewCell *edh_2 = [tableView dequeueReusableCellWithIdentifier:@"ExpDetH_2" forIndexPath:indexPath];                cell = edh_2;
                
                Experience *e = self.allDataArray[indexPath.row];
                
                [edh_2.userImgView sd_setImageWithURL:[NSURL URLWithString:e.userImg]];
                edh_2.userNameLbl.text = e.userName;
                
                NSRange range = NSMakeRange(5, 11);
                NSString *cTime = [e.createTime substringWithRange:range];
                edh_2.creatTimeLbl.text = cTime;
                edh_2.shopNameLbl.text = e.shopName;
                
            } else {
                
                ExpDetHeader_3TableViewCell *edh_3 = [tableView dequeueReusableCellWithIdentifier:@"ExpDetH_3" forIndexPath:indexPath];
                cell = edh_3;
                
                Experience *e = self.allDataArray[indexPath.row];
                
                edh_3.desLbl.text = e.desc;
                
            }
            break;
        }
        case 1:{
            
            if (indexPath.row == 0) {
                
                ExpDet_1TableViewCell *expDet = [tableView dequeueReusableCellWithIdentifier:@"ExpDet_1" forIndexPath:indexPath];
                cell = expDet;
                
            } else {
                
                ExpDetDisTableViewCell *expDetDis = [tableView dequeueReusableCellWithIdentifier:@"EDDID" forIndexPath:indexPath];
                cell = expDetDis;
                
                Experience *e = self.allDataArray[indexPath.row];
                [expDetDis.userImgView sd_setImageWithURL:[NSURL URLWithString:e.userImg]];
                expDetDis.userNameLbl.text = e.userName;
                
                NSRange range = NSMakeRange(5, 11);
                NSString *cTime = [e.createTime substringWithRange:range];
                expDetDis.creatTimeLbl.text = cTime;
            }
            break;
        }
        default:
            break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [UITableViewHeaderFooterView new];
    
    switch (section) {
        case 0:{
            
            LunBoTuView *LBTVC = [LunBoTuView new];
            
            ExpDetails *e = self.allDataArray[section];
            
            [LBTVC setArray:e.imgs];
            
            [view addSubview:LBTVC];
            
            break;
        }
        case 1:{
            
        }
        default:
            break;
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                
                height = 50;
            } else {
                
                height = 100;
            }
            break;
        }
        case 1:{
            
            if (indexPath.row == 0) {
                
                height = 20;
            } else {
                
                height = 100;
            }
            break;
        }
        default:
            break;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0.0;
    
    switch (section) {
        case 0:{
            
            height = 100;
            break;
        }
        case 1:{
            
            height = 8;
            break;
        }
        default:
            break;
    }
    return height;
}




@end
