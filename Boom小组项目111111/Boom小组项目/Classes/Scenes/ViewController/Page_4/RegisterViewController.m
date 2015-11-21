//
//  RegisterViewController.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/19.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "RegisterViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface RegisterViewController ()
{
    NSTimer *timer;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)RegsiterAction:(UIButton *)sender
{
    AVUser *user = [AVUser user];
    user.username = self.usernameTextField.text;
    user.password =  self.passwordTextField.text;
    user.email = self.emailTextField.text;
#pragma mark -- 是否需要手机验证；
    //[user setObject:@"186-1234-0000" forKey:@"phone"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            //注册成功，回到登陆界面
            NSLog(@"注册成功");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册成功" message:@"验证邮件将要发送至你的邮箱。" preferredStyle:UIAlertControllerStyleAlert];
            [self  presentViewController:alertController animated:YES completion:nil];

//            [self dismissViewControllerAnimated:YES completion:^{
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }];
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismissViewAction:) userInfo:nil repeats:NO];
            
        } else {
            
            //失败
            NSLog(@"注册失败");
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"用户名和邮箱可能已经被注册。" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
            self.usernameTextField.text = @"";
            self.emailTextField.text = @"";
            self.passwordTextField.text = @"";
        }
    }];
}

- (void)dismissViewAction:(NSTimer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    [timer invalidate];
}

- (IBAction)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
