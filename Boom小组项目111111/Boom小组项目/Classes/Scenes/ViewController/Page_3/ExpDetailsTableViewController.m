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
@property (nonatomic, strong) NSMutableArray *allDataArray_1;

@property (nonatomic, strong) UITableView *ExpDetailsTableView;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSString *shopID;

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
    [self.tableView registerClass:[LunBoTu class] forHeaderFooterViewReuseIdentifier:@"LBT"];
    
    NSString * url_string = [NSString stringWithFormat:@"http://www.molyo.com//mExperience/getInfo?id=%@&accessToken=1511161452277577954b2bec4045110d&device=m2&os=Android+5.1&osType=android&netWork=wifi",self.expID];
    
    [self requestDataWithListString:url_string];
    
    NSString *url_string_1 = [NSString stringWithFormat:@"http://www.molyo.com//mExperience/response/getList?businessId=1511091034030384b762df65e6afc21c&pageSize=8&currentPage=1&accessToken=1511191544322133a1c0da24dee728fa"];
    
    [self requestDataWithListString_1:url_string_1];
    
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
        [self.allDataArray addObject:model];
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [task resume];
}

- (void)requestDataWithListString_1:(NSString *)string
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        Discuss *model = [Discuss new];
        for (NSDictionary *dic in dict[@"body"][@"list"]) {
            [model setValuesForKeysWithDictionary:dic];
            [self.allDataArray_1 addObject:model];
        }
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
        return self.allDataArray_1.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [UITableViewCell new];
    
    switch (indexPath.section) {
        case 0:{
            
            if (indexPath.row == 0) {
                
                ExpDetHeader_2TableViewCell *edh_2 = [tableView dequeueReusableCellWithIdentifier:@"ExpDetH_2" forIndexPath:indexPath];
                
                cell = edh_2;
                
                ExpDetails *e = [ExpDetails new];
                if (self.allDataArray.count > 0) {
                    e = [self.allDataArray objectAtIndex:indexPath.row];
                }
                
                [edh_2.userImgView sd_setImageWithURL:[NSURL URLWithString:e.userImg]];
                edh_2.userNameLbl.text = e.userName;
                
                NSRange range = NSMakeRange(5, 11);
                NSString *cTime = [e.createTime substringWithRange:range];
                edh_2.creatTimeLbl.text = cTime;
                [edh_2.shopNameBtn setTitle:e.shopName forState:UIControlStateNormal];
                [edh_2.shopNameBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                
                self.shopID = e.shopId;
                
                [edh_2.shopNameBtn addTarget:self action:@selector(shopNameBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                
                break;
            } else {
                
                ExpDetHeader_3TableViewCell *edh_3 = [tableView dequeueReusableCellWithIdentifier:@"ExpDetH_3" forIndexPath:indexPath];
                cell = edh_3;
                
                ExpDetails *e = [ExpDetails new];

                if (self.allDataArray.count > 0) {
                    e = self.allDataArray[0];
                }
                
                edh_3.desLbl.text = e.desc;
                
                break;
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
                
                Discuss *d = [Discuss new];
                if (self.allDataArray_1.count > 0) {
                    d = self.allDataArray_1[0];
                }
                [expDetDis.userImgView sd_setImageWithURL:[NSURL URLWithString:d.userImg]];
                expDetDis.userNameLbl.text = d.userName;
                
                NSRange range = NSMakeRange(5, 11);
                NSString *cTime = [d.createTime substringWithRange:range];
                expDetDis.creatTimeLbl.text = cTime;
                expDetDis.disLbl.text = d.desc;
            }
            break;
        }
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)shopNameBtnAction:(UIButton *)sender
{
    ListInfoTableViewController *LITVC = [ListInfoTableViewController new];
    
    LITVC.shopId = self.shopID;
    
    [self.navigationController pushViewController:LITVC animated:YES];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [UITableViewHeaderFooterView new];
    
    switch (section) {
        case 0:{
            
            LunBoTu *LBTV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LBT"];
            
            ExpDetails *e = [ExpDetails new];
            if (self.allDataArray.count > 0) {
                e = [self.allDataArray objectAtIndex:section];
            }
            
            [LBTV setArray:e.imgs];
            
            view = LBTV;
            
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

- (NSMutableArray *)allDataArray
{
    if (_allDataArray == nil) {
        self.allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (NSMutableArray *)allDataArray_1{
    
    if (_allDataArray_1 == nil) {
        self.allDataArray_1 = [NSMutableArray array];
    }
    return _allDataArray_1;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
