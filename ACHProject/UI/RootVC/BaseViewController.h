//
//  BaseViewController.h
//  baseViewDemo
//
//  Created by wqd on 15/12/25.
//  Copyright © 2015年 wqd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


@property(nonatomic,strong)UIView *navBarView;

@property(nonatomic,strong)UIView *navLine;

@property(nonatomic,strong)UILabel *navtitleLabel;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UILabel *returnTitle;
@property(nonatomic,strong)UIButton *rightButton;

-(void)backButtonClick;

-(void)hideNavBarView;
-(void)showNavBarView;

- (void)hideNavPopBtn;
@end
