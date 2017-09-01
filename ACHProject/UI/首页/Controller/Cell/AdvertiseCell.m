//
//  AdvertiseCell.m
//  ACHProject
//
//  Created by chenxiaohong on 2017/9/1.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "AdvertiseCell.h"

@implementation AdvertiseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

    NSArray *topTitleArr = @[@"聚惠女王节，香米更低价满150减10", @"HTC新品首发，预约送大礼包", @"“挑食”进口生鲜，满199减20"];
    NSArray *signImageArr = @[@"头条", @"", @"activity"];
    NSArray *bottomTitleArr = @[@"满150减10+满79减5", @"12期免息＋免费试用", @"领券满199减20+进口直达"];
    
   
    self.advertiseView.advertScrollViewStyle = SGAdvertScrollViewStyleNormal;
    self.advertiseView.topTitles = topTitleArr;
    self.advertiseView.bottomSignImages = signImageArr;
    self.advertiseView.bottomTitles = bottomTitleArr;
    self.advertiseView.bottomTitleColor = [UIColor redColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
