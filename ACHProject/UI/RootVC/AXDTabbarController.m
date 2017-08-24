
//
//  AXDTabbarController.m
//  ACHProject
//
//  Created by 爱享到 on 2017/7/20.
//  Copyright © 2017年 爱享到. All rights reserved.
//




#import "AXDTabbarController.h"

@interface AXDTabbarController ()<UINavigationControllerDelegate>

{
    NSInteger _lastIndex;
}
@property(nonatomic)CGFloat screenWidth;
@property(nonatomic)CGFloat screenHeight;
@property(nonatomic,strong)NSMutableArray* imageViewArray;
@property(nonatomic,strong)NSMutableArray* lableArray;

@property(nonatomic)NSInteger viewControllersCount;

@property(nonatomic)CGFloat insertX;//每个item的横向间隔
@property(nonatomic)CGFloat insertY;



@end

@implementation AXDTabbarController



-(id)init
{
    self=[super init];
    if (self) {
        
        self.tabBar.hidden=YES;
        
        
        _tabBarHight=50;
        _itemWidth=22;
        _lastIndex=0;
        _insertY=(_tabBarHight-_itemWidth-14-1)/2.0;
        
        //当前屏幕的高和宽
        _screenHeight=[UIScreen mainScreen].bounds.size.height;
        _screenWidth=[UIScreen mainScreen].bounds.size.width;
        
        _imageViewArray=[[NSMutableArray alloc]init];
        _lableArray=[[NSMutableArray alloc]init];
        
        _tabBarViewBackgroundColor=[UIColor whiteColor];
        
        self.tabBarView=[[UIView alloc]initWithFrame:CGRectMake(0, _screenHeight-_tabBarHight, _screenWidth, _tabBarHight)];
        
        _tabBarView.backgroundColor=_tabBarViewBackgroundColor;
        
        UILabel* lineLab=[[UILabel alloc]initWithFrame:CGRectMake(0,0.2, _screenWidth, 0.2)];
        lineLab.backgroundColor=[UIColor lightGrayColor];
        [_tabBarView addSubview:lineLab];
        
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTabBarItem:)];
        [_tabBarView addGestureRecognizer:tap];
        
        
        _normalColor=[UIColor lightGrayColor];
        _selectColor=[UIColor blueColor];
        
        
        
    }
    return self;
}

-(void)hidenTabBarView
{
    [UIView animateWithDuration:0.21 animations:^{
        [UIView setAnimationCurve:7];
        
        _tabBarView.frame=CGRectMake(-_screenWidth, _tabBarView.frame.origin.y, _screenWidth, _tabBarHight);
        
    }];
}

-(void)showTabBarView{
    
    [UIView animateWithDuration:0.21 animations:^{
        [UIView setAnimationCurve:7];
        
        _tabBarView.frame=CGRectMake(0, _tabBarView.frame.origin.y, _screenWidth, _tabBarHight);
        
    }];
}

- (void)setViewControllers:(NSArray *)viewControllers{
    
    [super setViewControllers:viewControllers];
    if (viewControllers) {
        _viewControllersCount=viewControllers.count;
        CGFloat insetX=(_screenWidth-_itemWidth*(viewControllers.count))/(viewControllers.count);
        for (NSInteger i=0; i<viewControllers.count; i++) {
            UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(insetX/2+i*(_itemWidth+insetX), _insertY+4, _itemWidth, _itemWidth)];
            
            [_tabBarView addSubview:imageView];
            [_imageViewArray addObject:imageView];
            
            UILabel* lab=[[UILabel alloc]initWithFrame:CGRectMake(i*_screenWidth/(viewControllers.count), _tabBarHight-10-_insertY, _screenWidth/(viewControllers.count), 14)];
            lab.textAlignment=NSTextAlignmentCenter;
            //            lab.font=[UIFont systemFontOfSize:(12/25.0)*_itemWidth];
            lab.font = FontSize((12/25.0)*_itemWidth);
            [_tabBarView addSubview:lab];
            [_lableArray addObject:lab];
            
        }
        
        for (UINavigationController *navVC in self.viewControllers) {
            if ([navVC isKindOfClass:[UINavigationController class]]) {
                navVC.delegate = self;
            }
            
        }
        
    }
}

-(void)setItemWidth:(CGFloat)itemWidth
{
    _itemWidth=itemWidth>=25?25:itemWidth;
    CGFloat insetX=(_screenWidth-_itemWidth*(_imageViewArray.count))/(_imageViewArray.count);
    _insertY=(_tabBarHight-_itemWidth-14-1)/2.0;
    for (NSInteger i=0; i<_imageViewArray.count; i++) {
        UIImageView* imageView=_imageViewArray[i];
        imageView.frame=CGRectMake(insetX/2+i*(_itemWidth+insetX), _insertY+2, _itemWidth, _itemWidth);
        
        UILabel* lab=_lableArray[i];
        lab.frame=CGRectMake(i*_screenWidth/(_imageViewArray.count), _tabBarHight-10-_insertY-2, _screenWidth/(_imageViewArray.count), 14);
        lab.font=FontSize((12/25.0)*_itemWidth);
    }
    
}

-(void)setTabBarViewBackgroundColor:(UIColor *)tabBarViewBackgroundColor{
    _tabBarViewBackgroundColor=tabBarViewBackgroundColor;
    _tabBarView.backgroundColor=tabBarViewBackgroundColor;
}

-(void)setImagesArray:(NSArray *)imagesArray
{
    _imagesArray=imagesArray;
    if (_imagesArray) {
        for (NSInteger i=0; i<_imagesArray.count; i++) {
            UIImageView* imageView=_imageViewArray[i];
            imageView.image=[UIImage imageNamed:_imagesArray[i]];
        }
    }
}

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray=titleArray;
    if (_titleArray) {
        for (NSInteger i=0; i<_titleArray.count; i++) {
            UILabel* lab=_lableArray[i];
            lab.text=_titleArray[i];
            if (i==0) {
                lab.textColor=_selectColor;
            }else{
                lab.textColor=_normalColor;
            }
            
        }
    }
}

-(void)selectTabBarItem:(UITapGestureRecognizer*)tap
{
    CGPoint point=[tap locationInView:_tabBarView];
    NSInteger index=point.x/(_screenWidth/(_viewControllersCount));
    if (_lastIndex!=index && index!=3) {
        self.selectedIndex=index;
        [self updateImageAndLableTextColorWhenSelectItemWithIndex:index];
    }
    
    if (index==3) {
        [[NSNotificationCenter defaultCenter]postNotificationName:SELECT_MESSAGE_ITEM object:self userInfo:@{@"lastIndex":@(index)}];
    }
    
    UINavigationController* nav=self.viewControllers[index];
    _tabBarDelegate=nav.viewControllers[0];
    if (_tabBarDelegate && [_tabBarDelegate respondsToSelector:@selector(tabBarController:selectItemWithIndex:lastIndex:)]) {
        if ([_tabBarDelegate isEqual:nav.viewControllers[0]]) {
            [_tabBarDelegate tabBarController:self selectItemWithIndex:index lastIndex:_lastIndex];
        }
    }
    _lastIndex=index;
}

-(void)updateImageAndLableTextColorWhenSelectItemWithIndex:(NSInteger)index
{
    for (NSInteger i=0; i<_imageViewArray.count; i++) {
        UIImageView* imageView=_imageViewArray[i];
        UILabel* lab=_lableArray[i];
        if (i==index) {
            UILabel* lab1=_lableArray[index];
            imageView.image=[UIImage imageNamed:_selectImagesArray[i]];
            lab1.textColor=_selectColor;
            if (_selectTitleArray) {
                NSString* str=_selectTitleArray[index];
                if (![str isEqualToString:@""]) {
                    lab1.text=str;
                }
            }
        }else{
            imageView.image=[UIImage imageNamed:_imagesArray[i]];
            lab.textColor=_normalColor;
            lab.text=_titleArray[i];
        }
    }
}

-(void)appointTabBarItemWithIndex:(NSInteger)index
{
    self.selectedIndex=index;
    UINavigationController* nav=self.viewControllers[index];
    _tabBarDelegate=nav.viewControllers[0];
    if (_tabBarDelegate && [_tabBarDelegate respondsToSelector:@selector(tabBarController:selectItemWithIndex:lastIndex:)]) {
        if ([_tabBarDelegate isEqual:nav.viewControllers[0]]) {
            [_tabBarDelegate tabBarController:self selectItemWithIndex:index lastIndex:_lastIndex];
        }
    }
    [self updateImageAndLableTextColorWhenSelectItemWithIndex:index];
    _lastIndex=index;
}

-(void)setNormalColor:(UIColor *)normalColor
{
    _normalColor=normalColor;
    for (NSInteger i=0; i<_imageViewArray.count; i++) {
        UIImageView* imageView=_imageViewArray[i];
        imageView.backgroundColor=_normalColor;
        
        UILabel* lab=_lableArray[i];
        lab.backgroundColor=_normalColor;
    }
}

-(void)setRedNumLableWithNumber:(NSInteger)number andIndex:(NSInteger)index
{
    UIImageView* item=_imageViewArray[index];
    UILabel* lab=[item viewWithTag:index+100];
    //如果角标数字为0，则移除
    if (number==0) {
        [lab removeFromSuperview];
        return;
    }
    if (lab) {
        
        lab.text=[NSString stringWithFormat:@"%ld",(long)number];
        
    }else{
        NSString* numStr;
        if (number>=99) {
            numStr=@"99+";
        }else{
            numStr=[NSString stringWithFormat:@"%ld",(long)number];
        }
        
        CGSize numSize=[self getStringSize:13 withString:numStr andWidth:25];
        CGFloat width=number>10?numSize.width+8:15;
        lab=[[UILabel alloc]init];
        lab.center=CGPointMake(_itemWidth, 2);
        lab.bounds=CGRectMake(0, 0, width, 15);
        lab.layer.anchorPoint=CGPointMake(0.3, 0.5);
        lab.backgroundColor=[UIColor redColor];
        lab.layer.cornerRadius=7.5;
        lab.layer.masksToBounds=YES;
        lab.font=FontSize(12);
        lab.textColor=[UIColor whiteColor];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.text=numStr;
        lab.tag=index+100;
        [item addSubview:lab];
    }
}

-(void)showRedPoint:(BOOL)isShow andIndex:(NSInteger)index
{
    UIImageView* item=_imageViewArray[index];
    UIView* view=[item viewWithTag:index+200];
    if (isShow) {
        if (!view) {
            view=[[UIView alloc]init];
            view.center=CGPointMake(_itemWidth, 1);
            view.bounds=CGRectMake(0, 0, 8, 8);
            view.backgroundColor=[UIColor redColor];
            view.layer.cornerRadius=8/2.0;
            view.tag=index+200;
            view.layer.masksToBounds=YES;
            [item addSubview:view];
        }
    }else{
        [view removeFromSuperview];
    }
}

-(CGSize)getStringSize:(float)fontSize withString:(NSString*)str andWidth:(CGFloat)width{
    
    return [str boundingRectWithSize:CGSizeMake(width, LONG_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}


#pragma mark------导航上视图控制器的协议方法
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController* rootVC=navigationController.viewControllers.firstObject;
    if (viewController!=rootVC) {
        [_tabBarView removeFromSuperview];
        [rootVC.view addSubview:_tabBarView];
    }
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController* rootVC=navigationController.viewControllers[0];
    if (viewController==rootVC) {
        
        //        //如果下面的tabBar存在，修改当前视图控制器的view大小
        //        rootVC.view.frame=CGRectMake(0, 0, _screenWidth, _screenHeight-_tabBarHight);
        
        [_tabBarView removeFromSuperview];
        [self.view addSubview:_tabBarView];
    }
}

-(void)setSelectColor:(UIColor *)selectColor
{
    _selectColor=selectColor;
    [self updateImageAndLableTextColorWhenSelectItemWithIndex:0];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [CommondTools gotoMainVC];
    
    
}






















/**
 * 添加一个子控制器
 *
 *@param vc     子控制器
 *@param title  标题
 *@param iamge 图标
 *@param selectImage 选中图标
 */

-(void)addChildViewControll:(UIViewController *)vc title:(NSString *)title image:(NSString *)iamge selectImage:(NSString *)selectImage
{
//    UIImage *image = [UIImage ]
    vc.view.backgroundColor = AXDRandomColor;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:iamge];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    [self addChildViewController:vc];
    
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
