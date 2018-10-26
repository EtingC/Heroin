//
//  netWorkHelper.m
//  Heroin
//
//  Created by Benson on 2018/7/24.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "netWorkHelper.h"

@implementation netWorkHelper

+ (void)CheckTheNetChange {
    
    DDLogInfo(@"CheckTheNetChange  ^_^!");
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                [MBProgressHUD showAutoMessage:@"当前网络连接失败，请查看设置"];
                DDLogInfo(@"网络不通：%@",@(status) );
            }break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                DDLogInfo(@"网络通过WIFI连接：%@",@(status));
            }break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                DDLogInfo(@"网络通过无线连接：%@",@(status) );
            }break;
            default:
                break;
        }
    }];
    [afNetworkReachabilityManager startMonitoring];  //开启网络监视器；
}


@end
