//
//  UIView+Resuable.m
//  MuckBoss
//
//  Created by FangZhongli on 16/7/21.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import "UIView+Resuable.h"
#import <objc/runtime.h>

@implementation UIView (Resuable)

#pragma mark - layer
- (void)addLayerBorderColor:(UIColor*)color borderWidth:(CGFloat)width {
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (void)addLayerCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)addLayerBorderColor:(UIColor*)color borderWidth:(CGFloat)width cornerRadius:(CGFloat)radius  {
    [self addLayerCornerRadius:radius];
    [self addLayerBorderColor:color borderWidth:width];
}

#pragma mark - UIView

- (void)removeAllSubView {
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
}

+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor*)bgColor superView:(UIView *)superView {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = bgColor;
    [superView addSubview:view];
    return view;
}

#pragma mark - UILable Short Creat
+ (UILabel *)initWithFrame:(CGRect)frame title:(NSString *)title superView:(UIView*)superView {
    return [UILabel initWithFrame:frame title:title titleColor:nil superView:superView];
}
+ (UILabel *)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor*)color superView:(UIView*)superView {
    return [UILabel initWithFrame:frame title:title titleColor:color textAlignment:NSTextAlignmentLeft superView:superView];
}

+ (UILabel *)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color font:(UIFont*)font superView:(UIView *)superView {
    UILabel *lab = [UILabel initWithFrame:frame title:title titleColor:color textAlignment:NSTextAlignmentLeft superView:superView];
    lab.font = font;
    return lab;
}

+ (UILabel *)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor*)color textAlignment:(NSTextAlignment)aligment superView:(UIView*)superView {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:frame];
    titleLab.text = title;
    titleLab.textColor = color;
    titleLab.textAlignment = aligment;
    [superView addSubview:titleLab];
    return titleLab;
}
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}


#pragma mark - UIButton
+ (UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)image superView:(UIView *)superView {
    return [UIButton buttonWithFrame:frame title:nil image:image superView:superView];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title superView:(UIView *)superView {
    return [UIButton buttonWithFrame:frame title:title image:nil superView:superView];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color backgroundColor:(UIColor *)bgColor superView:(UIView *)superView {
    UIButton *btn = [UIButton buttonWithFrame:frame title:title image:nil superView:superView];
    btn.backgroundColor = bgColor;
    [btn setTitleColor:color forState:UIControlStateNormal];
    return btn;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color backgroundColor:(UIColor *)bgColor font:(UIFont*)font superView:(UIView *)superView {
    UIButton *btn = [UIButton buttonWithFrame:frame title:title color:color backgroundColor:bgColor superView:superView];
    btn.titleLabel.font = font;
    return btn;
}


+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image superView:(UIView *)superView {
    UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
    location.frame = frame;
    [location setImage:image forState:UIControlStateNormal];
    [location setTitle:title forState:UIControlStateNormal];
    [superView addSubview:location];
    return location;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title bgImage:(UIImage *)bgImage superView:(UIView *)superView {
    UIButton *btn = [UIButton buttonWithFrame:frame title:title image:nil superView:superView];
    [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
    return btn;
}

#pragma mark - UITextFild
+ (UITextField*)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text superView:(UIView*)superView{
    UITextField *textF = [[UITextField alloc] initWithFrame:frame];
    textF.placeholder = placeholder;
    textF.text = text;
    [superView addSubview:textF];
    return textF;
}

+ (UITextField*)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text color:(UIColor*)color font:(UIFont *)font superView:(UIView*)superView{
    UITextField *textF = [UITextField textFieldWithFrame:frame placeholder:placeholder text:text superView:superView];
    textF.textColor = color;
    textF.font = font;
    return textF;
}

#pragma mark - UIImageView
+ (UIImageView*)imageViewWithFrame:(CGRect)frame image:(UIImage*)image superView:(UIView*)superView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    [superView addSubview:imageView];
    return imageView;
}

//#pragma mark - private property
//- (void)setViewClickBlock:(viewClickBlock)viewClickBlock{
//    objc_setAssociatedObject(self, @selector(viewClickBlock), viewClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//
//    // 不知这样添加是否合适，因为Button又绑定了TouchUpInside事件了！
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
//    [self addGestureRecognizer:tap];
//    self.userInteractionEnabled = YES;
//}
//
//- (viewClickBlock)viewClickBlock{
//    return objc_getAssociatedObject(self, _cmd);
//}
//
//- (void)viewClick:(UITapGestureRecognizer *)tap {
//    self.viewClickBlock(tap.view);
//}

#pragma mark - 添加单击手势
- (void)tapHandler:(tapAction)block {
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, @selector(tapAction:), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    tapAction block = objc_getAssociatedObject(self, _cmd);
    !block?:block(self);
}


@end

@implementation UIButton (Ext)

//- (void)setViewClickBlock:(viewClickBlock)viewClickBlock{
//    [super setViewClickBlock:viewClickBlock];
//    [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)buttonClickBlock:(viewClickBlock)block{
//
//
//    self.viewClickBlock  = block;
//    [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//
//}
//
//- (void)click:(UIButton *)btn {
//    if (self.viewClickBlock) {
//        self.viewClickBlock(btn);
//    }
//}
- (void)buttonHandler:(tapAction)block{
    objc_setAssociatedObject(self, @selector(buttonClick), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick{
    tapAction block = objc_getAssociatedObject(self, _cmd);
    !block?:block(self);
}

@end

@implementation UITextField (Event)
#pragma mark - textFieldEditingChangeBlock

- (void)textfieldChangeHandler:(tapAction)block{
    objc_setAssociatedObject(self, @selector(textfieldChanged), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(textfieldChanged) forControlEvents:UIControlEventEditingChanged];
}

- (void)textfieldChanged{
    tapAction block = objc_getAssociatedObject(self, _cmd);
    !block?:block(self);
}


//- (void)setTextFieldEditingChangeBlock:(viewClickBlock)textFieldEditingChangeBlock {
//    objc_setAssociatedObject(self, @selector(textFieldEditingChangeBlock), textFieldEditingChangeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    [self addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
//}
//- (viewClickBlock)textFieldEditingChangeBlock{
//    return objc_getAssociatedObject(self, _cmd);
//}
//- (void)textfieldChanged:(UITextField *)textField{
//    if (self.textFieldEditingChangeBlock) {
//        self.textFieldEditingChangeBlock(textField);
//    }
//
//}

#pragma mark - textFieldEditingDidBeginBlock


- (void)textfieldEditingDidBeginHandler:(tapAction)block{
    objc_setAssociatedObject(self, @selector(textfieldEditingDidBegin), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(textfieldEditingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
}

- (void)textfieldEditingDidBegin{
    tapAction block = objc_getAssociatedObject(self, _cmd);
    !block?:block(self);
}

//- (void)setTextFieldEditingDidBeginBlock:(viewClickBlock)textFieldEditingDidBeginBlock{
//    objc_setAssociatedObject(self, @selector(textFieldEditingDidBeginBlock), textFieldEditingDidBeginBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    [self addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
//}
//- (viewClickBlock)textFieldEditingDidBeginBlock{
//    return objc_getAssociatedObject(self, _cmd);
//}
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (self.textFieldEditingDidBeginBlock) {
//        self.textFieldEditingDidBeginBlock(textField);
//    }
//}

#pragma mark - textFieldEditingDidEndBlock

- (void)textfieldEditingDidEndHandler:(tapAction)block{
    objc_setAssociatedObject(self, @selector(textfieldEditingDidEnd), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(textfieldEditingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)textfieldEditingDidEnd{
    tapAction block = objc_getAssociatedObject(self, _cmd);
    !block?:block(self);
}

//- (void)setTextFieldEditingDidEndBlock:(viewClickBlock)textFieldEditingDidEndBlock{
//    objc_setAssociatedObject(self, @selector(textFieldEditingDidEndBlock), textFieldEditingDidEndBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    [self addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
//}
//- (viewClickBlock)textFieldEditingDidEndBlock{
//    return objc_getAssociatedObject(self, _cmd);
//}
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if (self.textFieldEditingDidEndBlock) {
//        self.textFieldEditingDidEndBlock(textField);
//    }
//}

@end

@implementation UIView (ShakeAnimation)

#pragma mark - 抖动
- (void)shakeView
{
    //    CGFloat t =4.0;
    //    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    //    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    //    self.transform = translateLeft;
    //    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
    //        [UIView setAnimationRepeatCount:2.0];
    //        self.transform = translateRight;
    //    } completion:^(BOOL finished){
    //        if(finished){
    //            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
    //                self.transform =CGAffineTransformIdentity;
    //            } completion:NULL];
    //        }
    //    }];
    
    //view抖动
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.repeatCount = 1;
    anim.values = @[@-4,@4,@-4,@4];
    [self.layer addAnimation:anim forKey:nil];
    
    
    
    
}

- (void)shakeRotation:(CGFloat)rotation {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.repeatCount = 2;
    anim.duration = .2;
    anim.values = @[@0,@(rotation),@0,@(-rotation),@0];
    [self.layer addAnimation:anim forKey:nil];
}


@end
