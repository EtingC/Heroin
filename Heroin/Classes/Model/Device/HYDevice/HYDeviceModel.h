//
//  HYDeviceModel.h
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BLLetCore/BLDNADevice.h>

@interface HYDeviceModel : NSObject

@property (strong, nonatomic, readonly) NSMutableArray<BLDNADevice *> *deviceArray;

+ (HYDeviceModel *)sharedInstance;
//添加设备
- (void)addDeviceToDeviceArray:(BLDNADevice *)device;
//
- (BOOL)deviceHasAddedInDeviceArray:(BLDNADevice *)device;
@end
