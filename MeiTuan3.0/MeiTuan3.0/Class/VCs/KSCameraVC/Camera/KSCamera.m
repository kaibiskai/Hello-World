//
//  KSCamera.m
//  MeiTuan3.0
//
//  Created by student on 16/5/12.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "KSCamera.h"
#import <AVFoundation/AVFoundation.h>

@interface KSCamera ()<AVCaptureMetadataOutputObjectsDelegate>

//AVCaptureDevice 代表了物理捕捉设备，比如摄像头，用来配置底层硬件设置相机的自动对焦模式
@property(nonatomic,strong)AVCaptureDevice *device;

//AVCaptureDeviceInput 是AVCaptureInput的子类，可以作为输入的捕获对话，用AVCaptureDevice来进行实例初始化
@property(nonatomic,strong)AVCaptureDeviceInput *input;

//AVCaptureMetadataOutputObjectsDelegate 捕捉的对象传递一个委托信息，给AVCaptureMetadataOutput一个协议方法，这个代理要在一个指定的队列中执行，处理输出的捕捉对话
@property(nonatomic,strong)AVCaptureMetadataOutput *output;

//AVCaptureSession 管理输入AVCaptureDeviceInput和输出AVCaptureMetadataOutput流，包含开启和停止
@property(nonatomic,strong)AVCaptureSession *session;

//AVCaptureVideoPreviewLayer 是CALayer的一个子类，用来显示捕获到的相机的输出流
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic,copy) void(^block)(NSString*);
@end

@implementation KSCamera
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = kScreenBounds;
        [self qrCodeScanning];
    }
    return self;
}
- (void)qrCodeScanning {
    NSError *error;
    
    //获取AVCaptureDevice实例
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //初始化输入流(从AVCaptureDevice中获取数据)
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    
    //初始化输出流
    self.output = [[AVCaptureMetadataOutput alloc] init];
    //output对象创建的实例来实现委托协议的开启
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //管理
    self.session = [[AVCaptureSession alloc] init];
    [self.session startRunning];
    //设置摄像头的清晰度
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    //判断input和output是否可以添加到session中,如果可以添加则添加，
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    
    //条码类型
    _output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode];
    [_output setRectOfInterest:CGRectMake( (kScreenHeight-K_QR_SIDE)/2/kScreenHeight,(kScreenWidth-K_QR_SIDE)/2/kScreenWidth,  K_QR_SIDE/kScreenHeight,K_QR_SIDE/kScreenWidth)];
    //show
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    //AVLayerVideoGravityResizeAspectFill 保持长宽比，填充图层，当设置此属性时可以使用AVPlayerLayer或AVCaptureVideoPreviewLayer实例的属性
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = CGRectMake(0, kNavHeight, kScreenWidth, kScreenHeight-kNavHeight);
    [self.layer addSublayer:self.previewLayer];

    
}
#pragma mark-----------AVCaptureMetadataOutputObjectsDelegate
//获取捕捉数据
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *str;
    if (metadataObjects.count >0)
    {
        AVMetadataMachineReadableCodeObject *object = [metadataObjects objectAtIndex:0];
        str = object.stringValue;
        self.block(str);
    }
    [self.session stopRunning];
}
- (void)cameraScanWithCompletion:(void(^)(NSString*))completion {
    if (completion) {
        self.block = completion;
    }
}
@end
