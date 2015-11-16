//
//  GategoryCell.h
//  Boom小组项目
//
//  Created by superGuest on 15/11/15.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class scene;

@interface GategoryCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) scene *scene;

- (void)setScene:(scene *)scene;

@end
