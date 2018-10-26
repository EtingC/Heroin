//
//  DeviceControllManager.h
//  Heroin
//
//  Created by Benson on 2018/10/10.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceControllManager : NSObject

+ (DeviceControllManager *)sharedInstance;

- (UIViewController *)deviceDiverter:(id)device Platform:(Platform)platfrom;

@end
