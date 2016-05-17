//
//  CountDownView.m
//  MeiTuan3.0
//
//  Created by student on 16/5/14.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "CountDownView.h"
#define labelCount 3
#define separateLabelCount 2
#define padding 5
@interface CountDownView (){
    // 定时器
    NSTimer *timer;
}
@property (nonatomic,strong)NSMutableArray *separateLabelArrM;
// hour
@property (nonatomic,strong)UILabel *hourLabel;
// minues
@property (nonatomic,strong)UILabel *minuesLabel;
// seconds
@property (nonatomic,strong)UILabel *secondsLabel;
@end
@implementation CountDownView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.width = 10*kCut;
        self.height = 2*kCut;
        [self addSubview:self.hourLabel];
        [self addSubview:self.minuesLabel];
        [self addSubview:self.secondsLabel];
        
        for (NSInteger index = 0; index < labelCount-1; index ++) {
            UILabel *separateLabel = [[UILabel alloc] init];
            separateLabel.text = @":";
            separateLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:separateLabel];
            [self.separateLabelArrM addObject:separateLabel];
        }
    }
    return self;
}
- (void)setTimeTravel:(NSInteger)timeTravel {
    if (_timeTravel != timeTravel) {
        _timeTravel = timeTravel;
        if (_timeTravel != 0) {
            timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        }
    }
}
-(void)timer:(NSTimer*)timerr{
    _timeTravel--;
    [self getDetailTimeWithTimestamp:_timeTravel];
    if (_timeTravel == 0) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)getDetailTimeWithTimestamp:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    // 剩余的
    NSInteger hour = ms  / hh;// 时
    NSInteger minute = (ms - hour * hh) / mi;// 分
    NSInteger second = (ms - hour * hh - minute * mi) / ss;// 秒
    self.hourLabel.text = [NSString stringWithFormat:@"%zd",hour];
    self.minuesLabel.text = [NSString stringWithFormat:@"%zd",minute];
    self.secondsLabel.text = [NSString stringWithFormat:@"%zd",second];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 单个label的宽高
    self.hourLabel.frame = CGRectMake(0, 0, 3*kCut, self.height);
    self.minuesLabel.frame = CGRectMake(3.5*kCut , 0, 3*kCut, self.height);
    self.secondsLabel.frame = CGRectMake(7*kCut, 0, 3*kCut, self.height);
    
    for (int i = 0; i < labelCount-1; i++) {
        UILabel *separateLabel = self.separateLabelArrM[i];
        separateLabel.frame = CGRectMake(3*kCut+3.5*kCut*i, 0, kCut/2, self.height);
    }
}
#pragma mark - setter & getter
- (NSMutableArray *)separateLabelArrM{
    if (_separateLabelArrM == nil) {
        _separateLabelArrM = [[NSMutableArray alloc] init];
    }
    return _separateLabelArrM;
}
- (UILabel *)hourLabel{
    if (_hourLabel == nil) {
        _hourLabel = [[UILabel alloc] init];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        _hourLabel.font = [UIFont systemFontOfSize:12];
    }
    return _hourLabel;
}

- (UILabel *)minuesLabel{
    if (_minuesLabel == nil) {
        _minuesLabel = [[UILabel alloc] init];
        _minuesLabel.textAlignment = NSTextAlignmentCenter;
        _minuesLabel.font = [UIFont systemFontOfSize:12];
    }
    return _minuesLabel;
}

- (UILabel *)secondsLabel{
    if (_secondsLabel == nil) {
        _secondsLabel = [[UILabel alloc] init];
        _secondsLabel.textAlignment = NSTextAlignmentCenter;
        _secondsLabel.font = [UIFont systemFontOfSize:12];
    }
    return _secondsLabel;
}

@end
