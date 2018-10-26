//
//  BroadLinkDevice.h
//  Heroin
//
//  Created by Benson on 2018/9/20.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BaseDevice.h"
#import "BroadLinkPlugin.h"

@interface BroadLinkDevice : BaseDevice


#pragma mark - 获取云端设备信息

/**
获取 LAN Device

@return LANDevice
*/
+ (NSMutableArray *)getLANDevice;

/**
 获取 Device
 
 @return Device
 */
+ (NSMutableArray *)getDevice;



@end
