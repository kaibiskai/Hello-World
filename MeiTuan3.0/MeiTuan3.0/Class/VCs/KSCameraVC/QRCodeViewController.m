//
//  QRCodeViewController.m
//  MeiTuan3.0
//
//  Created by student on 16/5/12.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "QRCodeViewController.h"
#import "KSCamera.h"
#import "QRResultViewController.h"
@interface QRCodeViewController ()
@property (retain,nonatomic) UIImageView *scanView;
@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"二维码扫描";
        KSCamera *camera = [[KSCamera alloc]init];
    [self.view addSubview:camera];
    [camera cameraScanWithCompletion:^(NSString *url) {
        QRResultViewController *VC = [[QRResultViewController alloc]init];
        VC.urlStr = url;
        [self.navigationController pushViewController:VC animated:YES];
    }];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight-K_QR_SIDE)/2)];
    topView.backgroundColor = kTranslucentColor;
    [self.view addSubview:topView];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, (kScreenHeight-K_QR_SIDE)/2, (kScreenWidth-K_QR_SIDE)/2, (kScreenHeight+K_QR_SIDE)/2)];
    leftView.backgroundColor = kTranslucentColor;
    [self.view addSubview:leftView];
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-K_QR_SIDE)/2, (kScreenHeight+K_QR_SIDE)/2, (kScreenWidth+K_QR_SIDE)/2,(kScreenHeight-K_QR_SIDE)/2)];
    bottomView.backgroundColor = kTranslucentColor;
    [self.view addSubview:bottomView];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth+K_QR_SIDE)/2, (kScreenHeight-K_QR_SIDE)/2, K_QR_SIDE, K_QR_SIDE)];
    rightView.backgroundColor = kTranslucentColor;
    [self.view addSubview:rightView];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_border"]];
    imageView.frame = CGRectMake((kScreenWidth-K_QR_SIDE)/2, (kScreenHeight-K_QR_SIDE)/2, K_QR_SIDE, K_QR_SIDE);
    [self.view addSubview:imageView];
    UIImage *image = [UIImage imageNamed:@"scanLine"];
    self.scanView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-K_QR_SIDE)/2, (kScreenHeight-K_QR_SIDE)/2, K_QR_SIDE, image.size.height)];
    self.scanView.image = image;
    [self.view addSubview:self.scanView];
    [self scanLineAnimation];
}
- (void)scanLineAnimation {
    __block QRCodeViewController *weakSelf = self;
    [UIView animateWithDuration:2.5 animations:^{
        _scanView.frame = CGRectMake((kScreenWidth-K_QR_SIDE)/2, (kScreenHeight+K_QR_SIDE)/2-kCut, K_QR_SIDE, _scanView.height);
    } completion:^(BOOL finished) {
        _scanView.frame = CGRectMake((kScreenWidth-K_QR_SIDE)/2, (kScreenHeight-K_QR_SIDE)/2, K_QR_SIDE, _scanView.height);
        [weakSelf scanLineAnimation];
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
