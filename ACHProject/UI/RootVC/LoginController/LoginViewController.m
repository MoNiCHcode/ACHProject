
//
//  LoginViewController.m
//  CFArchitecture
//
//  Created by Mr.Guo on 2017/8/28.
//  Copyright © 2017年 Mr.Guo. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
    BOOL isPswLogin;//是否为密码登录
    __weak IBOutlet UIButton *codeLoginBtn;
    __weak IBOutlet UIButton *pswLoginBtn;
    __weak IBOutlet NSLayoutConstraint *contentHeight;
    
    //以下第二行的一大堆视图
    __weak IBOutlet UIButton *picCodeBtn;
    __weak IBOutlet UIImageView *secondLogo;
    __weak IBOutlet UITextField *secondTF;
    
    
    //以下第三行的一大堆视图
    __weak IBOutlet UIImageView *thirdLogo;
    __weak IBOutlet UIView *thirdLineVertical;
    __weak IBOutlet UIView *thirdLine;
    __weak IBOutlet UIButton *codeBtn;
    __weak IBOutlet UITextField *thirdTF;
    
    
    __weak IBOutlet UIButton *forgetPswBtn;
    __weak IBOutlet UILabel *botomLabel;
    __weak IBOutlet UIView *otherLoginView;
    
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self congiureSubviews];
    
}



- (void)congiureSubviews
{
    //图形验证码按钮
    picCodeBtn.layer.borderColor = UIColorFromRGB(0xF5C145).CGColor;
    picCodeBtn.layer.borderWidth = 1;
    [self codeLoginBtnClick:nil];
    
    
    //忘记密码按钮
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"忘记密码"];
    [AttributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, 4)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x999999) range:NSMakeRange(0, 4)];
    [forgetPswBtn setAttributedTitle:AttributedStr forState:UIControlStateNormal];
    
    //第三方登录
    
   // BOOL HasQQ=[QQApiInterface isQQInstalled];
   // BOOL HasWechat=[WXApi isWXAppInstalled];
     BOOL HasQQ=YES;
     BOOL HasWechat=YES;
    NSArray *imgArr=@[@"微信",@"QQ",@"微博"];
    for (int i=0; i<imgArr.count; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(27+otherLoginView.frame.size.width/imgArr.count*i, 11, 44, 44)];
        btn.tag=10+i;
        [btn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [otherLoginView addSubview:btn];
        
        if (HasWechat==NO&&HasQQ==YES) {
            //微信没有
            if (i==1) {
                UIButton *Wechatbtn=[otherLoginView viewWithTag:10];
                [Wechatbtn removeFromSuperview];
                btn.frame=CGRectMake(27, 11, 44, 44);
            }
        }else if (HasQQ==NO&&HasWechat==YES){
            //qq没有
            if (i==1) {
                UIButton *QQbtn=[otherLoginView viewWithTag:11];
                [QQbtn removeFromSuperview];
                btn.frame=CGRectMake(27, 11, 44, 44);
            }
            
        }else if (HasWechat==NO&&HasQQ==NO) {
            if (i==2) {
                UIButton *Wechatbtn=[otherLoginView viewWithTag:10];
                [Wechatbtn removeFromSuperview];
                UIButton *QQbtn=[otherLoginView viewWithTag:11];
                [QQbtn removeFromSuperview];
                btn.frame=CGRectMake(27+otherLoginView.frame.size.width/imgArr.count, 11, 44, 44);
            }
            
        }
        
    }
    
    
}

#pragma mark - 第三方登录
-(void)clickLogin:(UIButton *)sender{
    switch (sender.tag) {
        case 10:
        {
            //微信登录
        }
            break;
        case 11:
        {
            //QQ登录
        }
            break;
        case 12:
        {
            //微博登录
        }
            break;
        default:
            break;
    }
}

#pragma mark - 验证码登录
- (IBAction)codeLoginBtnClick:(id)sender {
    isPswLogin = NO;
    codeLoginBtn.selected = YES;
    pswLoginBtn.selected  = NO;
    contentHeight.constant = 330;
    thirdTF.hidden = thirdLine.hidden =thirdLogo.hidden = botomLabel.hidden=
    thirdLineVertical.hidden = codeBtn.hidden = picCodeBtn.hidden = NO;
    secondTF.placeholder = @"图形验证码";
    secondLogo.image = [UIImage imageNamed:@"验证码(2)"];
    forgetPswBtn.hidden = YES;
    
}
#pragma mark - 密码登录
- (IBAction)pswBtnClick:(id)sender {
    isPswLogin = YES;
    codeLoginBtn.selected = NO;
    pswLoginBtn.selected  = YES;
    contentHeight.constant = 280;
    thirdTF.hidden = thirdLine.hidden =thirdLogo.hidden = botomLabel.hidden=
    thirdLineVertical.hidden = codeBtn.hidden = picCodeBtn.hidden =YES;
    secondTF.placeholder = @"请输入密码";
     secondLogo.image = [UIImage imageNamed:@"密码"];
    forgetPswBtn.hidden = NO;
}
- (IBAction)LoginBackAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
