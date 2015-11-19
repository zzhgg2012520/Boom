//
//  Two_dimensional_codeViewController.m
//  Boom小组项目
//
//  Created by superGuest on 15/11/19.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "Two_dimensional_codeViewController.h"

@interface Two_dimensional_codeViewController ()

@end

@implementation Two_dimensional_codeViewController
@synthesize text;
@synthesize image_view;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    
    [self init_camera];
}

- (void)viewDidUnload
{
    [self setText:nil];
    [self setImage_view:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_overLayView stopAnimation];
}

- (void) readerView:(ZBarReaderView *)readerView didReadSymbols: (ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol * s = nil;
    for (s in symbols)
    {
        text.text = s.data;
        NSLog(@"<><><><><><M><><>%@",text.text);
        break;
    }
    
    [text addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([object isKindOfClass:[text class]] && [keyPath isEqualToString:@"text"]) {
        if(!change[@"new"]){
            [self.navigationController pushViewController:[WebViewController new] animated:YES];
        }
    }
    [text removeObserver:self forKeyPath:@"text"]; 
}

- (void) init_camera
{
    self.mainView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.mainView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.mainView];
    
    ZBarReaderView * reader = [ZBarReaderView new];
    ZBarImageScanner * scanner = [ZBarImageScanner new];
    [scanner setSymbology:ZBAR_PARTIAL config:0 to:0];

#warning 这里有一个警告！
    //[reader initWithImageScanner:scanner];
    reader.readerDelegate = self;
    
    const float h = self.mainView.bounds.size.height;
    const float w = self.mainView.bounds.size.width;
    const float h_padding = w / 10.0;
    const float v_padding = h / 10.0;
//    CGRect reader_rect = CGRectMake(0, 0, w, h);
       CGRect reader_rect = CGRectMake(h_padding, v_padding,
                                        w * 0.8, h * 0.5);//视图中的一小块,实际使用中最好传居中的区域
    CGRect reader_rect1 = CGRectMake(0, 0, w, h);//全屏模式
    reader.frame = reader_rect1;
    self.mainView.center = reader.center;
    reader.backgroundColor = [UIColor whiteColor];
    [reader start];
    
    [self.mainView addSubview: reader];
    
    _overLayView = [[ZbarOverlayView alloc]initWithFrame:reader.frame];//添加覆盖视图
    //    [_overLayView startAnimation];
    _overLayView.transparentArea = reader_rect;//设置中间可选框大小
    [reader addSubview:_overLayView];
    reader.scanCrop = [self getScanCrop:reader_rect readerViewBounds:reader_rect1];;// CGRectMake(100 / h,0.5, 1/3.0,0.4);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat fullWidth = readerViewBounds.size.width;
    CGFloat fullHeight = readerViewBounds.size.height;
    CGFloat x,y,width,height;
    x = rect.origin.x;
    y = rect.origin.y;
    width = rect.size.width;
    height = rect.size.height;
    if (x + width > fullWidth) {
        if (width > fullWidth) {
            width = fullWidth;
        }else{
            x = 0;
        }
    }
    if (y + height > fullHeight) {
        if (height > fullHeight) {
            height = fullHeight;
        }else{
            y = 0;
        }
    }
    CGFloat x1,y1,width1,height1;
    x1 = (fullWidth - width - x) / fullWidth;
    y1 = y / fullHeight;
    width1 = width / fullWidth;
    height1 = rect.size.height / readerViewBounds.size.height;
    return CGRectMake(y1, x1,height1, width1);
}

@end
