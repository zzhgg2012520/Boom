//
//  ForgetViewController.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/20.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ForgetViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface ForgetViewController ()

@end

@implementation ForgetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)verify:(UIButton *)sender
{
    [AVUser requestPasswordResetForEmailInBackground:self.emailTextField.text block:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
        } else {
            
        }
    
    }];
}

- (IBAction)goBackAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
