//
//  MineTableViewController.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "MineTableViewController.h"


@interface MineTableViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UIImageView * userImg;
@property (nonatomic, strong) NSString * loginText;

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
    
    // 用户头像
    [self addUserImg];
    
    // 用户姓名
    [self addUserName];
    
    // 体验 关注 粉丝
    [self addViewsToImageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    // 判断是否已登录
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser == nil) {
        _label.text = @"未登录";
        _userImg.image = [UIImage imageNamed:@"yonghu"];
        _loginText = @"登录";
    }else{
        _label.text = currentUser.username;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"image"] == nil) {
            _userImg.image = [UIImage imageNamed:@"yonghu"];
        }else{
            _userImg.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"image"]];
        }
        _loginText = @"退出当前账号";
    }
    [self.tableView reloadData];
}

// 背景图片
- (void)addBackground{
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -220, [UIScreen mainScreen].bounds.size.width, 220)];
    self.imgView.image = [UIImage imageNamed:@"我的界面背景"];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:self.imgView];
    self.tableView.contentInset = UIEdgeInsetsMake(220, 0, 0, 0);
    
}

// 用户头像
- (void)addUserImg{
    
    self.userImg = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50, self.imgView.frame.origin.y + 25, 100, 100)];
    self.userImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.tableView addSubview:self.userImg];
    // 切圆角
    self.userImg.layer.cornerRadius = self.userImg.frame.size.width / 2;
    self.userImg.clipsToBounds = YES;
    // 边框
    [self.userImg.layer setBorderWidth:4];
    [self.userImg.layer setBorderColor:[[UIColor blackColor] CGColor]];
    
    // 点击更换头像
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.userImg.userInteractionEnabled = YES;
    [self.userImg addGestureRecognizer:tap];
    
}

// 点击更换头像
- (void)tapAction{

    // 判断是否已登录
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser == nil) {
        
        LoginViewController * loginVC = [LoginViewController new];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }else{
        
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [self presentViewController:alter animated:YES completion:nil];
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alter addAction:cancelAction];
        
        UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // 拍照
            [self readImageFromCamera];
            
        }];
        [alter addAction:cameraAction];
        
        UIAlertAction * albumAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // 从相册选取
            [self readImageFromAlbum];
            
        }];
        [alter addAction:albumAction];
        
    }
    
}

// 拍照
- (void)readImageFromCamera{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * imagePicker = [UIImagePickerController new];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        
    }
}

// 从相册选取
- (void)readImageFromAlbum{
    
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

// 图像处理后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"image"];
    [[NSUserDefaults standardUserDefaults] setValue:UIImagePNGRepresentation(image) forKey:@"image"];
    self.userImg.image = image;
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
 
}

// 用户姓名
- (void)addUserName{
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.userImg.frame.origin.y + self.userImg.frame.size.height, [UIScreen mainScreen].bounds.size.width, 40)];
    // 判断是否已登录
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser == nil) {
        _label.text = @"未登录";
    }else{
        _label.text = currentUser.username;
    }
    _label.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:_label];
    
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
    expNumLabel.text = @"0";
    expNumLabel.textColor = [UIColor whiteColor];
    expNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:expNumLabel];
    
    UILabel * attLabel = [[UILabel alloc] initWithFrame:CGRectMake(expLabel.frame.size.width, expLabel.frame.origin.y, expLabel.frame.size.width, expLabel.frame.size.height)];
    attLabel.text = @"关注";
    attLabel.textColor = [UIColor whiteColor];
    attLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:attLabel];
    
    UILabel * attNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(expNumLabel.frame.size.width, expNumLabel.frame.origin.y, expNumLabel.frame.size.width, expNumLabel.frame.size.height)];
    attNumLabel.text = @"0";
    attNumLabel.textColor = [UIColor whiteColor];
    attNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:attNumLabel];
    
    UILabel * fansLabel = [[UILabel alloc] initWithFrame:CGRectMake(expLabel.frame.size.width * 2, expLabel.frame.origin.y, expLabel.frame.size.width, expLabel.frame.size.height)];
    fansLabel.text = @"粉丝";
    fansLabel.textColor = [UIColor whiteColor];
    fansLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:fansLabel];
    
    UILabel * fansNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(expNumLabel.frame.size.width * 2, expNumLabel.frame.origin.y, expNumLabel.frame.size.width, expNumLabel.frame.size.height)];
    fansNumLabel.text = @"0";
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
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                
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
            
            if (indexPath.row == 1) {
                
                static NSString * cellID = @"我的活动";
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                }
                
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
                label.text = @"我的活动";
                [cell addSubview:label];
                
                return cell;
            }
        }
            break;
            
        case 1:
        {
            static NSString * cellID = @"登录退出";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
            cell.textLabel.text = _loginText;
            return cell;
        }
            break;
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
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                
                AVUser *currentUser = [AVUser currentUser];
                if (currentUser == nil) {
                    
                    LoginViewController * loginVC = [LoginViewController new];
                    [self presentViewController:loginVC animated:YES completion:nil];
                    
                }else{
                    
                    self.hidesBottomBarWhenPushed = YES;
                    CollectViewController * collectVC = [CollectViewController new];
                    [self.navigationController pushViewController:collectVC animated:YES];
                    self.hidesBottomBarWhenPushed = NO;

                }
            }
            if (indexPath.row == 1) {
                
                AVUser *currentUser = [AVUser currentUser];
                if (currentUser == nil) {
                    
                    LoginViewController * loginVC = [LoginViewController new];
                    [self presentViewController:loginVC animated:YES completion:nil];
                    
                }else{
                    
                    self.hidesBottomBarWhenPushed = YES;
                    MyActivityViewController * myAcyivityVC = [MyActivityViewController new];
                    [self.navigationController pushViewController:myAcyivityVC animated:YES];
                    self.hidesBottomBarWhenPushed = NO;
                    
                }
            }
            break;
        }

        case 1:
        {

            AVUser *user = [AVUser currentUser];
            
            if (user != nil){
                
                //如果有用户存在，则注销，否则不做操作
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否注销？" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    //[self log:@"注销用户 %@",user.username];
                    [AVUser logOut];
                    //清空currentUser，且刷新数据
                    AVUser *currentUser = [AVUser currentUser]; // 现在的currentUser是nil了
                    
                    _label.text = @"未登录";
                    _userImg.image = [UIImage imageNamed:@"yonghu"];
                    _loginText = @"登录";
                    [self.tableView reloadData];
                }];
                
                [alertController addAction:cancelAction];
                [alertController addAction:doneAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }else{
                
                LoginViewController * loginVC = [LoginViewController new];
                [self presentViewController:loginVC animated:YES completion:nil];
                
            }
        }
        
        default:
            break;
    }
}
                                
@end
