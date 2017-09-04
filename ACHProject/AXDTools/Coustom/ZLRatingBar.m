//
//  ZLRatingBar.m
//  EternalSpirit
//
//  Created by FangZhongli on 2016/12/26.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import "ZLRatingBar.h"

@interface ZLRatingBar ()
@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;
// 星星图片大小
@property (nonatomic, assign) float starWH;
@property (nonatomic, assign) float lastRating;// 上一次的值，用于取反
@property (nonatomic, assign) BOOL isTapGR;// 只支持点击取反
@end

@implementation ZLRatingBar

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUP];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
        
    }
    return self;
}

- (void)setCornerRadius:(float)speed {
    self.layer.cornerRadius = speed;
}

- (void)setUP{
    self.userInteractionEnabled = YES;
    self.clipsToBounds = YES;
    
    /**点击手势*/
    UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [self addGestureRecognizer:tapGR];
    
    /**滑动手势*/
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [self addGestureRecognizer:panGR];
    
    self.spacing = 1.0;
    
    self.starWH = self.frame.size.width/(5*_spacing);
}

/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param fullSelectedName 全选中图片名称
 */
- (id)initWithFrame:(CGRect)frame deselectedImage:(NSString *)deselectedName fullSelected:(NSString *)fullSelectedName andSpacing:(float)spacing
{
    
    self = [self initWithFrame:frame];
    if (self) {
        
        //计算 星星图片大小的高和宽
        self.spacing = spacing;
        
        self.deselectedName = deselectedName;
        self.fullSelectedName = fullSelectedName;
        
        self.rating = 0.0;
    }
    return self;
}

- (void)setDeselectedName:(NSString *)deselectedName{
    _deselectedName = deselectedName;
    [self updateViewConfig];
}

- (void)setFullSelectedName:(NSString *)fullSelectedName{
    _fullSelectedName = fullSelectedName;
    [self updateViewConfig];
}

- (void)setSpacing:(float)spacing{
    
    _spacing = spacing;
    self.starWH = self.frame.size.width/(5*_spacing);
    [self updateViewConfig];
}

- (void)setRating:(float)rating{
    _rating = rating;
    if (_lastRating==_rating && _isTapGR) {
        _rating = 0;
    }
    _lastRating = _rating;
    [self updateViewConfig];
}

- (void)updateViewConfig{
    [self.starBackgroundView removeFromSuperview];
    self.starBackgroundView = [self buidlStarViewWithImageName:_deselectedName];
    [self addSubview:self.starBackgroundView];
    [self.starForegroundView removeFromSuperview];
    self.starForegroundView = [self buidlStarViewWithImageName:_fullSelectedName];
    [self addSubview:self.starForegroundView];
    
    self.starForegroundView.frame = CGRectMake(0, 0, (_rating)*self.spacing*self.starWH , self.starWH );
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int j = 0; j < 5; j ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(self.spacing*j*self.starWH+((_spacing-1)/2*_starWH) , 0, self.starWH , self.starWH );
        [view addSubview:imageView];
    }
    return view;
}

-(void)tapGR:(UITapGestureRecognizer *)tapGR{
    
    if (_isIndicator) {
        return;
    }
    // 只支持点击手势取反
    if ([tapGR isKindOfClass:[UITapGestureRecognizer class]]) {
        _isTapGR = YES;
    }else{
        _isTapGR = NO;
    }
    
    CGPoint point =[tapGR locationInView:self];
    
    float X = (float) point.x/(self.spacing*self.starWH );
    
    if (point.x>((_spacing-1)/2*_starWH)) {
        X = [self halfValue:X];
    }
    if (X<0) {
        X=0;
    }
    if (X>5) {
        X=5;
    }
    self.rating = X;
    if (_delegate && [_delegate respondsToSelector:@selector(ratingChanged:)]) {
        [_delegate ratingChanged:_rating];
    }
    if (_ratingChangedBlock) {
        _ratingChangedBlock(_rating);
    }
//    DLog(@"----------%f--%d",_rating,(int)_rating);
}

- (float)halfValue:(float)value{
    
    return ceilf(value);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
    value = value + 0.5;
    
    float newValue = value;
    
    newValue =((int) (value / 0.5)) * 0.5;
    return newValue;
#pragma clang diagnostic pop
}

+ (instancetype)sharedRatingBar:(float)rating isIndicator:(BOOL)indicator superView:(UIView *)superView{
    return [self sharedRatingBar:rating isIndicator:indicator signleWidth:13 superView:superView];
}

+ (instancetype)sharedRatingBar:(float)rating isIndicator:(BOOL)indicator signleWidth:(float)width superView:(UIView *)superView{
    ZLRatingBar *ratingBar = [[ZLRatingBar alloc] initWithFrame:CGRectMake(0, 4, width*(5*1.2), width) deselectedImage:@"img_star1-" fullSelected:@"ICON_STAR" andSpacing:1.2];
    ratingBar.rating=rating;
    ratingBar.isIndicator = indicator;
    ratingBar.userInteractionEnabled = !indicator;
    [superView addSubview:ratingBar];
    return ratingBar;
}


@end
