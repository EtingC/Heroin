//
//  HYDeviceModel.m
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "HYDeviceModel.h"

@interface HYDeviceModel ()
@property (strong, nonatomic, readwrite) NSMutableArray<BLDNADevice *> *deviceArray;

@end
@implementation HYDeviceModel

+ (HYDeviceModel *)sharedInstance {
    static HYDeviceModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[HYDeviceModel alloc] init];
    });
    return sharedInstance;
}

- (NSMutableArray<BLDNADevice *> *)deviceArray {
    if (_deviceArray == nil) {
        _deviceArray = [[NSMutableArray alloc] init];
    }
    
    return _deviceArray;
}

- (void)addDeviceToDeviceArray:(BLDNADevice *)device {
    [self.deviceArray addObject:device];
}

- (BOOL)deviceHasAddedInDeviceArray:(BLDNADevice *)device {
    for (BLDNADevice * Device  in self.deviceArray) {
        if ([Device.did isEqualToString:device.did]) {
            return YES;
        }
    }
    return NO;
}
@end
