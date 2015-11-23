
//
//  ActDetDisTableViewCell.m
//  Boom小组项目
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//

#import "ActDetDisTableViewCell.h"

@implementation ActDetDisTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    self.actDetDisLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5,[UIScreen mainScreen].bounds.size.width - 20, 80)];
    self.actDetDisLbl.numberOfLines = 0;
    [self addSubview:_actDetDisLbl];
}

- (void)setActivity:(Activity *)activity
{
    self.actDetDisLbl.text = activity.desc;
    
    CGRect frame = _actDetDisLbl.frame;
    frame.size.height = [self calcHightWithActivity:activity];
    self.actDetDisLbl.frame = frame;
}

- (CGFloat)calcHightWithActivity:(Activity *)activity
{
    CGSize maxSize = CGSizeMake(_actDetDisLbl.frame.size.width, 1000);
    CGRect frame = [activity.desc boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:_actDetDisLbl.font} context:nil];
    return frame.size.height;
}

+ (CGFloat)calcHeightForCellWithActivity:(Activity *)activity
{
    CGFloat labelHeight = [[[ActDetDisTableViewCell alloc] init] calcHightWithActivity:activity];
    return labelHeight;
}

@end
