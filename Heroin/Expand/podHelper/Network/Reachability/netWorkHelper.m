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
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"网络不通：%@",@(status) );
            }break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"网络通过WIFI连接：%@",@(status));
            }break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"网络通过无线连接：%@",@(status) );
            }break;
            default:
                break;
        }

        NSLog(@"网络状态返回: %@", AFStringFromNetworkReachabilityStatus(status));
        NSLog(@"isReachable: %@",@([AFNetworkReachabilityManager sharedManager].isReachable));
        NSLog(@"isReachableViaWWAN: %@",@([AFNetworkReachabilityManager sharedManager].isReachableViaWWAN));
        NSLog(@"isReachableViaWiFi: %@",@([AFNetworkReachabilityManager sharedManager].isReachableViaWiFi));
    }];
    [afNetworkReachabilityManager startMonitoring];  //开启网络监视器；
}


@end
