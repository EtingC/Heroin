//
//  BroadlinkManager.m
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BroadlinkManager.h"

@interface BroadlinkManager()<BLControllerDelegate>

@end

@implementation BroadlinkManager

+ (BroadlinkManager *)sharedManager
{
    static BroadlinkManager *deviceInfoManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        deviceInfoManager = [[self alloc] init];
        NSString * licenseID = [[NSUserDefaults standardUserDefaults] objectForKey:LicenseID];
        NSString * companyID = [[NSUserDefaults standardUserDefaults] objectForKey:CompanyID];
        deviceInfoManager.account = [BLAccount sharedAccountWithConfigParam:licenseID CompanyId:companyID];
        deviceInfoManager.familyManager = [BLFamilyController sharedManagerWithConfigParam:licenseID];
        deviceInfoManager.let.configParam.controllerScriptDownloadVersion = 1;
    });
    return deviceInfoManager;
}


- (void)loadAppSdk {
    
    self.let = [BLLet sharedLetWithLicense:LiangBaSDSLicense];        // Init APPSDK
    self.let.debugLog = BL_LEVEL_NONE;                           // Set APPSDK debug log level
    [self.let.controller setSDKRawDebugLevel:BL_LEVEL_NONE];     // Set DNASDK debug log level
    [self.let.controller startProbe:3000];                           // Start probe device
    self.let.controller.delegate = self;
    self.let.configParam.controllerSendCount = 2;
    
    NSString  *licenseID = self.let.configParam.licenseId;
    NSString  *companyID = self.let.configParam.companyId;
    [[NSUserDefaults standardUserDefaults] setObject:licenseID forKey:LicenseID];
    [[NSUserDefaults standardUserDefaults] setObject:companyID forKey:CompanyID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


#pragma mark - BLControllerDelegate
- (Boolean)filterDevice:(BLDNADevice *)device {
    return NO;
}
- (Boolean)shouldAdd:(BLDNADevice *)device {
    return YES;
}
- (void)onDeviceUpdate:(BLDNADevice *)device isNewDevice:(Boolean)isNewDevice {

    
    if (isNewDevice) {
        NSLog(@"[device]%@--%@",device.name,device.did);
//        if ([[LiangBaDevice sharedInstance]deviceHasAddedInDeviceArray:device] == NO) {
//            NSLog(@"加入家庭的控制key000：%@",device.controlKey);
//            [[LiangBaDevice sharedInstance] addDeviceToDeviceArray:device];
//        }
    }
}

@end
