//
//  RegistViewController.m
//  MeiTuan
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistView.h"
#import "RegistTwoViewController.h"
#import "User.h"
#import <SMS_SDK/SMSSDK.h>
@interface RegistViewController ()
@property (retain,nonatomic) UIButton *button;
@property (retain,nonatomic) UIButton *bottomButton;
@property (retain,nonatomic) UITextField *textField;
@end

@implementation RegistViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    self.view.backgroundColor = kRGBColor(235, 235, 242, 1);
    [self createViews];
}
#pragma mark--createViews
- (void)createViews {
    RegistView *view = [[RegistView alloc]initWithIndex:0];
    [self.view addSubview:view];
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, kNavHeight+kCellHeight+kCut, kScreenWidth, kCellHeight)];
    bgview.backgroundColor = kWhiteColor;
    [self.view addSubview:bgview];
    self.textField = [[UITextField alloc]init];
    self.textField.center = bgview.center;
    self.textField.bounds = CGRectMake(0, 0, kScreenWidth-2*kCut, 2*kCut);
    self.textField.placeholder = @"输入手机号";
    self.textField.font = [UIFont systemFontOfSize:15];
    [self.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.textField];
    self.textField.keyboardType = UIKeyboardTypePhonePad;
    self.button = [UIButton buttonWithTitle:@"获取验证码" imageNamed:nil target:self action:@selector(getNum)];
    self.button.frame =CGRectMake(kCut, bgview.height+bgview.y+kCut, kScreenWidth-2*kCut, kCellHeight);
    self.button.enabled=NO;
    self.button.backgroundColor = [UIColor lightGrayColor];
    
    
    [self.view addSubview:self.button];
    self.bottomButton = [UIButton buttonWithTitle:nil imageNamed:@"icon_dropdown_selected" target:self action:@selector(bottomClick:)];
    self.bottomButton.frame =CGRectMake(kCut, self.button.y+self.button.height+kCut, 0, 0);
    
    [self.bottomButton setFontSize:15];
    
    [self.bottomButton setImage:[UIImage imageNamed:@"paybill_coupon_normal"] forState:UIControlStateSelected];
    
    [self.view addSubview:self.bottomButton];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.bottomButton.x+self.bottomButton.width+kCut, self.bottomButton.y, 0, self.bottomButton.height)];
    label.text = @"我已阅读并同意";
    label.font = [UIFont systemFontOfSize:15];
    label.width = [label.text widthWithFontSize:15];
    [self.view addSubview:label];
    
    UIButton *rightButton =[UIButton buttonWithTitle:@"《美团网用户协议》" imageNamed:nil target:self action:@selector(rightButon)];
  rightButton.frame = CGRectMake(label.x+label.width, self.bottomButton.y, 0, self.bottomButton.height);
    rightButton.fontSize = 15;
    [rightButton setTitleColor:kDefaulsColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:rightButton];
}
#pragma mark--jdust
- (void)textChange:(UITextField*)sender {
    [self jdust];
}
- (void)bottomClick:(UIButton*)sender {
    sender.selected = !sender.selected;
    [self jdust];
}
- (void)jdust {
    BOOL jdust =self.textField.text.length==11&&!self.bottomButton.selected;
    self.button.enabled =jdust;
    self.button.backgroundColor = (jdust)?kDefaulsColor:[UIColor lightGrayColor];
}
#pragma mark--getNumButton
- (void)getNum{
    [self.textField resignFirstResponder];
    [User registWithAccount:self.textField.text completion:^(BOOL succeed) {
        
        
        //ToDo:987654
        
        
        
        if (succeed) {
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.textField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
                if (!error) {
                    //验证码发送成功
                    RegistTwoViewController *VC = [[RegistTwoViewController alloc]init];
                    [self.navigationController pushViewController:VC animated:YES];
                    [[NSUserDefaults standardUserDefaults]setObject:self.textField.text forKey:@"account"];
                }else {
                    [OtherTool otherToolFromVC:self presentAlertWithMessage:@"验证码发送失败，请稍后重试！" completion:nil alertType:UIAlertButtonTypeSure];
                }
            } ];
        }else {
            [OtherTool otherToolFromVC:self presentAlertWithMessage:@"该账号已被注册，请更换号码重试" completion:nil alertType:UIAlertButtonTypeSure];
        }
    }];
}
#pragma mark--agreementButton
- (void)rightButon {
    //进入WebView页面
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
