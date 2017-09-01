//
//  RootTabBarController.m
//  EternalSpirit
//
//  Created by FangZhongli on 2016/12/8.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import "RootTabBarController.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
@interface RootTabBarController ()<UIAlertViewDelegate>
{
    UIView *tabbarView;
    
    UIButton *_seleButton;
    
    UIButton *_tabBarItem[5];
}
@end

@implementation RootTabBarController

+ (instancetype)sharedTabBarController{
    static dispatch_once_t onceToken;
    static RootTabBarController *root = nil;
    dispatch_once(&onceToken, ^{
        root = [[RootTabBarController alloc] init];
    });
    return root;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createViewCtrls];
//    self.tabBar.hidden = YES;
//    [self initWithRootViewController];
//    
//    [self insterTabbarView];
//    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panEvent)];
//    [self.view addGestureRecognizer:pan];
    
//    NSArray *familyNames = [UIFont familyNames];
//    for( NSString *familyName in familyNames )
//    {
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for( NSString *fontName in fontNames )
//        {
//            printf( "\tFont: %s \n", [fontName UTF8String] );
//        }
//    }
    
}



//创建ViewCtrls
-(void)createViewCtrls
{
    NSArray *classArray = [[NSArray alloc] initWithObjects:@"HomeViewController",@"FightGroupViewController",@"MineViewController", nil];
    NSArray *titleArray = @[@"首页",@"拼团",@"我的"];
    NSArray *iconNormal = @[@"首页未选中",@"团-未选中",@"我的-未选中"];
    NSArray *iconSeleArray = @[@"首页-选中",@"团",@"矢量智能对象7"];
    NSMutableArray *controllers = @[].mutableCopy;
    [classArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BaseNavigationController *control = [[BaseNavigationController alloc]initWithRootViewController:[NSClassFromString(obj) new]];
        control.navigationBarHidden = YES;
        //        control.title = titleArray[idx];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArray[idx] image:[[UIImage imageNamed:iconNormal[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:iconSeleArray[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName,[UIColor lightGrayColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName,kColor_main,NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        
        control.tabBarItem = tabBarItem;
        [controllers addObject:control];
    }];
    self.viewControllers = controllers;
        
    for (UIView *subView in self.tabBar.subviews) {
        DLog(@"----%@",[subView class]);
        if ([subView isKindOfClass:[NSClassFromString(@"_UIBarBackground") class]]) {
            for (UIView *sub in subView.subviews) {
                if ([sub isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageV = (UIImageView *)sub;
                    imageV.image = [UIImage imageWithColor:[UIColor clearColor]];
                    break;
                }
            }
            break;
        }
    }
//    self.tabBar.barTintColor = kColor_white;
//    self.tabBar.tintColor = kColor_main;
}

-(void)panEvent
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWithRootViewController
{
    NSArray *classStrs = @[@"HomeViewController",@"VIPViewController",@"NearViewController",@"MyViewController"];
    NSMutableArray *navs = [NSMutableArray array];
    for (int i=0; i<classStrs.count; i++) {
        BaseNavigationController *navCtrl = [[BaseNavigationController alloc]initWithRootViewController:[NSClassFromString(classStrs[i]) new]];
        navCtrl.navigationBarHidden = YES;
        [navs addObject:navCtrl];
        [self addChildViewController:navCtrl];
    }
//    self.viewControllers = navs;
}

-(void)insterTabbarView
{
    tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-50, kBaseWidth, 50)];
    tabbarView.backgroundColor = kColor_white;
    tabbarView.layer.shadowColor = kColor_line.CGColor;
    tabbarView.layer.shadowOffset = CGSizeMake(0, -0.5);
    tabbarView.layer.shadowOpacity = 1;
    [self.view addSubview:tabbarView];
    
    [tabbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    NSArray *titleArray = @[@"首页",@"VIP",@"附近",@"我的"];
    NSArray *iconSeleArray = @[@"home_icon_SY1",@"home_icon_VIP1",@"home_icon_FJ1",@"home_icon_MINE1"];
    NSArray *iconArray = @[@"home_icon_SY",@"home_icon_VIP_top",@"home_icon_FJ",@"home_icon_MINE"];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        UIButton *itemButton = [UIButton buttonWithFrame:CGRectMake(kBaseWidth/titleArray.count*i, 6, kBaseWidth/titleArray.count, tabbarView.axd_height-6) title:titleArray[i] color:RGB(91, 160, 227) backgroundColor:nil font:kFontSize_content superView:tabbarView];
        [itemButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        itemButton.tag = i+1;
        [itemButton setImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
        [itemButton setImage:[UIImage imageNamed:iconSeleArray[i]] forState:UIControlStateSelected];
        [itemButton setImage:[UIImage imageNamed:iconSeleArray[i]] forState:UIControlStateHighlighted];
        [itemButton setImage:[UIImage imageNamed:iconSeleArray[i]] forState:UIControlStateReserved];
        itemButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [itemButton setTitleColor:kColor_subContent forState:UIControlStateNormal];
        [itemButton setTitleColor:kColor_main forState:UIControlStateSelected];
        [itemButton setTitleColor:kColor_main forState:UIControlStateHighlighted];
        
        [itemButton setImageEdgeInsets:UIEdgeInsetsMake(-5, itemButton.axd_width/2-35, 13, -itemButton.axd_width/2+34)];
        [itemButton setTitleEdgeInsets:UIEdgeInsetsMake(20, [UIImage imageNamed:iconArray[i]].size.width*-1, 0, 0)];
        
        if (i==1)
        {
            [itemButton setImageEdgeInsets:UIEdgeInsetsMake(-5, itemButton.axd_width/2-34-6, 13, -itemButton.axd_width/2+34)];
            [itemButton setTitleEdgeInsets:UIEdgeInsetsMake(20, [UIImage imageNamed:iconArray[i]].size.width*-1, 0, 0)];
        }
        
        NSLog(@"移动后的imageView%@",NSStringFromCGRect(itemButton.imageView.frame));
//         NSLog(@"移动后的titleLabel%@",NSStringFromCGRect(itemButton.titleLabel.frame));
        if (i==0)
        {
            itemButton.userInteractionEnabled = NO;
            itemButton.selected = YES;
            _seleButton = itemButton;
        }
        _tabBarItem[i] = itemButton;
    }
}

-(void)tabBarButtonClick:(UIButton*)button
{
    
    self.selectedIndex = button.tag-1;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    
    [super setSelectedIndex:selectedIndex];
    
    if (selectedIndex<self.viewControllers.count) {
        
        UIButton *button = _tabBarItem[selectedIndex];
        if (button == _seleButton)
        {
            return;
        }
        _seleButton.selected = NO;
        button.selected = YES;
        button.userInteractionEnabled = NO;
        _seleButton.userInteractionEnabled = YES;
        _seleButton = button;
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self loginIn];
}

-(void)loginIn{
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
    [self presentViewController:loginNav animated:YES completion:nil];
    
}

-(void)loginOnlyUserBeDeleted
{
    LoginViewController * login = [LoginViewController new];
//    login.isDeleted = YES;
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:login];
    [self presentViewController:loginNav animated:YES completion:nil];
}

@end
