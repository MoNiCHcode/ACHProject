//
//  CommentListCell.m
//  ACHProject
//
//  Created by chenxiaohong on 2017/9/4.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "CommentListCell.h"

@implementation CommentListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
