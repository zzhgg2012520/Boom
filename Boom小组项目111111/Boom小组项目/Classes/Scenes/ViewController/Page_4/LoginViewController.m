//
//  LoginViewController.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/19.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "LoginViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface LoginViewController ()
{
    NSTimer * timer;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

//登陆
- (IBAction)loginAction:(UIButton *)sender
{
    [AVUser logInWithUsernameInBackground:self.userNameTextFiedl.text password:self.passwordTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSLog(@"登陆成功");

            AVUser *currentUser = [AVUser currentUser];
            if (currentUser != nil) {
                // 允许用户使用应用
            } else {
                //缓存用户对象为空时，可打开用户注册界面…
            }
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登陆成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertController animated:YES completion:nil];
            
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismissViewController:) userInfo:nil repeats:NO];
            
        } else {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"请核实用户名或密码是否正确。" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"重新登陆" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
            self.userNameTextFiedl.text = nil;
            self.passwordTextField.text = @"";
         
        }
    }];
}

//延时器方法
- (void)dismissViewController:(NSTimer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    [timer invalidate];
}

- (IBAction)RegisterAction:(UIButton *)sender
{
    [self presentViewController:[RegisterViewController new] animated:YES completion:nil];
}

- (IBAction)forgetAction:(UIButton *)sender
{
    [self showDetailViewController:[ForgetViewController new] sender:nil];
}

- (IBAction)gobackAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
