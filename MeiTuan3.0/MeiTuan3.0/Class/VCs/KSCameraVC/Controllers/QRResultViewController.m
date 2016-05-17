//
//  QRResultViewController.m
//  MeiTuan3.0
//
//  Created by student on 16/5/12.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "QRResultViewController.h"

@interface QRResultViewController ()<UIWebViewDelegate>

@end

@implementation QRResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc]initWithFrame:kScreenBounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    webView.delegate = self;
    [self.view addSubview:webView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setUpNavWithTitle:title];
}
- (void)setUpNavWithTitle:(NSString*)title {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(leftBarButtonClick) withTitle:title imageNamed:@"btn_backItem_center" type:UIButtonImageLeft];
    [self.navigationItem.leftBarButtonItem setTitleColor:kBlackColor forState:UIControlStateNormal];
}
- (void)leftBarButtonClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
