
//
//  MerchaintViewController.m
//  ACHProject
//
//  Created by chenxiaohong on 2017/9/4.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "MerchaintViewController.h"
#import "CardCell.h"
#import "MerchaintHeaderView.h"
#import "PackageCell.h"
#import "CommentListCell.h"
#import "MerchaintIntroduceCell.h"
@interface MerchaintViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *mainTabView;
@property (nonatomic,strong)MerchaintHeaderView *mHeaderView;
@end

@implementation MerchaintViewController


-(UITableView *)mainTabView
{
    if(!_mainTabView){
        _mainTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kBaseWidth,kBaseHeight - kbaseTabBarHeight) style:UITableViewStyleGrouped];
        _mainTabView.delegate=self;
        _mainTabView.dataSource=self;
        _mainTabView.separatorStyle=NO;
        _mainTabView.estimatedRowHeight = 100;
//        _mainTabView.backgroundColor = [UIColor orangeColor];
        
    }
    
    //优惠券
      [_mainTabView registerNib:[UINib nibWithNibName:@"CardCell" bundle:nil] forCellReuseIdentifier:@"CardCell"];
    //套餐
    [_mainTabView registerNib:[UINib nibWithNibName:@"PackageCell" bundle:nil] forCellReuseIdentifier:@"PackageCell"];
    //评价
    [_mainTabView registerNib:[UINib nibWithNibName:@"CommentListCell" bundle:nil] forCellReuseIdentifier:@"CommentListCell"];
    
    [_mainTabView registerNib:[UINib nibWithNibName:@"MerchaintIntroduceCell" bundle:nil] forCellReuseIdentifier:@"MerchaintIntroduceCell"];
    
    
    return _mainTabView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTabView];
    
    
}

#pragma mark - delegate and dataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
       return 3;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return 5;
    }
    return 2;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //优惠券
            CardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CardCell"];
            return cell;
        }else if (indexPath.row == 2){
            MerchaintIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchaintIntroduceCell"];
            return cell;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell0"];
        }
        return cell;

        

        
    }else if (indexPath.section == 1 || indexPath.section == 2 ){
        //套餐  //优惠券
        PackageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PackageCell"];
        return cell;
    }else if (indexPath.section == 3){
        //评价列表
        CommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentListCell"];
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 400;
    }
    return 0.01;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"MerchaintHeaderView"owner:self options:nil];
        self.mHeaderView = [nibView objectAtIndex:0];
        return _mHeaderView;
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
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
