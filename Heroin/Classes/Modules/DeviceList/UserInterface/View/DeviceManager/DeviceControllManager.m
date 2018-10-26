//
//  DeviceControllManager.m
//  Heroin
//
//  Created by Benson on 2018/10/10.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "DeviceControllManager.h"
#import "CordovaViewController.h"

@interface DeviceControllManager()

@end

@implementation DeviceControllManager

+ (DeviceControllManager *)sharedInstance {
    static DeviceControllManager *Manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Manager = [[DeviceControllManager alloc] init];
    });
    return Manager;
}


- (UIViewController *)deviceDiverter:(id)device Platform:(Platform)platfrom{
    
    UIViewController *UIVC;
    switch (platfrom) {
        case PlatformBroadLink:{
            UIVC = [[CordovaViewController alloc] init];
        }break;
            
        default:
            break;
    }
    return UIVC;
}




@end
