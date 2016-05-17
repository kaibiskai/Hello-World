//
//  RegistThirdViewController.m
//  MeiTuan
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "RegistThirdViewController.h"
#import "RegistView.h"
#import "User.h"
@interface RegistThirdViewController ()
@property (nonatomic,retain)NSMutableArray *textFields;
@end

@implementation RegistThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kRGBColor(235, 235, 242, 1);
    self.title = @"输入密码";
    [self createViews];
}
#pragma mark--createViews
- (void)createViews {
    RegistView *view = [[RegistView alloc]initWithIndex:2];
    [self.view addSubview:view];
    self.textFields = @[].mutableCopy;
    NSArray *arr = @[@"输入密码",@"再次输入密码"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kNavHeight+kCut+kCellHeight, kScreenWidth, 8*kCut)];
    imageView.image = [UIImage imageNamed:@"login_background"];
    [self.view addSubview:imageView];
    for (int i =0; i<arr.count; i++) {
        UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(kCut, imageView.y+kCut+4*kCut*i, kScreenWidth-2*kCut, kCut*2)];
        textFiled.placeholder = arr[i];
        textFiled.secureTextEntry = (i==1)?YES:NO;
        [self.view addSubview:textFiled];
        [self.textFields addObject:textFiled];
    }
    UIButton *button = [UIButton buttonWithTitle:@"注册" imageNamed:nil target:self action:@selector(registButton)];
    button.frame = CGRectMake(kCut, imageView.y+imageView.height+kCut, kScreenWidth-2*kCut, kCellHeight);
    [button setFontSize:20];
    button.backgroundColor = kDefaulsColor;
    [self.view addSubview:button];
}
#pragma mark--registButton
- (void)registButton {
    UITextField *first = self.textFields[0];
    UITextField *second = self.textFields[1];
    if (first.text.length<6||second.text.length<6) {
        [OtherTool otherToolFromVC:self presentAlertWithMessage:@"密码少于6位，重新输入" completion:nil alertType:UIAlertButtonTypeSure];
        return;
    }
    if (first.text.length>5&&[first.text isEqualToString:second.text]) {
        [User registWithPsw:first.text completion:^{
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    }else {
        [OtherTool otherToolFromVC:self presentAlertWithMessage:@"两次密码输入不一致" completion:nil alertType:UIAlertButtonTypeSure];
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
