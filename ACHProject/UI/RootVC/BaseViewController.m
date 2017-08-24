//
//  BaseViewController.m
//  CFArchitecture
//
//  Created by Mr.Guo on 2017/5/8.
//  Copyright © 2017年 Mr.Guo. All rights reserved.
//

#import "BaseViewController.h"
#define ItemImagewidth 24.0f
#define ItemButtonwidth 50.0f
@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configrueNavBar];
}
#pragma mark - 自定义导航栏,默认有四个按钮和一个标题
- (void)configrueNavBar
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navBar = [[CFNavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavHeight)];
    [self.view addSubview:self.navBar];
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NavHeight);
    }];
    if (self.navigationController.viewControllers.count>1) {
        [self addBackItem];
    }
}


/**
   当导航控制器中视图控制器数量大于1时添加返回按钮
 */
-(void)addBackItem{
    self.backItem.image = [UIImage imageNamed:@"backButton"];
}

-(UIImageView *)backItem{
    if (!_backItem)
    {
        _backItem = [[UIImageView alloc]init];
        _backItem.contentMode = UIViewContentModeScaleAspectFit;
        _backItem.userInteractionEnabled = YES;
        UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backItemTouched:)];
        [_backItem addGestureRecognizer:backTap];
        [_navBar addSubview:_backItem];
        _backItem.frame = CGRectMake(11, 31, ItemImagewidth, ItemImagewidth);
    }
    return _backItem;
}

- (void)backItemTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
  添加右按钮 (图片)

 @param rightItemImageName 图片名称
 */
-(void)addrightItem:(NSString *)rightItemImageName{
    
    if (rightItemImageName.length!=0&&[self returnImagePath:rightItemImageName])
    {
        self.rightItem.image = [UIImage imageNamed:rightItemImageName];
    }
}

-(UIImageView *)rightItem{
    
    if (!_rightItem) {
        _rightItem = [[UIImageView alloc]init];
        _rightItem.userInteractionEnabled = YES;
        UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightItemTouched:)];
        [_rightItem addGestureRecognizer:backTap];
        [_navBar addSubview:_rightItem];
        _rightItem.frame = CGRectMake(ScreenWidth-34, 31, ItemImagewidth, ItemImagewidth);
    }
    return _rightItem;
}

- (void)rightItemTouched:(id)sender{
    AXDLog(@"用到图片的时候重写rightItemTouched方法");
}

/**
 *  添加右侧按钮(文字)
 *
 *  @param Title 按钮文字
 */
- (void)addrightButton:(NSString *)Title{
    
    if (Title.length!=0)
    {
        [self.rightButton setTitle:Title forState:0];
    }
}

-(UIButton *)rightButton{
    
    if (!_rightButton) {
        
        _rightButton = [[UIButton alloc]init];
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:0];
        [_navBar addSubview:_rightButton];
        _rightButton.frame =  CGRectMake(ScreenWidth-55, 30, ItemButtonwidth, ItemImagewidth);
        
    }
    return _rightButton;
    
}

- (void)rightButtonClick:(id)sender{
    AXDLog(@"用到按钮的时候重写rightButtonClick方法");
}
/**
 *  添加左按钮(图片)
 *
 *  @param leftItemImageName 图片名字
 */
-(void)addleftItem:(NSString *)leftItemImageName{
    
    if (leftItemImageName.length!=0&&[self returnImagePath:leftItemImageName])
    {
        if (_backItem!=nil) {
            [_backItem removeFromSuperview];
        }
        self.leftItem.image = [UIImage imageNamed:leftItemImageName];
    }
}

-(UIImageView *)leftItem{
    
    if (!_leftItem) {
        _leftItem = [[UIImageView alloc]init];
        UIView *touchView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        [_navBar addSubview:touchView];
        UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftItemTouched:)];
        [touchView addGestureRecognizer:backTap];
        [_navBar addSubview:_leftItem];
        _leftItem.frame = CGRectMake(11, 31, ItemImagewidth, ItemImagewidth);
    }
    return _leftItem;
}

-(void)leftItemTouched:(id)sender{
    AXDLog(@"用到图片的时候重写leftItemTouched方法");
}
/**
 *  添加左侧按钮(文字)
 *
 *  @param Title 按钮标题
 */
- (void)addleftButton:(NSString *)Title{
    
    if (Title.length!=0)
    {
        [self.leftButton setTitle:Title forState:0];
    }
    
}

-(UIButton *)leftButton{
    
    if (!_leftButton) {
        
        _leftButton = [[UIButton alloc]init];
        [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:0];
        [_navBar addSubview:_leftButton];
        _leftButton.frame = CGRectMake(5, 30, ItemButtonwidth, ItemImagewidth);
        
    }
    return _leftButton;
}

- (void)leftButtonClick:(id)sender{
    AXDLog(@"用到按钮的时候重写leftButtonClick方法");
}

-(BOOL)returnImagePath:(NSString *)ImageName{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:ImageName ofType:@"png"];
    if (path.length>0)
    {
        return NO;
    }
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}
#pragma mark - setter
-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    _navBar.titleLabel.text = title;
}
@end
