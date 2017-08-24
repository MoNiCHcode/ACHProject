//
//  CFNavigationBar.m
//  CFArchitecture
//
//  Created by Mr.Guo on 2017/5/8.
//  Copyright © 2017年 Mr.Guo. All rights reserved.
//

#import "CFNavigationBar.h"

@implementation CFNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AXDRandomColor;
        [self addSubview:self.titleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.equalTo(self.mas_right).offset(-60);
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font=[UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

@end
