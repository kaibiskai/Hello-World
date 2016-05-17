//
//  KSNavController.m
//  MeiTuan3.0
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "KSNavController.h"

@interface KSNavController ()

@end

@implementation KSNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(back) withTitle:nil imageNamed:@"btn_backItem" type:UIButtonImageLeft];
    [super pushViewController:viewController animated:YES];
}
- (void)back {
    if (self.viewControllers.count>1) {
        [super popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
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
