//
//  HomeClassViewController.m
//  ACHProject
//
//  Created by chenxiaohong on 2017/8/28.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "HomeClassViewController.h"
#import "PopularStoreCell.h"
#import "RushBuyCell.h"
#import "FastidiousChoiseCell.h"
#import "RushBuyCell.h"
#import "HomeToolView.h"

#import "AdvertiseCell.h"
#import "MerchaintViewController.h"

@interface HomeClassViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{
    HomeToolView *_tool;
}
@property (nonatomic,strong)UITableView *mainTabView;
@property (nonatomic,strong)NSMutableArray *mainDataArr;
@property (nonatomic,strong)SDCycleScrollView *cycleScrollerView;

@end

@implementation HomeClassViewController

-(UITableView *)mainTabView
{
    if(!_mainTabView){
        _mainTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kBaseWidth,kBaseHeight -kbaseTabBarHeight) style:UITableViewStyleGrouped];
        _mainTabView.delegate=self;
        _mainTabView.dataSource=self;
        _mainTabView.separatorStyle=NO;
        _mainTabView.estimatedRowHeight = 100;
        _mainTabView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
        _mainTabView.backgroundColor = [UIColor orangeColor];
        
    }
    
    //注册cell
    [_mainTabView registerNib:[UINib nibWithNibName:@"PopularStoreCell" bundle:nil] forCellReuseIdentifier:@"PopularCell"];
    
    [_mainTabView registerNib:[UINib nibWithNibName:@"FastidiousChoiseCell" bundle:nil] forCellReuseIdentifier:@"FastidiousChoiseCell"];
    
    [_mainTabView registerNib:[UINib nibWithNibName:@"RushBuyCell" bundle:nil] forCellReuseIdentifier:@"RushBuyCell"];
    
    [_mainTabView registerNib:[UINib nibWithNibName:@"AdvertiseCell" bundle:nil] forCellReuseIdentifier:@"AdvertiseCell"];

    
    return _mainTabView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainDataArr = [NSMutableArray array];
    [self.view addSubview:self.mainTabView];

}



#pragma mark - delegate and dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 3;
    }else {
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section == 3) {
        PopularStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PopularCell"];
        return cell;
    }else if (indexPath.section == 2){
        //精选推荐
        FastidiousChoiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FastidiousChoiseCell"];
        return cell;
        
    }else if (indexPath.section == 1){
        //抢购秒杀
        RushBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RushBuyCell"];
        return cell;
    }else if (indexPath.section == 0){
        //新闻头条
        AdvertiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdvertiseCell"];
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return (153.5*kBaseScale_width + 90.0f * 2);
    }else if (section == 1){
        return 5;
    }else if (section == 3){
        return 50;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //添加轮播图
    if (section == 0) {
        
        UIView *headerView = [UIView viewWithFrame:CGRectMake(0, 0, kBaseWidth, 0) backgroundColor:kColor_background superView:nil];
        
        _cycleScrollerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kBaseWidth, 153.5*kBaseScale_width)
                                                                delegate:self
                                                        placeholderImage:[UIImage imageNamed:@""]];
        
        _cycleScrollerView.localizationImageNamesGroup = @[@"banner_DQ",
                                                           @"banner_hy",
                                                           @"banner_mryg"];
        
        _cycleScrollerView.autoScrollTimeInterval = 3.;// 自动滚动时间间隔
        _cycleScrollerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;// 翻页 右下角
        _cycleScrollerView.titleLabelBackgroundColor = [UIColor clearColor];// 图片对应的标题的 背景色。（因为没有设标题）

        // ok xib 自动布局都可以。还是很不错的。
        [SDCycleScrollView clearImagesCache];// 清除缓存。
        
        
        
        HomeToolView *tool = [HomeToolView sharedToolViewModels:nil complection:^(NSInteger index) {
            //index 点击选中的item位置 ; 接口放回item 数据的个数(不包括 集中采购, 和全部)
            //            [__weakSelf gotoVC:index allItemNum:_mainModel.category_nav.count + 2];
            
            //如果加上 集中采购就换成上面注释的那句
            //            [WS(self) gotoVC:index allItemNum:_mainModel.category_nav.count + 1];
        }];
        _tool = tool;
        _tool.top = _cycleScrollerView.bottom;
        [headerView addSubview:_cycleScrollerView];
        [headerView addSubview:_tool];
        headerView.bottom = _tool.bottom + 10;
        
        return headerView;
        
    }else if (section == 3){
        //人气好店
        UIImageView *headerImg = [[UIImageView alloc]init];
        return headerImg;
    }
    else{
        return nil;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[MerchaintViewController new] animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
