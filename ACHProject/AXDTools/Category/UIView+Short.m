//
//  UIView+Short.m
//  MuckBoss
//
//  Created by FangZhongli on 16/7/21.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import "UIView+Short.h"
#import <objc/runtime.h>

@implementation UIView (Short)

+ (UIButton *)commitButtonWithY:(float)y title:(NSString *)title handler:(viewClickBlock)handler superView:(UIView *)superView {
    return [UIButton commitButtonWithY:y width:superView.axd_width-30 title:title handler:handler superView:superView];
}

+ (UIButton *)commitButtonWithY:(float)y width:(float)width title:(NSString *)title handler:(viewClickBlock)handler superView:(UIView *)superView {
    return [UIButton commitButtonWithFrame:CGRectMake((superView.axd_width-width)/2, y, width, 45) title:title handler:handler superView:superView];
}

+ (UIButton *)commitButtonWithFrame:(CGRect)frame title:(NSString *)title handler:(viewClickBlock)handler superView:(UIView *)superView {
    
    UIButton *btn = [UIButton buttonWithFrame:frame title:title color:kHexRGB(0x806400) backgroundColor:kColor_main superView:superView];
    [btn addLayerCornerRadius:5];
    [btn buttonHandler:handler];
    btn.titleLabel.font = kFontSize_navTitle;
    return btn;
}

+ (UITextField*)creatInputViewPlaceholder:(NSString *)placeholder leftImage:(UIImage *)leftImage isPwd:(BOOL)isPwd{
    UITextField *textFile = [[UITextField alloc]init];
    textFile.placeholder = placeholder;
    [textFile setValue:kColor_subContent forKeyPath:kSetPlaceholderColor];
    textFile.font = kFontSize_title;
    textFile.secureTextEntry = isPwd;
    textFile.textColor = kColor_title;
    textFile.layer.borderColor = kColor_main.CGColor;
    textFile.layer.borderWidth = kHeight_Line;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 20, 20)];
    imageView.image = leftImage;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [leftView addSubview:imageView];
    textFile.leftView = leftView;
    textFile.leftViewMode=UITextFieldViewModeAlways;
    return textFile;
}

- (void)addLineWithBottom:(BOOL)bottom top:(BOOL)top{
    if (bottom) {
        UIView *b = [[UIView alloc] initWithFrame:CGRectMake(0, self.axd_height-kHeight_Line, self.axd_height, kHeight_Line)];
        b.backgroundColor = kColor_line;
        [self addSubview:b];
    }
    
    if (top) {
        UIView *b = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.axd_width, kHeight_Line)];
        b.backgroundColor = kColor_line;
        [self addSubview:b];
    }
}

- (UIView*)addLineWithY:(float)y {
    return [self addLineWithY:y spaceLeft:0];
}

- (UIView*)addLineWithY:(float)y spaceLeft:(float)spaceLeft {
    UIView *b = [[UIView alloc] initWithFrame:CGRectMake(spaceLeft, y, self.axd_width, kHeight_Line)];
    b.backgroundColor = kColor_line;
    [self addSubview:b];
    return b;
}

- (void)removeViewWithTag:(NSInteger)tag {
    [[self viewWithTag:tag] removeFromSuperview];
}

+ (NSMutableAttributedString *)attributedString:(NSString *)string carSumCount:(NSString *)carCount{
    NSRange carRange = [string rangeOfString:carCount];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:kFontSize_title,NSForegroundColorAttributeName:kColor_title}];
    if (carRange.location == NSNotFound) {
        return attr;
    }
    [attr addAttributes:@{NSForegroundColorAttributeName:kColor_red} range:carRange];
    
    return attr;
}

+ (NSMutableAttributedString *)attributedString:(NSString *)string carCount:(NSString *)carCount{
    NSRange carRange = [string rangeOfString:carCount];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:kFontSize_content,NSForegroundColorAttributeName:kColor_subContent}];
    if (carRange.location == NSNotFound) {
        return attr;
    }
    [attr addAttributes:@{NSForegroundColorAttributeName:kColor_title} range:carRange];
    
    return attr;
}

+ (NSMutableAttributedString*)attributedString:(NSString *)string {
    return [UIView attributedString:string leftColor:kColor_subContent rightColor:kColor_title];
}

+ (NSMutableAttributedString *)attributedString:(NSString *)string leftColor:(UIColor*)leftColor rightColor:(UIColor*)rightColor {
    NSUInteger location = [string rangeOfString:@"："].location;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:kFontSize_content}];
    if (location == NSNotFound) {
        return attr;
    }

    [attr addAttributes:@{NSForegroundColorAttributeName:leftColor} range:NSMakeRange(0, location+1)];
    [attr addAttributes:@{NSForegroundColorAttributeName:rightColor} range:NSMakeRange(location+1, string.length-location-1)];
    
    return attr;
}


@end
