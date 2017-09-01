//
//  HomeToolView.m
//  EternalSpirit
//
//  Created by FangZhongli on 2016/12/8.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import "HomeToolView.h"
//#import "ZLMainModel.h"

@implementation HomeToolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)sharedToolViewModels:(NSArray<ZLMainCategory_nav*>*)modes complection:(void(^)(NSInteger index))block{
    HomeToolView *tool = [[HomeToolView alloc] initWithFrame:CGRectMake(0, 0, kBaseWidth, 0)];
    tool.selectIndexBlock = block;
//    [tool setUPWithModels:modes];
    [tool setUP];
    return tool;
}

- (void)setUPWithModels:(NSArray*)models{
    self.backgroundColor = kColor_white;
    
    float itemWidth = 42;
    float spaceW = (self.axd_width-itemWidth*5)/5;
    
    NSInteger maxLength = models.count;//补一个 集中采购, 全部
    
//    for (int i = 0; i < maxLength + 2; i ++)
    for (int i = 0; i < maxLength + 1; i ++)
    {
        NSString *name = nil;
        id path = nil;
        if (i<maxLength) {
//            ZLMainCategory_nav *model = models[i];
//            name = model.name;
//            path = kWebImageURL(model.path);
        }else{
            
//            if (i==maxLength) {
//                name = @"集中采购";
//                path = [UIImage imageNamed:@"home_icon_shopping"];
//            }
//            if (i==maxLength+1) {
//                name = @"全部";
//                path = [UIImage imageNamed:@"home_icon_all"];
//            }
            
            if (i==maxLength) {
                name = @"全部";
                path = [UIImage imageNamed:@"home_icon_all"];
            }
        }
        
        UIImageView *picimageview = [UIImageView imageViewWithFrame:CGRectMake(spaceW/2+i%5*(itemWidth+spaceW), 20+i/5*(itemWidth+35), itemWidth, itemWidth) image:nil superView:self];
        if ([path isKindOfClass:[UIImage class]]) {
            picimageview.image = path;
        }else if ([path isKindOfClass:[NSString class]]){
            [picimageview sd_setImageWithURL:[NSURL URLWithString:path]];
        }
        
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(picimageview.frame.origin.x - 5, CGRectGetMaxY(picimageview.frame) + 5, picimageview.frame.size.width + 10, 15)];
        titlelab.textAlignment = NSTextAlignmentCenter;
        titlelab.font = kFontSize_content;
        titlelab.text = name;
        titlelab.textColor = kColor_title;
        [self addSubview:titlelab];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(picimageview.frame.origin.x, picimageview.frame.origin.y, picimageview.frame.size.width, picimageview.frame.size.height + titlelab.frame.size.height+5);
        button.backgroundColor = [UIColor clearColor];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(nextEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
//        if (i==maxLength+1) {
//            self.height = button.bottom+20;
//        }
        //如果加上集中采购 就换成上面注释的那个
        if (i == maxLength) {
            self.axd_height = button.bottom+20;
        }
    }
    
//    [self addLineWithBottom:YES top:NO];
}




//xiesi
+ (instancetype)sharedToolViewCompletion:(void(^)(NSInteger index))block{
    HomeToolView *tool = [[HomeToolView alloc] initWithFrame:CGRectMake(0, 0, kBaseWidth, 0)];
    tool.selectIndexBlock = block;
    [tool setUP];
    return tool;
}

- (void)setUP{
    
    self.backgroundColor = kColor_white;
    
    NSArray *pics = [NSArray arrayWithObjects:@"home_icon_food",@"home_icon_entertainment",@"home_icon_Salon",@"home_icon_KTV",@"home_icon_beauty",@"home_icon_merry",@"home_icon_hotel",@"home_icon_flower",@"home_icon_shopping",@"home_icon_all", nil];
    NSArray *titles = [NSArray arrayWithObjects:@"美食",@"休闲娱乐",@"美发",@"KTV",@"丽人",@"结婚",@"主题酒店",@"鲜花",@"集中采购",@"全部", nil];
    
    float itemWidth = 42;
    float spaceW = (self.axd_width-itemWidth*5)/5;
    for (int i = 0; i < titles.count; i ++)
    {
        UIImageView *picimageview = [UIImageView imageViewWithFrame:CGRectMake(spaceW/2+i%5*(itemWidth+spaceW), 20+i/5*(itemWidth+35), itemWidth, itemWidth) image:[UIImage imageNamed:pics[i]] superView:self];
        
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(picimageview.frame.origin.x - 5, CGRectGetMaxY(picimageview.frame) + 5, picimageview.frame.size.width + 10, 15)];
        titlelab.textAlignment = NSTextAlignmentCenter;
        titlelab.font = kFontSize_content;
        titlelab.text = titles[i];
        titlelab.textColor = kColor_title;
        [self addSubview:titlelab];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(picimageview.frame.origin.x, picimageview.frame.origin.y, picimageview.frame.size.width, picimageview.frame.size.height + titlelab.frame.size.height+5);
        button.backgroundColor = [UIColor clearColor];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(nextEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (i==titles.count-1) {
            self.axd_height = button.bottom+20;
        }
    }
    
//    [self addLineWithBottom:YES top:NO];
}

- (void)nextEvent:(UIButton *)btn{
    if (_selectIndexBlock) {
        _selectIndexBlock(btn.tag-100);
    }
}

@end
