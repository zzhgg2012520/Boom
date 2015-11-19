//
//  Two_dimensional_codeViewController.h
//  Boom小组项目
//
//  Created by superGuest on 15/11/19.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "ZbarOverlayView.h"
@interface Two_dimensional_codeViewController : UIViewController<ZBarReaderViewDelegate>
{
    ZBarReaderView *_read;
    ZbarOverlayView *_overLayView;
}
@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UILabel *text;
@property (strong, nonatomic) UIImageView *image_view;

@end
