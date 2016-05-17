//
//  ShopTableViewCell.h
//  MeiGrounp
//
//  Created by student on 16/4/24.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Shop;
#define kHeight 120.f*kScalWidth
@interface ShopTableViewCell : UITableViewCell
@property (retain,nonatomic) Shop *shop;
@end
/*
 phone": "0371-86613280/15538169315",
 "latestWeekCoupon": 15,
 "payInfo": {
 "iUrl": "imeituan://www.meituan.com/web/?url=http://i.meituan.com/zpay/1362664",
 "validity": 1,
 "data": [{
 "endtime": 1464105599,
 "rangetype": 2,
 "jumpPayCode": false,
 "begintime": 1448624979,
 "hasrangenote": 0,
 "dayrange": "",
 "type": 1,
 "subsource": 0,
 "specialdate": "",
 "discount": "2980-1",
 "id": 185504,
 "present": "",
 "hourrange": "00:00-24:00",
 "title": "每满2980减1",
 "ticket": "0-1",
 "sales": 6,
 "timetips": "（00:00-24:00）",
 "sourcetype": 0
 }]
 },
 "cityId": 73,
 "location": "",
 "addr": "金水区花园路与三全路交叉口向北200米（金泰城灯饰广场对面,北环村路与花园路交口向西200米路南）",
 "ktvAppointStatus": 0,
 "brandName": "东方巴黎",
 "brandId": 127228,
 "isSuperVoucher": 0,
 "poiid": "1362664",
 "groupInfo": 3,
 "showType": "married",
 "bizloginid": 1,
 "parkingInfo": "免费提供10个停车位",
 "brandLogo": "",
 "extra": {
 "icons": ["http://p1.meituan.net/tuanpic/maidanicon.png"]
 },
 "preTags": [],
 "isSnack": false,
 "discount": "1.4折起",
 "frontImg": "http://p1.meituan.net/w.h/mogu/99c09c63e6b00c3df8c4967dd3cf79a7119528.jpg",
 "historyCouponCount": 1537,
 "avgPrice": 0,
 "floor": "",
 "avgScore": 5,
 "dayRoomSpan": 1,
 "lowestPrice": 2280,
 "introduction": "",
 "isExclusive": false,
 "payAbstracts": [{
 "abstract": "每满2980减1（买单立享）",
 "icon_url": "http://p0.meituan.net/tuanpic/discount.png",
 "type": "promotions"
 }, {
 "abstract": "2980元婚纱照人气套餐1份，3980元个人订制婚纱照，2280元东方巴黎婚纱摄影高性价比套餐",
 "icon_url": "http://p1.meituan.net/tuanpic/group_ia_tuan_01.png",
 "type": "group"
 }],
 "markNumbers": 445,
 "lng": 113.675896,
 "areaId": 166,
 "subwayStationId": "",
 "preferent": false,
 "campaignTag": "",
 "isSupportAppointment": false,
 "referencePrice": 0,
 "style": "",
 "featureMenus": "",
 "name": "东方巴黎婚纱摄影机构",
 "hourRoomSpan": 0,
 "notice": "",
 "lat": 34.832994,
 "isWaimai": 0,
 "ktvLowestPrice": -1,
 "isHot": 0,
 "mallId": 0,
 "hasGroup": true,
 "cates": "20178,29,20198,396",
 "zlSourceType": -1,
 "chooseSitting": false,
 "isImax": false,
 "wifi": true,
 "ktv": {
 "ktvPromotionMsg": "",
 "ktvIUrl": "",
 "ktvLowestPrice": -1,
 "ktvIconURL": "",
 "tips": "",
 "ktvAppointStatus": 0,
 "ktvAbstracts": []
 },
 "abstracts": {
 "group": "2980元婚纱照人气套餐1份，3980元个人订制婚纱照，2280元东方巴黎婚纱摄影高性价比套餐",
 "coupon": ""
 },
 "allowRefund": 0,
 "areaName": "省电视台/北站",
 "iUrl": "",
 "openInfo": "8:30-19:30",
 "isQueuing": 0,
 "tour": {
 "tourPlaceName": "",
 "tourInfo": "",
 "tourDetailDesc": "",
 "tourOpenTime": "",
 "tourMarketPrice": -1,
 "tourPlaceStar": ""
 },
 "channel": "",
 "cateId": -9999,
 "hallTypes": [],
 "cateName": "影楼"
 */