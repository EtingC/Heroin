//
//  ProductBriefModel.h
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductBriefModel : NSObject


@property (nonatomic, copy) NSString *brandName;//brandName = broadlink;
@property (nonatomic, copy) NSString *buyUrl;//buyUrl = "https://detail.tmall.com/item.htm?id=522070033742&skuId=3109807532785";
@property (nonatomic, copy) NSString *deviceDescription;//description = "智能手机实时控制查看状态Wi-Fi控制家中电器，小巧精致，是BroadLink目前为止最稳定的一代智能插座产品哦！";
@property (nonatomic, copy) NSString *detailUrl;//detailUrl = "";
@property (nonatomic, copy) NSString *deviceName;//deviceName = "博联SPmini wifi定时器开关插座";
@property (nonatomic, copy) NSString *displayName;//displayName = "";
@property (nonatomic, copy) NSString *icon;//icon = "https://gtms04.alicdn.com/tps/i4/TB1kmWrJFXXXXaGXpXXXXXXXXXX";
@property (nonatomic, copy) NSString *deviceID;//id = 111;
@property (nonatomic, copy) NSString *model;//model = "BROADLINK_LIVING_OUTLET_SPMINI_D";
@property (nonatomic, copy) NSString *price;//price = "59.0";
@property (nonatomic,copy)  NSString *shortModel;

@end
