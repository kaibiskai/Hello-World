//
//  LoginViewController.m
//  MeiTuan
//
//  Created by student on 16/5/8.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTableViewCell.h"
#import "RegistViewController.h"
#import "User.h"
@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (retain,nonatomic) UITableView *tableView;
@property (retain,nonatomic) NSMutableArray *dataArr,*textFileds;
@property (retain,nonatomic) UIView *bgView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kRGBColor(235, 235, 242, 1);
    [self setUpNav];
    [self createViews];
    [self createTableView];
}
#pragma mark--setUpNav
- (void)setUpNav {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(rightBarButtonClick) withTitle:@"注册" imageNamed:nil type:UIButtonImageNormal];
    [self.navigationItem.rightBarButtonItem setTitleColor:kDefaulsColor forState:UIControlStateNormal];
}
#pragma mark--rightBarButtonClick
- (void)rightBarButtonClick {
    RegistViewController *VC = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--createViews

- (void)createViews {
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 6*kNavHeight+kCut, kScreenWidth,19*kCut);//为测试键盘上跳功能，将y坐标改为了6*kNavHeight+kCut，实际为kNavHeight+kCut
    self.textFileds = @[].mutableCopy;
    NSArray *arr = @[@"手机/邮箱/用户名",@"密码"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8*kCut)];
    imageView.image = [UIImage imageNamed:@"login_background"];
    [view addSubview:imageView];
    for (int i =0; i<arr.count; i++) {
        UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(kCut, imageView.y+kCut+4*kCut*i, kScreenWidth-2*kCut, kCut*2)];
        textFiled.placeholder = arr[i];
        textFiled.secureTextEntry = (i==1)?YES:NO;
        textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        textFiled.returnKeyType = UIReturnKeyDone;
        [textFiled addTarget:self action:@selector(keyboardUpDown:) forControlEvents:UIControlEventEditingDidEndOnExit];
        if (i==0) {
            [textFiled addTarget:self action:@selector(searchAccount:) forControlEvents:UIControlEventEditingChanged];
            [textFiled addTarget:self action:@selector(searchAllLoginUsers:) forControlEvents:UIControlEventEditingDidBegin];
        }
        [view addSubview:textFiled];
        [self.textFileds addObject:textFiled];
    }
    //该通知只为测试键盘上跳功能
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chagedKeyboardFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UIButton *button = [UIButton buttonWithTitle:@"登录" imageNamed:nil target:self action:@selector(loginButton)];
    button.frame=CGRectMake(kCut, imageView.y+imageView.height+kCut, kScreenWidth-2*kCut, 4*kCut);
    button.backgroundColor = kDefaulsColor;
    [view addSubview:button];
    UIButton *findPass = [UIButton buttonWithTitle:@"找回密码" imageNamed:nil target:self action:@selector(findPsw)];
    findPass.frame = CGRectMake(kCut, button.y+button.height+2*kCut, 0, 2*kCut);
    [findPass setFontSize:12];
    [findPass setTitleColor:kDefaulsColor forState:UIControlStateNormal];
    findPass.titleLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:findPass];
    UIButton *phone = [UIButton buttonWithTitle:@"使用手机快捷登录" imageNamed:nil target:self action:@selector(phoneLogin)];
    phone.frame = CGRectMake(kCut, button.y+button.height+2*kCut, 0, 2*kCut);
    [phone setFontSize:12];
    [phone setTitleColor:kDefaulsColor forState:UIControlStateNormal];
    phone.x = kScreenWidth-phone.width;
    phone.titleLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:phone];
    [self.view addSubview:view];
    self.bgView = view;
}
#pragma mark--textFiledClick
- (void)keyboardUpDown:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (void)searchAllLoginUsers:(UITextField*)sender {
    if (sender.text.length>0) {
        return;
    }
    self.dataArr = [User allLoginUsers];
    [self reloadTableView];
}
- (void)searchAccount:(UITextField*)sender {
    self.dataArr =(sender.text.length>0)? [User searchLoginUsersWithAccount:sender.text]:[User allLoginUsers];
    [self reloadTableView];
}
-(void)reloadTableView{
    self.tableView.height = self.dataArr.count*kCellHeight;
    [self.tableView reloadData];
}
#pragma mark--loginButton
- (void)loginButton {
    User *user = [User matchPswWithAccount:[self.textFileds[0] text] psw:[self.textFileds[1] text]];
    if (user) {
        [user becomeLoginUser];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else {
        [OtherTool otherToolFromVC:self presentAlertWithMessage:@"账号或密码错误，请重试" completion:nil alertType:UIAlertButtonTypeSure];
    }
}
#pragma mark--bottomButtonClick
- (void)findPsw {
    
}
- (void)phoneLogin {
    
}
#pragma mark--createTableView
- (void)createTableView {
    self.dataArr = @[].mutableCopy;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(kCut, 5*kCut+kNavHeight, kScreenWidth-2*kCut, 0) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = kDefaulsColor;
    [self.tableView registerClass:[LoginTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}
#pragma mark--tableView.dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.user = self.dataArr[indexPath.row];
    [cell deleteItemWithCompletion:^(User *user) {
        [self.dataArr removeObject:user];
        [self reloadTableView];
        [user loseLoginUser];
    }];
    return cell;
}
#pragma mark--tableView.delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User *user = self.dataArr[indexPath.row];
    UITextField *account = self.textFileds[0];
    account.text = user.account;
    UITextField *psw = self.textFileds[1];
    psw.text = user.psw;
    [self.dataArr removeAllObjects];
    [self reloadTableView];
}
#pragma mark--UIKeyboardWillChangeFrameNotification
- (void)chagedKeyboardFrame:(NSNotification*)noti {
    NSValue *value = noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    CGRect rect = [value CGRectValue];
    float pointY = rect.origin.y;
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.frame = CGRectMake(0, pointY-self.bgView.height, kScreenWidth, self.bgView.height);
    }];
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
