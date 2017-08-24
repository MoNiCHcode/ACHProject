//
//  AXDNavigationBarView.m
//  ACHProject
//
//  Created by chenxiaohong on 2017/8/24.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "AXDNavigationBarView.h"

#define centerPonit CGPointMake(_screenWidth/2, (64-20)/2+20)
#define getCenterY(height) (64-20-height)/2+20

#define centerImageWidth 100
#define centerImageHight 20

#define leftImageHight 25
#define leftImageWidth 25

#define leftFontValve 14

@implementation AXDNavigationBarView


-(id)init
{
    self=[super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    if (self) {
        _subViewsDic=[[NSMutableDictionary alloc]init];
        _screenWidth=[UIScreen mainScreen].bounds.size.width;
        _screenHight=[UIScreen mainScreen].bounds.size.height;
        _titleFontValue=16;
        
        _insertLeftX=10;
        _insertRightX=10;
        
        _itemLeftSpace=10;
        _itemRigtSpace=10;
        
        _centerOffset=0;
        
        _textColor=[UIColor blackColor];
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectItem:)];
        [self addGestureRecognizer:tap];
        
        self.isHidenLine=NO;
        self.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.8];
    }
    return self;
}

+(id)navigationBar
{
    return [[[self class]alloc ]init];
}


-(void)setIsHidenLine:(BOOL)isHidenLine
{
    _isHidenLine=isHidenLine;
    if (!_isHidenLine) {
        UILabel* lineLab=[[UILabel alloc]initWithFrame:CGRectMake(0,64-0.2, _screenWidth, 0.2)];
        lineLab.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:lineLab];
        [_subViewsDic setObject:lineLab forKey:@"isHidenLine"];
    }else{
        UILabel* lab=_subViewsDic[@"isHidenLine"];
        [lab removeFromSuperview];
    }
}

-(void)setTitle:(NSString *)title
{
    _title=title;
    UILabel* lab=_subViewsDic[@"title"];
    UIImageView* imageView=_subViewsDic[@"centerImage"];
    if (imageView) {
        [imageView removeFromSuperview];
    }
    CGSize size=[self getStringSize:_titleFontValue withString:title andWidth:_screenWidth];
    if (!lab) {
        UILabel* lab=[[UILabel alloc]init];
        lab.center=CGPointMake(_screenWidth/2+_centerOffset, (64-20)/2+20);
        lab.bounds=CGRectMake(0, 0, size.width, size.height);
        lab.font=FontSize(_titleFontValue);
        lab.text=title;
        lab.textColor=_textColor;
        [self addSubview:lab];
        [_subViewsDic setObject:lab forKey:@"title"];
    }else{
        lab.text=title;
        lab.textColor=_textColor;
        lab.bounds=CGRectMake(0, 0, size.width, size.height);
    }
}

-(void)setCenterImage:(UIImage *)centerImage
{
    _centerImage=centerImage;
    UILabel* lab=_subViewsDic[@"title"];
    if (lab) {
        [lab removeFromSuperview];
    }
    UIImageView* imageView=_subViewsDic[@"centerImage"];
    if (!imageView) {
        imageView=[[UIImageView alloc]init];
        imageView.center=centerPonit;
        imageView.bounds=CGRectMake(0, 0, centerImageWidth, centerImageHight);
        imageView.image=centerImage;
        [self addSubview:imageView];
        [_subViewsDic setObject:imageView forKey:@"centerImage"];
    }else{
        imageView.image=centerImage;
    }
}

-(void)setLeftTitle:(NSString *)leftTitle
{
    _leftTitle=leftTitle;
    UIImageView* imageView=_subViewsDic[@"leftImage"];
    if (imageView) {
        [imageView removeFromSuperview];
    }
    CGSize size=[self getStringSize:leftFontValve withString:leftTitle andWidth:_screenWidth];
    [self layoutLableWithFrame:CGRectMake(_insertLeftX, getCenterY(size.height), size.width, size.height) key:@"leftTitle" labText:leftTitle];
}

-(void)setLeftImage:(UIImage *)leftImage
{
    _leftImage=leftImage;
    
    UILabel* lab=_subViewsDic[@"leftTitle"];
    if (lab) {
        [lab removeFromSuperview];
    }
    
    [self layoutImageViewWithFrame:CGRectMake(_insertLeftX, getCenterY(leftImageHight), leftImageWidth, leftImageHight) key:@"leftImage" image:leftImage];
}

-(void)setRightTitle:(NSString *)rightTitle
{
    _rightTitle=rightTitle;
    UIImageView* imageView=_subViewsDic[@"rightImage"];
    if (imageView) {
        [imageView removeFromSuperview];
    }
    CGSize size=[self getStringSize:leftFontValve withString:rightTitle andWidth:_screenWidth];
    [self layoutLableWithFrame:CGRectMake(_screenWidth-_insertRightX-size.width, getCenterY(size.height), size.width, size.height) key:@"rightTitle" labText:rightTitle];
}

-(void)setRightImage:(UIImage *)rightImage
{
    _rightImage=rightImage;
    UILabel* lab=_subViewsDic[@"rightTitle"];
    if (lab) {
        [lab removeFromSuperview];
    }
    [self layoutImageViewWithFrame:CGRectMake(_screenWidth-_insertRightX-leftImageWidth, getCenterY(leftImageHight), leftImageWidth, leftImageHight) key:@"rightImage" image:rightImage];
}


-(void)setLeftItemsArray:(NSArray *)leftItemsArray
{
    _leftItemsArray=leftItemsArray;
    UIImageView* imageView=_subViewsDic[@"leftImage"];
    UILabel* label=_subViewsDic[@"leftTitle"];
    [imageView removeFromSuperview];
    [label removeFromSuperview];
    
    if (leftItemsArray.count>0) {
        
        for (NSInteger i=0; i<leftItemsArray.count; i++) {
            if (i==2) {
                return;
            }
            id value=leftItemsArray[i];
            CGSize size=CGSizeZero;
            if ([value isKindOfClass:[NSString class]]) {
                NSString* leftTitle=(NSString*)value;
                CGFloat x=(size.width!=0)?_insertLeftX+i*(size.width+_itemLeftSpace):_insertLeftX+i*(leftImageWidth+_itemLeftSpace);
                size=[self getStringSize:leftFontValve withString:leftTitle andWidth:100];
                [self layoutLableWithFrame:CGRectMake(x, getCenterY(size.height), size.width, size.height) key:[NSString stringWithFormat:@"leftlabeless%ld",(long)i] labText:leftTitle];
                
            }
            if ([value isKindOfClass:[UIImage class]]) {
                UIImage* image=(UIImage*)value;
                CGFloat x;
                x=(size.width!=0)? _insertLeftX+i*(size.width+_itemLeftSpace):_insertLeftX+i*(leftImageWidth+_itemLeftSpace);
                [self layoutImageViewWithFrame:CGRectMake(x, getCenterY(leftImageHight), leftImageWidth, leftImageHight) key:[NSString stringWithFormat:@"leftImagess%ld",(long)i] image:image];
            }
        }
    }
}


-(void)setRightItemsArray:(NSArray *)rightItemsArray
{
    _rightItemsArray=rightItemsArray;
    UIImageView* imageView=_subViewsDic[@"rightImage"];
    UILabel* label=_subViewsDic[@"rightTitle"];
    [imageView removeFromSuperview];
    [label removeFromSuperview];
    
    if (rightItemsArray.count>0) {
        
        for (NSInteger i=0; i<rightItemsArray.count; i++) {
            if (i==2) {
                return;
            }
            id value=rightItemsArray[i];
            CGSize size=CGSizeZero;
            if ([value isKindOfClass:[NSString class]]) {
                NSString* leftTitle=(NSString*)value;
                CGFloat x=(size.width!=0)?_screenWidth-_insertRightX-(i+1)*(size.width)-_itemRigtSpace*i:_screenWidth-_insertRightX-(i+1)*(leftImageWidth)-_itemRigtSpace*i;
                size=[self getStringSize:leftFontValve withString:leftTitle andWidth:100];
                
                [self layoutLableWithFrame:CGRectMake(x, getCenterY(size.height), size.width, size.height) key:[NSString stringWithFormat:@"rightlabeless%ld",(long)i] labText:leftTitle];
                
            }
            if ([value isKindOfClass:[UIImage class]]) {
                UIImage* image=(UIImage*)value;
                
                CGFloat x=size.width!=0? _screenWidth-_insertRightX-(i+1)*(size.width)-_itemRigtSpace*i:_screenWidth-_insertRightX-(i+1)*(leftImageWidth)-_itemRigtSpace*i;
                
                [self layoutImageViewWithFrame:CGRectMake(x, getCenterY(leftImageHight), leftImageWidth, leftImageHight) key:[NSString stringWithFormat:@"rightImagess%ld",(long)i] image:image];
            }
        }
    }
}

-(void)setTitleView:(UIView *)titleView
{
    _titleView=titleView;
    UILabel* lab=_subViewsDic[@"title"];
    UIImageView* imageView=_subViewsDic[@"centerImage"];
    [lab removeFromSuperview];
    [imageView removeFromSuperview];
    if (titleView) {
        UIView* view=_subViewsDic[@"titleView"];
        if (view) {
            [view removeFromSuperview];
        }else{
            [self addSubview:titleView];
            [_subViewsDic setObject:titleView forKey:@"titleView"];
        }
    }
}

-(void)selectItem:(UITapGestureRecognizer*)tap
{
    CGPoint point=[tap locationInView:self];
    
    CGFloat leftX=_leftItemsArray?(_insertLeftX*2+leftImageWidth*2+_itemLeftSpace)/2:(_insertLeftX*2+leftImageWidth)/2;
    if (point.x<leftX*2) {
        NSInteger index=(point.x)/leftX;
        if (_delegate&& [_delegate respondsToSelector:@selector(navigationBarView:leftItemsClickWithIndex:)]) {
            [_delegate navigationBarView:self leftItemsClickWithIndex:index];
        }
        AXDLog(@"left-index------%ld",(long)index);
    }
    
    CGFloat rightX=_rightItemsArray?(_insertRightX*2+leftImageWidth*2+_itemRigtSpace)/2:(_insertRightX*2+leftImageWidth)/2;
    if (point.x>_screenWidth-rightX*2) {
        NSInteger index=(point.x-(_screenWidth-rightX*2))/rightX;
        if (_delegate && [_delegate respondsToSelector:@selector(navigationBarView:rightItemsClickWithIndex:)]) {
            [_delegate navigationBarView:self rightItemsClickWithIndex:index];
        }
        AXDLog(@"right-index------%ld",(long)index);
    }
    
    if (point.x>_screenWidth/2-25+_centerOffset&&point.x<_screenWidth/2+25+_centerOffset) {
        if (_delegate && [_delegate respondsToSelector:@selector(navigationBarViewCenterClick:)]) {
            [_delegate navigationBarViewCenterClick:self];
        }
        AXDLog(@"--------center-click---------");
    }
    
}



-(void)layoutLableWithFrame:(CGRect)frame key:(NSString*)key labText:(NSString*)text
{
    UILabel* lab=_subViewsDic[key];
    if (!lab) {
        UILabel* lab=[[UILabel alloc]initWithFrame:frame];
        lab.font=FontSize(leftFontValve);
        lab.text=text;
        lab.textColor=_textColor;
        //        lab.backgroundColor=[UIColor orangeColor];
        [self addSubview:lab];
        [_subViewsDic setObject:lab forKey:key];
    }else{
        lab.text=text;
        lab.textColor=_textColor;
        lab.frame=frame;
    }
}

-(void)layoutImageViewWithFrame:(CGRect)frame key:(NSString*)key image:(UIImage*)image
{
    UIImageView* imageView=_subViewsDic[key];
    if (!imageView) {
        imageView=[[UIImageView alloc]initWithFrame:frame];
        imageView.image=image;
        [self addSubview:imageView];
        [_subViewsDic setObject:imageView forKey:key];
    }else{
        imageView.image=image;
    }
}




-(CGSize)getStringSize:(float)fontSize withString:(NSString*)str andWidth:(CGFloat)width{
    
    return [str boundingRectWithSize:CGSizeMake(width, LONG_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FontSize(fontSize)} context:nil].size;
}




@end
