//
//  ActDetTableViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ActDetTableViewController.h"

@interface ActDetTableViewController ()

@property (nonatomic, strong) NSMutableArray *allDataArray;

@property (nonatomic, strong) UITableView *ActDetTableView;

@property (nonatomic, assign) CGFloat lblHeight;

@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *sponsorName;
@property (nonatomic, strong) NSString *address;

@end

@implementation ActDetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ActDetTableView.frame = self.view.frame;
    
    self.ActDetTableView.delegate = self;
    self.ActDetTableView.dataSource = self;
    
    self.title = @"活动详情";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ActDetTableViewCell" bundle:nil] forCellReuseIdentifier:@"ADTID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActDetDisTableViewCell" bundle:nil] forCellReuseIdentifier:@"ADDID"];
    
    NSString * url_string = [NSString stringWithFormat:@"http://www.molyo.com//mActive/getInfo?id=%@&accessToken=1511161452277577954b2bec4045110d",self.actID];
    [self requestDataWithListString:url_string];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 解析数据

- (void)requestDataWithListString:(NSString *)string
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        Activity *model = [Activity new];
        [model setValuesForKeysWithDictionary:dict[@"body"]];
        self.allDataArray = [NSMutableArray new];
        [self.allDataArray addObject:model];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [task resume];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [UITableViewCell new];
    
    switch (indexPath.row) {
        case 0:{
            
            ActDetTableViewCell *ADTCell = [tableView dequeueReusableCellWithIdentifier:@"ADTID" forIndexPath:indexPath];
            cell = ADTCell;
            
            ADTCell.selectionStyle = UITableViewCellSelectionStyleNone;
            Activity *a = self.allDataArray[indexPath.row];
            
            ADTCell.actDetTitleLbl.text = a.title;
            [ADTCell.actDetImgView sd_setImageWithURL:[NSURL URLWithString:a.img]];
            ADTCell.actDetTimeLbl.text = a.dateTimeParse;
            ADTCell.actDetAddress.text = a.address;
            ADTCell.actDetCostLbl.text = a.cost;
            ADTCell.actDetTypeLbl.text = a.type;
            ADTCell.actDetSponsorLbl.text = a.sponsorName;
            
            self.latitude = a.latitude;
            self.longitude = a.longitude;
            self.sponsorName = a.sponsorName;
            self.address = a.address;
            
            [ADTCell.shopAddressBtn addTarget:self action:@selector(shopAddressBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
        case 1:{
            
            ActDetDisTableViewCell *ADDCell = [tableView dequeueReusableCellWithIdentifier:@"ADDID" forIndexPath:indexPath];
            cell = ADDCell;
            
            ADDCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            Activity *a = self.allDataArray[0];
            
            ADDCell.actDetDisLbl.text = a.desc;
            
            break;
        }
        default:
            break;
    }
    return cell;
}

- (void)shopAddressBtnAction:(UIButton *)sender
{
    
    ShopMapViewController *SMVC = [ShopMapViewController new];
    
    SMVC.latitude = self.latitude;
    SMVC.longitude = self.longitude;
    SMVC.name = self.sponsorName;
    SMVC.address = self.address;
    
    [self.navigationController pushViewController:SMVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height = 0.0;
    switch (indexPath.row) {
        case 0:{
            
            height = 320;
            break;
        }
        case 1:{
            
            height = 2000;

            break;
        }
    }
    return height;
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
