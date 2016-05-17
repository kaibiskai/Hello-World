//
//  RegistTwoViewController.m
//  MeiTuan
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "RegistTwoViewController.h"
#import "RegistView.h"
#import "RegistThirdViewController.h"
#import <SMS_SDK/SMSSDK.h>
@interface RegistTwoViewController ()
@property (nonatomic,retain) UITextField *textFiled;
@property (nonatomic,retain) UIButton *commitButton, *sendButton;
@property (copy,nonatomic) NSString *phoneNum;
@property (retain,nonatomic) NSTimer *timer;
@property (assign,nonatomic) int count;
@end

@implementation RegistTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kRGBColor(235, 235, 242, 1);
    self.title = @"获取验证码";
    [self createViews];
    self.phoneNum = [[NSUserDefaults standardUserDefaults]objectForKey:@"account"];
    self.count = 60;
}
- (void)createViews {
    RegistView *registView = [[RegistView alloc]initWithIndex:1];
    [self.view addSubview:registView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, registView.y+registView.height+kCellHeight, kScreenWidth, kCellHeight)];
    view.backgroundColor = kWhiteColor;
    [self.view addSubview:view];
    self.textFiled = [[UITextField alloc]init];
    self.textFiled.center = CGPointMake(kScreenWidth/4, view.center.y);
    self.textFiled.bounds = CGRectMake(0, 0, kScreenWidth/2-2*kCut, 2*kCut);
    self.textFiled.placeholder = @"请输入短信验证码";
    self.textFiled.font = [UIFont systemFontOfSize:15];
    [self.textFiled addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.textFiled];
    self.sendButton = [UIButton buttonWithTitle:@"重新获取(60s)" imageNamed:nil target:self action:@selector(sendButtonClick:)];
    self.sendButton.frame = CGRectMake(kScreenWidth/2+kCut, view.y, kScreenWidth/2-2*kCut, view.height);
    [self.view addSubview:self.sendButton];
    self.sendButton.enabled = NO;
    self.sendButton.backgroundColor = [UIColor lightGrayColor];
    self.commitButton = [UIButton buttonWithTitle:@"提交验证码" imageNamed:nil target:self action:@selector(commitButtonClick)];
    self.commitButton.frame = CGRectMake(kCut, view.y+view.height+kCut, kScreenWidth-2*kCut, view.height);
    self.commitButton.backgroundColor = [UIColor lightGrayColor];
    self.commitButton.enabled = NO;
    [self.view addSubview:self.commitButton];
}
#pragma mark--倒计时countDown
- (void)countDown {
    self.count--;
    if (self.count==0) {
        [self.sendButton setTitle:@"重新获取" forState:UIControlStateNormal];
        self.sendButton.enabled = YES;
        self.sendButton.backgroundColor = kDefaulsColor;
        [self.timer invalidate];
        self.timer = nil;
    }else {
      [self.sendButton setTitle:[NSString stringWithFormat:@"重新获取(%ds)",self.count] forState:UIControlStateNormal];
    }
}
#pragma mark--textFieldTextChange
- (void)textChange:(UITextField*)sender {
    self.commitButton.enabled = (sender.text.length>0);
    self.commitButton.backgroundColor = (sender.text.length>0)?kDefaulsColor:[UIColor lightGrayColor];
}
#pragma mark--sendButtonClick
- (void)sendButtonClick:(UIButton*)sender {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNum zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (error) {
            [OtherTool otherToolFromVC:self presentAlertWithMessage:@"验证码发送失败，请稍后重试！" completion:nil alertType:UIAlertButtonTypeSure];
        }
    } ];
    [sender setTitle:@"重新获取(60s)" forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor lightGrayColor];
    self.count = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}
#pragma mark--commitButtonClick
- (void)commitButtonClick {
    //验证验证码
    [SMSSDK commitVerificationCode:self.textFiled.text phoneNumber:self.phoneNum zone:@"86" result:^(NSError *error) {
        if (!error) {
            //验证成功
            RegistThirdViewController *VC = [[RegistThirdViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }else {
            //验证失败
            [OtherTool otherToolFromVC:self presentAlertWithMessage:@"验证失败" completion:nil alertType:UIAlertButtonTypeSure];
        }
    }];
    
    [self.textFiled resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
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
