//
//  ForgetViewController.h
//  Boom小组项目
//
//  Created by superGuest on 15/11/20.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)verify:(UIButton *)sender;
- (IBAction)goBackAction:(UIButton *)sender;

@end
