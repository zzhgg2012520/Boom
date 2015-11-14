//
//  sceneCollectionViewCell.h
//  Boom
//
//  Created by superGuest on 15/11/9.
//  Copyright © 2015年 wgw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class scene;
@interface sceneCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) scene *scene;

- (void)setScene:(scene *)scene;

@end
