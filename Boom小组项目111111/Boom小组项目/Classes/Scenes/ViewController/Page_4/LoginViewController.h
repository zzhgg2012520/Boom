//
//  LoginViewController.h
//  Boom小组项目
//
//  Created by superGuest on 15/11/19.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameTextFiedl;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)RegisterAction:(UIButton *)sender;
- (IBAction)forgetAction:(UIButton *)sender;
- (IBAction)gobackAction:(UIButton *)sender;

@end
