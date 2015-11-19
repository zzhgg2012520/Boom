//
//  WebViewController.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/19.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    UIWebView *_webView;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
