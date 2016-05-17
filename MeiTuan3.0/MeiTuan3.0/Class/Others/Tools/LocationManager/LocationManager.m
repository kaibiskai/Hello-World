//
//  LocationManager.m
//  MeiTuan
//
//  Created by student on 16/5/5.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface LocationManager ()<CLLocationManagerDelegate>
@property (retain,nonatomic) CLLocationManager *manager;
@property (copy,nonatomic) void(^myBlock)(NSString*);
@end
@implementation LocationManager
- (void)locationWithCompletion:(void(^)(NSString*cityName))completion{
    self.manager = [[CLLocationManager alloc]init];
    self.manager.delegate = self;
    if ([[UIDevice currentDevice].systemVersion floatValue] >=8.0) {
        [self.manager requestWhenInUseAuthorization];
    }
    [self.manager startUpdatingLocation];
    if (completion) {
        self.myBlock = completion;
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations firstObject];
    [self gecoderReverseGeocodeWithLocation:location];
    [self.manager stopUpdatingLocation];
}
- (void)gecoderReverseGeocodeWithLocation:(CLLocation*)location {
    CLGeocoder *coder = [[CLGeocoder alloc]init];
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *mark = [placemarks firstObject];
        self.myBlock(mark.locality);
    }];
}
@end
