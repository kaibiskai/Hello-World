//
//  KSTabController.m
//  MeiTuan3.0
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "KSTabController.h"
#import "KSNavController.h"
#import "HomeViewController.h"
#import "MerchantViewController.h"
#import "MineViewController.h"
#import "MiscViewController.h"
@interface KSTabController ()

@end

@implementation KSTabController
+(void)initialize {
    NSDictionary *normalDic =@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:kBlackColor};
    NSDictionary *selectedDic = @{NSForegroundColorAttributeName:kDefaulsColor,NSFontAttributeName:[UIFont systemFontOfSize:14]};
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadChildViewController];
}
- (void)loadChildViewController {
    HomeViewController *home = [[HomeViewController alloc]init];
    [self addChildViewController:home withTitle:@"首页" imageNamed:@"homepage"];
    MerchantViewController *merchant = [[MerchantViewController alloc]init];
    [self addChildViewController:merchant withTitle:@"商家" imageNamed:@"merchant"];
    MineViewController *mine = [[MineViewController alloc]init];
    [self addChildViewController:mine withTitle:@"我的" imageNamed:@"mine"];
    MiscViewController *misc = [[MiscViewController alloc]init];
    [self addChildViewController:misc withTitle:@"更多" imageNamed:@"misc"];
}
-(void)addChildViewController:(UIViewController *)childController withTitle:(NSString*)title imageNamed:(NSString*)name {
    KSNavController *nav = [[KSNavController alloc]initWithRootViewController:childController];
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_tabbar_%@",name]];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"icon_tabbar_%@_selected",name]];
    childController.navigationItem.leftBarButtonItem = nil;
    [self addChildViewController:nav];
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
